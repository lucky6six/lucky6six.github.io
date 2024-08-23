## Virtualization
#### goal
- 控制/性能隔离
- 支持异构
- 低性能开销
#### type
type of VM
![[Pasted image 20231120081737.png]]![[Pasted image 20231120081759.png]]
#### KVM
![[Pasted image 20231120081839.png]]
## XEN
![[Pasted image 20231120082020.png]]
#### hypervisor
基本的控制操作。
#### Domain0
启动时创建，完全访问物理机器
负责托管应用管理软件，创建/中止其他domain，委托访问机器资源
#### DomainU
应用，使用domain0夫案例的抽象接口，接收静态内存

![[Pasted image 20231120082658.png]]


## RT-XEN
#### motivation
虚拟化并不是实时的
- hypervisor不保证延迟
- 云平台不提供延迟
#### overview
![[Pasted image 20231120084543.png]]

### 调度
##### 优先级类型
- 静态优先级（按给定的优先级）
- 动态优先级
##### 范围分类
- 全局调度（有更大的切换开销）
- 分块调度（只在上面的黑框内分别调度）（可能无法充分利用cpu资源）

