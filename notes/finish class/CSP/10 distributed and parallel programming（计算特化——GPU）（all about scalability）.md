## 引入
*可拓展程序随处可见——eg:AI*
- 需求：高请求速率，大量数据，高算力
- 需求强力计算设备:ai计算设备的迭代
	CPU -> GPU -> TPU
单机计算系统编程直接，但难以满足scalability的需要。
need distributed and parallel to provide sufficient scalable



## 单机并行系统总览

### 单核系统![[Pasted image 20231123101742.png]]
![[Pasted image 20231123101742.png]]
在理想的无bubble流水线下，FLOPS = clock rate
	FLOPS每秒浮点运算次数。常用于衡量系统算力
##### 单核并行可拓展性
	流水线，指令级并行。
- 优化流水线（eg:reduce bubble）.
- 更快的时钟周期
- 探索更广的指令并行（ILP）

加速程序计算，需要写并行程序


### 多核系统
#### approach1：增加物理核
![[Pasted image 20231123102910.png]]
![[Pasted image 20231123103010.png]]
	**pthread**库提供多线程编程抽象
##### cache一致性成为拓展瓶颈
1. 内存访存结构引发的一致性问题——多核cache不一致。
2. 采用cache一致性协议
	1. directory-based 使用全局目录
	2. snoop-based监控核的访存
3. 一致性协议可能成为性能瓶颈，限制了拓展性
	1. directory-based -> directory成为瓶颈
	2. snoop-based -> snoops随核数增加
4. 现代计算设备
	1. 单CPU芯片限制核数（20-100），添加机制确保一致性
	2. GPU不保证cache一致性
#### approach2：增加每个核的计算单元(SIMD)
![[Pasted image 20231123105402.png]]
**观察**：大量计算涉及相同指令的大量数据同时计算。
**SIMD**： **single instruction**，multiple data。
	核内相同指令，省去每个ALU执行流的管理开销
	(GPU常采用此设计)
![[Pasted image 20231123111036.png]]![[Pasted image 20231123111115.png]]
**优化结果**：成倍加速（<8）,因为一些访存，处理，等待等问题
#### 数据的加载：内存瓶颈
##### load time
数据加载时间 = **延迟** + 负载/**带宽**
延迟对CPU访存影响大，带宽对大数据传输影响大。
##### memory stalls（communication stalls）
	由于依赖指令（常为访存）未完成，后续指令无法并行继续执行
访存时间大致需要100 cycles，访存可能成为延迟瓶颈。
![[Pasted image 20231123111801.png]]

#### roofline model
判断应用瓶颈是算力还是内存。
y轴：FLOPS理论峰值，单位时间的运行op
![[Pasted image 20231123112841.png]]
x轴：运行强度，单位访存运行的op
![[Pasted image 20231123113037.png]]
能够利用的带宽（单位时间访存）：m=y/x
![[Pasted image 20231123113306.png]]
roofline model
![[Pasted image 20231123113332.png]]
对于不同应用对应的x轴，对应到不同阶段，说明不同的瓶颈类型，知道优化目标。

#### 协同使用
![[Pasted image 20231123113947.png]]问题：
##### SIMD控制流（eg条件执行）
SIMD 指令层级低，缺少单独的PC，难以处理控制流。
**屏蔽指令**： 按顺序执行所有分支每个 ALU 都有一个掩码，用于指示指令是否将被执行。
![[Pasted image 20231123114351.png]]
**缺陷**：若分支更多更长，每个alu占用一个分支，接近串行。
##### SIMT
**SIMT**： **single instruction**，multiple threads。
供应商提供开发工具包以简化 SIMD 程序的开发
实际是套了一层抽象（eg:CUDA），编译器提供条件分支处理mask，代码分发attach，掩盖低级AVX指令等处理,程序员只需要考虑代码逻辑。
##### CUDA （on SIMD硬件如 GPU）
抽象：C 代码
程序员使用 C 为单个线程编写代码,所有线程都执行相同的代码,但可以采用不同的路径（支持控制流）
线程分组在一个块中,同一块内的线程可以同步执行
每个块都映射到一个 GPU 内核进行执行
![[Pasted image 20231123114907.png]]
##### GPU成为高算力设备
- GPU 具有高带宽内存
- GPU 没有缓存一致性
- GPU 添加tensorcore加速矩阵运算


## 分布式计算系统
*单机的可拓展性总是不够的*
#### 分布式需要处理的事情
- 数据分区部署
- 工作负载分发，依赖关系处理
- 容错与一致性
- 网络通信