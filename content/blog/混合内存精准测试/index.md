---
title: 混合内存精准测试
summary: summary
date: 2024-10-10
authors:
  - admin
tags:
  - memory
  - config
  - numa
  - docker
image: 
caption: "Image credit: [**Unsplash**](https://unsplash.com)"
commentable: true
---
最近实验室项目有个需求，需要在一台具有混合内存的国产化机器上测试不同内存各自的性能，混合后的性能以及虚拟化的性能并进行对比。整个工具链探索过程比较坎坷，涉及到的知识也挺杂，所以简单复盘一下。
### 国产服务器/OS
![](Pasted%20image%2020241010153039.png)
![](Pasted%20image%2020241010153123.png)
![](Pasted%20image%2020241010153156.png)
### 信息查看
`lsmem lscpu`  简陋的内存/cpu/numa信息
`numastat -m` 常用的numa信息
`Numactl --hardware numa`  节点对应的cpu/内存信息
`lshw -short -C memory` 这条命令会列出所有内存设备的详细信息，包括每条内存的类型、大小和物理位置。

通过各种手段得到机器上的内存种类及位置，后续通过绑定numa节点和cpu的方式隔离不同内存
### docker及其配置（源）
`apt install docker.io`之后，发现docker镜像大面积挂了，找了点小众源先换上（十月份应该好点了）
``` sh
sudo mkdir -p /etc/docker

sudo tee /etc/docker/daemon.json <<-'EOF'
{
"registry-mirrors": ["https://register.liberx.info",
"https://dockerpull.com",
"https://docker.anyhub.us.kg",
"https://dockerhub.jobcher.com",
"https://dockerhub.icu",
"https://docker.awsl9527.cn"]
}
EOF

sudo systemctl daemon-reload
sudo systemctl restart docker
```

docker虚拟化之后就简单ubuntu了,dockerfile如下，简单初始化命令就简单安装一堆，设置个工作目录，建立镜像`docker build -t name path_to_dockerfile`
``` dockerfile
# 使用基础镜像，如 Ubuntu
FROM ubuntu:20.04

# 安装必要的软件包
RUN apt-get update && apt-get install -y \
    libaio1 \
    libaio-dev \
    python3 \
    python3-pip \
    python-is-python3 \
    sysbench \
    numactl

# 设置工作目录
WORKDIR /sysbench_nvm_test

# 默认启动命令，可以根据需求更改
CMD ["/bin/bash"]
```
### 性能测试工具
#### fio
fio本来是文件io到测试工具，但我们可以首先将内存mount到设备目录，然后就可以通过对该目录进行读写间接得到内存性能。
#### sysbench
sysbench为本次选择的内存测试工具。可以通过参数指定操作范围的块大小，总操作量，io访问方式，线程数等，最后输出到log目录中
``` sh

#!/bin/bash
MEM_BLOCK_SIZE=1M
MEM_TOTAL_SIZE=40G
N_THREADS=8

echo "mode: $1"

echo "sequential read..."
sysbench memory \
    --memory-block-size=$MEM_BLOCK_SIZE \
    --memory-total-size=$MEM_TOTAL_SIZE \
    --memory-oper=read \
    --memory-access-mode=seq \
    --threads=$N_THREADS run |
    grep -E 'transferred | avg:' \
        >"log/"$1"_seq_read.log"

echo "sequential write..."
sysbench memory \
    --memory-block-size=$MEM_BLOCK_SIZE \
    --memory-total-size=$MEM_TOTAL_SIZE \
    --memory-oper=write \
    --memory-access-mode=seq \
    --threads=$N_THREADS run |
    grep -E 'transferred | avg:' \
        >"log/"$1"_seq_write.log"

echo "random read..."
sysbench memory \
    --memory-block-size=$MEM_BLOCK_SIZE \
    --memory-total-size=$MEM_TOTAL_SIZE \
    --memory-oper=read \
    --memory-access-mode=rnd \
    --threads=$N_THREADS run |
    grep -E 'transferred | avg:' \
        >"log/"$1"_rand_read.log"

echo "random write..."
sysbench memory \
    --memory-block-size=$MEM_BLOCK_SIZE \
    --memory-total-size=$MEM_TOTAL_SIZE \
    --memory-oper=write \
    --memory-access-mode=rnd \
    --threads=$N_THREADS run |
    grep -E 'transferred | avg:' \
        >"log/"$1"_rand_write.log"

python log_proc.py $1
```
#### stream
stream是内存测试工具，可以通过对数组的计算，拼接，拷贝进行内存带宽测试。
### numa内存结点以及cpu的绑定
> [!tip] 
>  
`taskset`命令用于设置或获取进程的CPU亲和性，控制进程可以在哪些CPU核心上运行。
`taskset [mask] [command]` 以mask范围中的cpu执行command。（1   1,2    0-7）
使用-p可以为已运行的进程添加cpu亲和性或获取已运行的进程的cpu亲和性。

> [!tip] 
>  
`numactl`命令用于控制在NUMA架构上运行的进程的CPU和内存亲和性。基本用法如下：
绑定CPU和内存：
`numactl --cpubind=[cpus] --membind=[nodes] [command]`
设置访问策略： 可以使用--interleave选项在多个内存节点间交错分配内存：即选定的内存不会因系统优化导致内存分配呈现一边倒的倾向性。
`numactl --cpubind=0-3 --interleave=all your_command`
`numactl --show`查看当前的NUMA配置和亲和性设置。
`numactl -H`可以查看系统的NUMA拓扑结构，便于配置。

> [!tip] 
> docker本身也可以通过参数对使用的内存和cpu进行绑定 
> 

- 同时指定了容器名，工作目录映射，交互模式与镜像名，执行程序以及执行命令，注意cmd中的**引号与转义**
- 当需要容器内权限是可以使用 --privileged
- docker参数只是指定了docker容器可以使用的numa节点，但实际运行时仍倾向于使用速度较快的numa节点，因此测试混合内存时仍需要在容器中进行numactl的绑定

``` sh
docker run --cpuset-cpus=$CPU_CORE --cpuset-mems=$NUMA_NODE --name nvm_test_container -v $(pwd):/sysbench_nvm_test -it nvm_test_container /bin/bash -c "/sysbench_nvm_test/run.sh \"$TYPE\""

docker run --privileged --cpuset-cpus=$CPU_CORE --cpuset-mems=$NUMA_NODE --name nvm_test_container -v $(pwd):/sysbench_nvm_test -it nvm_test_container /bin/bash -c "numactl --membind=0,1 /sysbench_nvm_test/run.sh \"$TYPE\""
```

