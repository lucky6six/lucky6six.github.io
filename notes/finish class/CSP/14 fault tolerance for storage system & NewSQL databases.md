#### fault is common
- fault
- error
- failure
分布式系统规模大，fault is common
key of cope with fault——**replication**备份
#### replication is everywhere
- performance：高吞吐（replicas serve），低时延（cache）
- fault tolerance：部分备份fail系统仍可用
#### **挑战：一致性！**
- optimistic replication：允许过程不一致，通过修复保证结果一致性。当一个备份刚写数据时，另一个看不到修改。
- pessimistic replication：强一致性，应用于副本不一致会造成严重问题的场景。trade-off，相对于乐观备份会低可用和额外性能开销。

## 悲观备份

#### 理想目标：单拷贝一致性
复制系统的外部可见行为的属性
操作似乎在执行时就好像只有一个数据副本一样
在内部，可能会有失败或分歧，我们必须掩盖这些
类似于我们定义可序列化性目标的方式（“就像串行执行一样”）
### replicated state machines（RSM）
创建服务器一致性副本的一般方法：
1. 在每台服务器上从相同的初始状态开始
2. 以相同的顺序为每个副本提供相同的输入操作确保所有操作都是确定性的
3. 例如，没有随机性，没有读取当前时间等。

这些规则可确保每个服务器最终都处于相同的最终状态。
![[Pasted image 20231221101846.png]]
#### RSM w/primary backup model
问题：客户端对不同服务器的请求可能以不同的顺序到达。我们如何确保服务器保持一致？与乐观复制（例如，最终一致性）不同，我们不能在以后对事件重新排序，我们必须立即对其进行排序。

**RSM 提供单副本一致性**
操作完成，就好像存在数据的单个副本一样
虽然内部有副本
**RSM 可以使用primary backup model进行复制**
确保只有一台服务器用于对从客户端接收的输入进行排序
**primary做重要的事情**    
确保在确认协调器之前将所有输入发送到备份
为所有操作选择顺序，以便主操作和备份操作一致（即一个写入器）
确定所有非确定性值（例如，random（）、time（））
### Primary 单点问题
问题：primary单点，其fail怎么办？
- 人工切换primary
- coordinator决定并切换primary（多coordinator相互独立，如何统一分歧？）
- magic todo
#### coordinator
![[Pasted image 20231221102754.png]]
防止单点fail问题，需要多个coordinator
![[Pasted image 20231221102822.png]]
但coordinator可能选择不同primary，导致不一致。
![[Pasted image 20231221102901.png]]
**view server（VS）**
%%没有什么是加一层不能解决的%%
view server维护全局server视图table，可以选择primary并通知各服务器身份。
![[Pasted image 20231221103209.png]]
server定时ping VS，表明自己的活跃状态。
![[Pasted image 20231221103428.png]]
![[Pasted image 20231221103509.png]]
在该切换过程中，系统不可用，vs要通知所有server！
问题：network partition导致的切换
![[Pasted image 20231221103949.png]]
说明无论Coordinator认为谁是primary，S2处于何种状态，都能保证一致性。
非主要必须拒绝直接协调员请求
![[Pasted image 20231221103934.png]]
主服务器必须等待备份接受每个请求  
主要必须拒绝转发的请求，也就是说，它不会接受来自备份的更新。视图中的主视图 i 必须是视图 i-1 中的主视图或备份（S2的view版本比S1大）


![[Pasted image 20231221104034.png]]

**递归回到了单点fail问题**
![[Pasted image 20231221104332.png]]
那么VS做到了什么呢？
减少了单点需要做的工作量，将切换primary与每个请求寻找primary解耦，多个请求可能只访问单点一次。
## Raft's replicated protocol

