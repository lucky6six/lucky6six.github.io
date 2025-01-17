## *Review*
#### 一致性被打破的风险
##### single object
- replivation备份（包括cache）
- failure
##### multiple objects
- race
#### 如何定义一致性
- 数据在逻辑上单备份
- 并发读写行为等效为某种线性序
#### 2PL （two-phase locking）
共享数据上锁，访问前拿锁，操作后放锁




## deallock死锁
	 不同线程循环等待彼此放锁
#### 解决方案
- prevention（预防）：预定义拿锁顺序
	无法预知要读写的数据集
- detection（检查）：构建冲突图检查并解开死锁
	检测成本高
- Retry（重试）：时间戳/启发式长时间等锁后重新运行
	误报/活锁
## 乐观并发控制（OCC）
	在不获取锁的情况下执行tx，提交前检测是否违法序列化，是则重试。
#### 3阶段执行
1. 并发执行，写buffers
2. 验证关键字段
		是否序列化，**读取**的数据是否**被修改**
3. 提交或放弃
	- 提交：buffer -> write set
	- 放弃：abort——nothing
**2&3应该在一个critical section中执行（原子执行），防止验证阶段发生数据修改。—>加锁**
![[Pasted image 20231116104219.png]]
#### OCC优势
- 1阶段各线程并发，23阶段串行但很短。
- 读集不需要加锁，拿锁很少，按写提交确定序列。
- 拿锁时已知读写集，可以规划拿锁顺序，避免死锁（全局大表数据序列，不会出现不同线程交叉拿锁）

#### 锁基础
	 我们用锁来保证并发一致性，但拿锁本身也是一种操作，如何保证拿锁的原子性？
硬件保证，提供Compare-and-swap/exchange原子拿锁
#### OCC problem
- 误报
	读集变大时，可序列化提交也易abort
- 活锁
	大型读写集/高并发/长时间任务中，大量abort，任务无进展
#### 对比
所谓乐观，认为并发事务间的竞争较小，commit的概率远大于abort，适合小规模并发任务集。
![[Pasted image 20231116111052.png]]

## HTM（硬件事务性内存）
CPU 保证内存读取/写入之前或之后的原子性。
eg:RTM of Intel/TME of ARM
#### RTM的实现利用OCC思想
![[Pasted image 20231116113226.png]]

##### 天然的实现：
- CPU cache 确定读写集。
- 缓存一致性协议检测是否存在冲突。
##### 受限的执行：
- 受限的工作集大小——cache size
- 受限的执行时间——易被影响（eg interrupt）
##### 合适的场景
小工作集，简单程序，并发场景。

## MVCC
长时读取时很常见的应用场景，但OCC于2PL都不是很合适。
to减少如下图的OCC误报——T1认为读取的AB被修改因此abort，但实际上读取先于T2是一致的，可以接受的。
![[Pasted image 20231116114749.png]]
#### MVCC原理
无需使用锁，确保事务一致性。（代价为数据冗余）
写：代替覆盖原值，写入带有时间戳的新版本。
读：确定事务开始时间戳start，只能读到start之前的最新版本。

问题1：同一版本写多个数据的过程中被读导致不一致
解决：加锁，只要开始写，就无法得到旧版本的值。
问题2：写竞争仍然存在。
解决：提交时验证写的数据是否在事务开始后被修改。
缺陷:并不能完全保证一致性
![[CSP-09-more on consistency.pptx]]