![[CSP-13 SmartNIC.pptx]]
## review
#### 传统网络
网络架构
![[Pasted image 20231214100351.png]]
传包流程
![[Pasted image 20231214100405.png]]
#### DPDK
绕过os内核，利用独立模块管理网络包。
![[Pasted image 20231214100625.png]]
#### RDMA（remote direct memory access）
允许设备绕过cpu，可以直接访问内存，且具有低延迟，高带宽等优势。
- Send/complete/receive queue
- post network request to SQ
- completion events from CQ
- receive messages from RQ
![[Pasted image 20231214100905.png]]
## 高性能分布式系统 by RDMA
#### CPU成为性能瓶颈
![[Pasted image 20231214102155.png]]![[Pasted image 20231214102208.png]]
CPU成为性能瓶颈，NIC网卡没有充分利用。


#### 使用RDMA绕过CPU直接访存
![[Pasted image 20231214102922.png]]
#### RDMA-friendly structure——cuckoo hashing
**问题**：RDMA语义较弱，每次读取得到的信息有限。链式遍历查找可能需要多次读取和RDMA传输，实际上效果并不好。
**solution**: RDMA-friendly数据结构：cuckoo hashing——查找比较固定，最多查找三次。
![[Pasted image 20231214105707.png]]
![[Pasted image 20231214105731.png]]
**优化**：一定大小（4K）以下，读取大小对时延影响不大，增大一次读取的大小（如一次性读取buckets0和1），减少读取次数。
![[Pasted image 20231214110154.png]]
**缺陷**：写消耗更大。（场景中写很少，且可以混合读写方法，通过cpu进行写）
#### 不同设备并行读写（OCC保证一致性）
一致性问题 eg：kick过程中进行读写。
锁的问题：1.额外的开销 2.异构设备（CPU/NIC/RDMA）不一致的锁，无法确定一致性。
solution：LOCK-FREE：类似OCC（乐观锁）
![[Pasted image 20231214111322.png]]
![[Pasted image 20231214111341.png]]

#### 充分利用RDMA 
![[Pasted image 20231214112034.png]]
core请求处理与RDMA效率的差距（CPU瓶颈）
![[Pasted image 20231214112607.png]]
并发减少rdma等待
![[Pasted image 20231214112729.png]]

## RDMA 细节
#### out memory design
![[Pasted image 20231219205752.png]]
Q:实现中内存存储了大量connection的大量信息，链接信息，权限信息，地址页表等,占用大量网卡的DRAM.

A:out memory design：将信息存储在host memory。

#### 减少缓存miss
Q:SRAM缓存可能miss，需要通过PCIe read to fetch，影响性能，且阻碍正常的DMA请求通信。
A:对于地址信息，减少页表miss数： 
- 使用大页（主流）
- 直接使用物理内存，利用kernel鉴权（极端，又把kernel tradeoff回来啦！）
### UD on RPC
Q：大规模下链接信息过多，其存不下，不能通过大页减少miss怎么办，如何解决可拓展性问题？
A：采用UD（unreliable datagram），放弃可靠性，仅用two-side，不存connection。（又回到没绕过cpu）
一方面，实际上RDMA丢包率较小（链路层保障与RPC检测，超时可以重传）
另一方面，twe-side RPC 的roundtrips较小。![[Pasted image 20231219211809.png]]
#### 优缺点

![[Pasted image 20231219211831.png]]
A2：NICs的发展，更好的cache管理，流水线处理，PCIe带宽等。


## SmartNICs
one-side绕过cpu但只能进行read和write，难以应对复杂场景--智能网卡！
ASIC FPGA SOC智能网卡异同及优缺点。
https://aijishu.com/a/1060000000205198
![[Pasted image 20231219214645.png]]
#### on-path vs off-path
![[Pasted image 20231219214004.png]]
on-path 不需要switch，速度较快，但所有请求都需要通过 manager。
![[Pasted image 20231219215635.png]]
#### 软件定义 offloading
可以动态配置组件承担的任务
![[Pasted image 20231219214213.png]]
#### smartNIC问题
当offload的任务较重时，可能影响网卡的本职工作性能。