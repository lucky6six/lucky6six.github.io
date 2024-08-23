——***uefi如何与上层交互***
![[Pasted image 20231121100751.png]]
明确的界限，控制从uefi来到os

UEFI-aware OS是指完全基于UEFI开发的操作系统，完全不需要legacy bios参与。操作系统使用UEFI提供的调用，彻底抛弃传统的interrupt方式的实模式调用，并且将自己的操作系统加载程序实现为UEFI应用程序的形式。

## legacy BIOS系统启动

![[Pasted image 20231121103109.png]]
#### OS bootloader
程序：启动时加载os内核到内存中
1. 设置与初始化RAM
2. 初始化串口
3. 检查机器类别
4. 设置内核tagged list
5. 加载 initramfs（初始化文件系统）
6. call内核镜像
#### boot内存区
![[Pasted image 20231121101724.png]]
下四层是历史遗留问题。extended是最下层的拓展。
#### todo: MBR（master boot record 主引导记录/主引导扇区）
是计算机开机后访问硬盘时所必须要读取的首个扇区。
![[Pasted image 20231121105905.png]]
MBR分区表与GPT分区表的关系
与支持最大卷为2 TB（Terabytes）并且每个磁盘最多有4个主分区（或3个主分区，1个扩展分区和无限制的逻辑驱动器）的MBR磁盘分区的样式相比，GPT磁盘分区样式支持最大为128个分割，一个分割最大18 EB（Exabytes），只受到操作系统限制（由于分区表本身需要占用一定空间，最初规划硬盘分区时，留给分区表的空间决定了最多可以有多少个分区，IA-64版Windows限制最多有128个分区，这也是EFI标准规定的分区表的最小尺寸）。与MBR分区的磁盘不同，至关重要的平台操作数据位于分区，而不是位于非分区或隐藏扇区。另外，GPT分区磁盘有备份分区表来提高分区数据结构的完整性。在UEFI系统上，通常是通过ESP分区中的EFI应用程式档案启动GPT硬碟上的作业系统，而不是活动主分区上的引导程序。
#### BIOS interrupt calls
BIOS client 通过software interrupts（by int指令）访问BIOS services
类似系统中断，但是从bootloader int到UEFI，不发生模式切换。（int 类似 syscall）
举例
![[Pasted image 20231121102651.png]]
![[Pasted image 20231121102711.png]]
#### limitations
- MBR 只支持最大大小为2TB的四个分区
- 链式启动流程易错
- 仅支持16位模式
## UEFI
![[Pasted image 20231121105838.png]]
#### uefi interface
- 64bit mode
- GUID partition table（GPT）支持更多分区，最大8ZB
![[Pasted image 20231121104528.png]]

## todo uefi linuxboot
——————————————————————————

## security with UEFI
![[Pasted image 20231121112334.png]]
### motivation
boot流程设计各种源（驱动，系统，固件。。。。。。），如何确保可信源
eg:不受限制的访问硬件——DRAM/HDD/SSD
![[Pasted image 20231121113231.png]]
![[Pasted image 20231121113205.png]]
### secure boot

