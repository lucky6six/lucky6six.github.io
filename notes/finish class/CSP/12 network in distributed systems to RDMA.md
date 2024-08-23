***分布式系统中需要大量的网络通信***
#### 传统OSI
![[Pasted image 20231218181752.png]]
![[Pasted image 20231218181905.png]]
编写：调用socket，bind，listen，read，write等接口。
linux中的包过程——网络栈：需要消耗大量过栈时间。
![[Pasted image 20231218182030.png]]
传统网络通信方式在ai训练场景下单词网络通信消耗过大。
#### DPDK：kernel-bypassing network
将网络数据包转发到用户应用程序/从 NIC 转发
没有任何内核网络堆栈！绕过kernel
![[Pasted image 20231218182442.png]]
优势：
绕过kernel，传统网络协议栈
减少memcpy开销
可以定制化网络
缺陷：
不兼容传统网络，只能发裸包。
仍需要额外的增加传输层。

## RDMA
#### 概览
将计算网络栈卸载到NIC网卡上。
![[Pasted image 20231219190503.png]]
![[Pasted image 20231219202747.png]]
绕过kernel与协议，远程内存直接访问。
（绕过用户态协议）更适合用硬件实现，可以做到完全卸载到硬件。
#### 实现类别
- IB原生：实现新的协议栈，做好的性能，但不向前兼容，需求特定硬件——IB网卡与IB switch。（更换开销大）
- RoCE-v1:基于link层，在其他层进行新实现。
- RiCE-v2:支持UDP与IP协议，更好的灵活性与可拓展性。（大规模集群广泛采用）
- iWrap:支持广域网的RDMA,基于TCP/IP。（但实际上可以直接TCP，应用不多）
![[Pasted image 20231219191507.png]]
#### 抽象
Queue Pair:pair：类似于匹配（socket）
- send queue(SQ) 用户发来，需要网卡处理的请求
	- two-side：like send/recv
	- one-side: remote / talked later
- complete queue(CQ) 完成请求的结果
- receive queue(RQ) 接受消息的缓存FIFO
- ps:CQ与RQ的实现基本相同。
QP模式：
- RC：可靠链接，类似TCP/IP，支持所有RDMA请求（本节课讨论）需要握手等操作进行匹配链接。
 ![[Pasted image 20231219202241.png]]
- UD：unreliable datapram。不可靠数据报文
#### 通信过程(two-side)
更详细的握手（bring up）过程见ppt12 P73
![[Pasted image 20231219203013.png]]
![[Pasted image 20231219203023.png]]
![[Pasted image 20231219203030.png]]
![[Pasted image 20231219203046.png]]
#### RDMA vs DPDK
**共同点**:绕过kernel
RDMA:全硬件支持，零拷贝。
DPDK:更具灵活，可以客制化网络协议。
#### one-sided RDMA
A hidden assumption of low-latency two-sided RDMA is using **polling**
网络通信没有绕过cpu，网络带宽足够，cpu性能成为瓶颈。-> one-sided RDMA
远程读写普遍，NIC直接完成操作，无需cpu。
NIC具有三种原语read（memory）/write（memory）/atomics（原子执行操作）
![[Pasted image 20231219204749.png]]
![[Pasted image 20231219205049.png]]
问题：直接读写远端内存，如何实现，如何鉴权？
solution：MR(memory registration)
创建internal mapping table来暴露部分虚拟内存，并利用SRAM进行cache，减少查表开销。
