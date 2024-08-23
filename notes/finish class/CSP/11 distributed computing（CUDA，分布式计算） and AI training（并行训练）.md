![[CSP-11-distributed computing & AI training.pptx]]

## review：parallelism on single device
- 流水线，指令级并行——memory stalls
- SIMD support——为了最优速度，只能执行同一指令
- 多核处理——cache一致性问题
- 特定领域的优化。

## GPU
*目前，GPU的目标由图像渲染转到科学计算/AI训练*
#### GPU并行计算
GPU以高算力位目标被设计，有大量的ALU可以并行执行。（SIMD）
![[Pasted image 20231130101642.png]]
so:GPU缺少控制单元，如何handle（分支预测，跳转等）
#### GPU架构：SIMT
![[Pasted image 20231130101845.png]]
block调度到SM上
block:一组gpu线程
SM：流多处理器，一组ALU核心，有L1cache,有多个warp管理核心（stream process/SP），每个warp中的核心执行相同指令，每个核心有自己的寄存。
#### GPU内存
![[Pasted image 20231130102312.png]]![[Pasted image 20231130102350.png]]
## CUDA编程模型(SIMT)
#### CUDA架构
C语言编写单线程程序

同一block的线程并行执行同一程序,作为在SM上调度的基本调度单元，调度确定后不在迁移。
多个block组成grid(kernel)
![[Pasted image 20231130103010.png]]
每个block被划分为多个32线程warp
每个周期，warp调度器选择准备好的warps，dispatch到CUDA核s上执行。
https://zhuanlan.zhihu.com/p/123170285
![[Pasted image 20231130103236.png]]
#### 控制流
warp中每个线程共享同一程序段，在分支多的情况下也只能顺序执行，（104分支线程等待102线程执行，反之亦然）。
![[Pasted image 20231130103400.png]]
可能会造成deadlock——produce分支等待consume分支，但consume函数需要等待produce函数。
![[Pasted image 20231130103900.png]]

#### 内存 todo
![[Pasted image 20231130104359.png]]
#### 代码撰写
*优秀的cuda代码需要复杂的考量*
- 内存的使用
- 数据放置的方式（行存/列存）
- 线程分组，block，size
- etc.


## 多GPU分布式
#### challenges——need framework
- 数据通信
- 节点协作，依赖顺序等
- 容错恢复
- 局部性利用（如同数据依赖任务分配同一机器）
#### 分布式计算图框架——Dryad
DAG有向无环图：点为计算资源和数据，边为通信渠道，每个点有复数边链接。
![[Pasted image 20231130112253.png]]
Job manager : job schedule
![[Pasted image 20231130112348.png]]
调度与容错![[Pasted image 20231130112430.png]]

## AI models training
### 数据流图（dataflow graph）
**结构**：节点表示算子，边表示数据依赖。
**优势**：反向传播自动微分,适应异构硬件。
**应用技巧**: 调度优化，算子融合等；节点越少，调度开销（JM通信），内存开销（中间数据重用）越小。
### 串行
输入特征，前向传播，反向传播。
![[Pasted image 20231214171404.png]]
### 多机通信
#### 通信原语
![[Pasted image 20231214172306.png]]
![[Pasted image 20231214172345.png]]
#### 网络通信需求
##### 中心化单机服务器，
O（n），单点负载，带宽与算力不足。
![[Pasted image 20231214172658.png]]
##### allreduce的去中心化
朴素的：顺序的各个节点分别进行reduce：通信时间长。
![[Pasted image 20231214180428.png]]
增加个节点通信的并行性：需要精心设计传递，且具有冗余计算。
![[Pasted image 20231214180436.png]]
![[Pasted image 20231214180453.png]]
##### ring allreduce
减少冗余计算，节点间传递计算结果
![[Pasted image 20231214180609.png]]
#### 网络链接优化
- NVLink:大规模并行性（由于硬件的紧密放置,多通道，高频率），GPU间通信
- RDMA：慢于NVLink，节点通信
![[Pasted image 20231214181145.png]]

### 数据并行
![[Pasted image 20231214171527.png]]
![[Pasted image 20231214171636.png]]
在每个处理器中存储整个模型，分割输入特征集。
![[Pasted image 20231214172024.png]]
![[Pasted image 20231214172359.png]]
**缺点**：数据并行需要冗余存放多个模型的完全备份。
模型越来越大，单机可能无法存放整个模型。
### 模型并行

![[Pasted image 20231214171546.png]]
- 水平分割：流水线并行
- 垂直分割：张量并行
##### 流水线并行
![[Pasted image 20231214173929.png]]问题：等待的气泡
![[Pasted image 20231214174036.png]]
解决：微批处理，减少总气泡![[Pasted image 20231214174108.png]]
##### 张量并行
对每层的参数进行分割。前向反向无需通信，可以独立计算，最后需要allreduce更新梯度。
支持大层流水线并行
适合现代服务器的硬件架构（或者我们可以说现代服务器是为张量并行而构建的）
![[Pasted image 20231214174351.png]]
### 并行策略结合使用

![[Pasted image 20231214174642.png]]


### 多机的同步与异步
同步准确性高，异步训练效率高（牺牲准确性与算法语义）
![[Pasted image 20231214174827.png]]![[Pasted image 20231214174834.png]]
