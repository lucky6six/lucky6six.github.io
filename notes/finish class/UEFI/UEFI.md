# 01 
**在计算机系统中，有几种主流的固件类型。目前，最主要的固件包括：**
**UEFI (Unified Extensible Firmware Interface)**:UEFI是BIOS（基本输入/输出系统）的现代替代品，提供了更灵活、功能更强大的固件接口。它支持更大的硬盘容量、更快的启动速度以及更多先进的特性。UEFI设计用于替代传统的BIOS，并且在当前的计算机系统中被广泛使用。
**BIOS (Basic Input/Output System)**:BIOS是早期计算机系统中使用的固件接口，负责初始化硬件、启动操作系统，并提供基本的计算机硬件控制。尽管UEFI正在逐渐取代BIOS，但在某些老旧系统或特定应用场景下，仍在使用。
**Coreboot**:Coreboot是一个开源的固件解决方案，旨在替代传统的BIOS和UEFI。它专注于轻量级、快速启动和灵活性，允许用户更好地控制硬件初始化过程和启动选项。
这些固件类型在不同的硬件平台和计算机系统中使用，并针对不同的需求和用例提供不同级别的灵活性和功能。UEFI目前是大多数现代计算机系统中默认的固件接口。

**协议是特定于 DXE 的，PEI 将使用 Peim 到 Peim。**

**DXE（Driver Execution Environment）是UEFI的一个阶段，负责加载和执行UEFI驱动程序。DXE Dispatcher是负责驱动程序加载和初始化的核心组件之一。**
安装驱动程序的过程涉及以下步骤：
1. Driver Binding Protocol Registration:驱动程序通过Driver Binding Protocol注册其支持的设备类型。这允许系统在需要时将驱动程序与相应的设备进行绑定。
2. Firmware Volume检索：DXE Dispatcher会在系统启动时扫描系统中的固件卷，以查找并识别可用的驱动程序。
3. Dispatch:DXE Dispatcher会在启动期间按照特定的规则（如依赖关系、加载顺序等）将驱动程序分派到适当的设备或服务。
4. 加载和初始化：Dispatcher负责将驱动程序加载到内存中，并调用其初始化函数。这包括分配资源、配置设备和启动服务等。
5. Driver Execution:安装驱动程序后，Dispatcher将控制权转交给相应的驱动程序，让其执行其特定的任务或功能。
- 错误处理：如果发生加载或初始化过程中的错误，Dispatcher负责相应的错误处理，可能会记录错误信息或尝试其他备用驱动程序。
在这个过程中，DXE Dispatcher扮演着一个重要的角色，确保驱动程序能够按照正确的顺序加载和初始化，以便系统硬件和服务得到正确的配置和支持。这些过程是UEFI固件中的关键部分，确保系统在启动时能够正确地识别、配置和使用硬件设备。

**Intel® Firmware Support Package（Intel® FSP）是一个由英特尔提供的软件包，用于协助系统制造商和固件开发人员开发基于Intel架构的嵌入式系统固件。它提供了一组预构建的固件组件和工具，以简化和加速固件开发的过程。**

Intel® FSP的主要组成部分包括：
- Firmware Initialization Package (FSP) Binary:Intel® FSP的核心部分，提供了用于初始化处理器、内存控制器、外设和其他硬件组件的预构建二进制代码。FSP二进制文件包含了启动固件所需的底层代码，用于启动和初始化处理器和系统硬件。
- FSP Integration Guide:提供了有关如何集成FSP二进制文件到特定平台或项目中的指导。这个指南包含了构建和配置启动固件的步骤，使得硬件制造商和固件开发人员能够根据自己的需求和硬件配置定制固件。
Intel® FSP的目标是简化固件开发流程，使得硬件制造商和固件开发者能够更快速、更有效地构建和定制基于Intel处理器架构的嵌入式系统固件。它提供了一个标准化的接口和预构建的代码，减少了开发过程中与底层硬件交互的复杂性。
# 02
**OVMF代表Open Virtual Machine Firmware，是一种用于虚拟机环境的UEFI固件。它是针对虚拟化平台（如QEMU、KVM等）而设计的，允许在虚拟机中模拟一个符合UEFI规范的固件环境。**

OVMF提供了一种在虚拟机中运行UEFI操作系统的方式，使得在虚拟化环境中可以利用UEFI的功能，比如更大的硬盘容量支持、更快的启动速度以及更强大的硬件支持。它通常用于在虚拟机中运行需要UEFI固件的操作系统，如最新版本的Windows、某些Linux发行版等。

OVMF是一个开源项目，由EDK II（EFI Development Kit II）构建而成，提供了一套用于虚拟机的UEFI固件，让虚拟机能够以更现代化的方式启动和运行操作系统。这对于测试、开发和调试需要UEFI支持的软件或操作系统非常有用，尤其是在虚拟化环境中。
**BASETOOLS 提供了开发人员在开发 UEFI 固件时所需的多个工具，这些工具有助于构建、调试和管理 UEFI 固件中的各种组件和文件。它们为固件开发过程提供了一系列实用的命令行工具，帮助开发者更好地管理和调整 UEFI 固件的不同部分。**
**Up Xtreme是一款由Up Board制造商提供的高性能嵌入式计算机板。它是一款基于英特尔的x86架构的计算机板，旨在提供强大的性能和丰富的扩展能力，适用于各种嵌入式应用和项目。**

**对于文件扩展名**
.inf：
INF（Information）文件，包含有关驱动程序或组件的信息，包括其版本、依赖关系和安装指令。
.dsc：
DSC（Decoded Source Components）文件，描述了整个EDK II项目的组成和结构，包括各种组件、模块和依赖关系。
.dec：
DEC（Decoded Source）文件，用于定义UEFI固件中的PPI（Platform Programming Interface）和Protocol。
.uni：
UNI（User Interface）文件，用于定义UEFI固件中的界面字符串和本地化信息。
.fdf：
FDF（Flash Description File）文件，描述了固件映像的分区布局和组织方式。
.efi：
EFI可执行文件，包含UEFI固件中的可执行二进制代码或应用程序。
.fd
FD 文件（Firmware Descriptor 文件）：
定义：FD文件包含有关固件的描述信息，比如固件的存储和分区信息、权限设置、保护策略等。
作用：FD文件描述了固件存储器中各个区域的功能、权限和保护设置，对固件存储器进行了划分和定义。
.fv
FV 文件（Firmware Volume 文件）：
定义：FV文件是UEFI固件中用于存储数据和执行代码的逻辑容器。它是一个逻辑的、可被UEFI固件访问的容器。
作用：FV文件可以包含UEFI固件中的各种元素，如PEI Core、DXE Core、驱动程序、固件配置、UEFI应用程序等。
关系与作用：
FD文件和FV文件通常是UEFI固件中不同层次的抽象。FD文件描述了存储器的逻辑分区和权限，而FV文件则是用于存储和组织UEFI固件中的具体数据和代码。

FD文件的设置和描述影响了固件的存储结构和权限，而FV文件则是固件中实际存储和执行代码的逻辑单位。共同包含于ovmf。

这两种文件都是UEFI固件开发中重要的组成部分，它们共同构成了固件的存储、管理和执行基础。
在 EDK II（EFI Development Kit II）中，模块是构建 UEFI 固件所需的基本组成单元之一。这些模块是编译生成固件时所需的源代码和二进制文件。

**EDK II 中的模块包括多种类型，其中一些主要类型包括：**
**Driver 模块：**
驱动程序模块用于支持硬件设备或提供特定功能。它们通过 UEFI 的 Driver Model 提供服务，并可以与硬件交互。
**Library 模块：**
库模块提供了一组函数、宏或数据结构，供其他模块使用。这些库模块可以包含通用功能，如字符串操作、内存管理等。
**Application 模块：**
应用程序模块是 UEFI 固件中的可执行文件，通常包含启动和初始化代码，可以执行特定的任务或操作。
**Protocol 模块：**
协议模块定义了 UEFI 中的协议，用于模块之间的通信。这些协议描述了如何与设备或服务进行交互。
每个模块通常包含一个或多个源代码文件（例如.c、.cpp等），以及相关的配置文件（如.inf）和头文件（如.h）。在编译过程中，这些模块被编译成二进制文件，然后链接到一起形成最终的 UEFI 固件。
这些模块组合起来构成了 UEFI 固件的功能和特性，同时也提供了灵活性，使开发人员能够根据需要定制和扩展固件。
**在 EDK II（EFI Development Kit II）中，包（Packages）是一种组织和管理 UEFI 固件开发所需组件的方式。它们是包含特定功能、驱动程序、库和协议等的集合，以便在 UEFI 固件开发过程中重用和整合。**
**驱动程序包（Driver Packages）：**
包含用于支持特定硬件设备或提供特定功能的驱动程序。比如网络驱动、图形驱动等。
**库包（Library Packages）：**
提供通用功能的库集合，例如字符串操作、内存管理等。
**协议包（Protocol Packages）：**
包含了UEFI中定义的各种协议，用于模块之间的通信和交互。
**应用程序包（Application Packages）：**
包含 UEFI 固件中的可执行应用程序，可以执行特定任务或提供特定服务。

这些包能够使开发人员更方便地组织和管理 UEFI 固件开发中所需的各种组件和资源。EDK II 的设计目标之一就是通过这种模块化的方式，允许开发者在固件开发中重复使用和整合不同的功能模块，以便更高效地构建和定制 UEFI 固件。
所以，包是一种更高层次的概念，用于组织和管理多个模块。一个包可以包含多个不同类型的模块，这些模块共同构成了 UEFI 固件的功能和特性。这种模块化的设计使得开发者能够更好地组织和管理 UEFI 固件开发中所需的各种组件和资源。
**Platform Configuration Database（PCD）是 EDK II（EFI Development Kit II）中的一个概念，用于存储和管理 UEFI 固件配置信息。PCD 是一种键值对（Key-Value）数据库，用于配置 UEFI 固件中各种模块和组件的行为。**

**PCD 可以包含以下类型的配置信息：**
基于类型的配置：
定义了数据类型和特定的值，用于驱动程序、库、应用程序等模块中的配置。
平台相关配置：
包含特定于硬件平台的配置信息，如硬件功能开关、设备地址等。
构建配置：
用于控制和配置固件构建过程的选项，如编译开关、功能使能/禁用等。
协议和功能特性：
可以配置和控制 UEFI 协议的特性，以及模块的功能选项。

PCD 提供了一种在 UEFI 固件开发过程中管理和使用配置信息的标准方式。通过使用 PCD，开发人员可以在编译时或运行时轻松修改和管理固件中的配置，而无需直接修改源代码。这使得固件更加灵活，允许根据需要进行定制化配置，同时降低了在不同平台上重用固件代码的难度。

**Platform 和 Module 的关系：Platform 定义了整个固件的基础架构和适配硬件的配置，而 Module 是构成这个固件的具体功能组件。Modules 被组合和配置以适应特定的 Platform，从而构建出符合该硬件配置的 UEFI 固件。**
**Platform 和 Module 在UEFI固件开发中扮演着不同的角色，Platform 确定了固件的基础硬件配置，而 Module 提供了各种功能和服务。它们的配合和组合使得开发者能够针对不同的硬件平台定制和构建出符合特定需求的 UEFI 固件。**
**Platform（平台）：**
含义：指特定硬件配置或系统架构的集合，用于构建适用于这些硬件的UEFI固件。
特点：包括处理器架构、芯片组、外围设备支持、内存配置、启动方式等。
作用：定义了固件的基础架构，用于适配特定的硬件或系统类型。
**Module（模块）：**
含义：是构建 UEFI 固件所需的基本组成单元，提供了源代码和二进制文件，用于实现特定的功能、驱动程序、协议或库。
特点：包括驱动程序、库、协议和应用程序等。
作用：为固件提供特定的功能、驱动或服务，并可以按需进行定制和添加。

**EDKII Build过程简介**
EDKII Build主要是用来处理EDKII meta-data文件（包括build_rule.txt，tools_def.txt，target.txt等），EDKII source和binary文件，以及一些已经存在的可兼容的EDK组件和库模块文件，最终产生遵循UEFI和PI规范的二进制文件。
EDKII Build过程主要可以分为3个阶段：
Pre-build（AutoGen）阶段：主要是来解析meta-data文件，dsc文件，.inf文件，.fdf文件，.dec文件，Unicode文件和VFR文件等，产生一些标准C的代码文件（Autogen.c，Autogen.h）和相应的Makefile文件。
Build or $(MAKE)阶段：主要是来处理source文件并通过Make（Linux系统）或者Nmake（Windows系统）来生成符合EFI格式的PE32/PE32+/COFF 文件。
Post-build（ImageGen）阶段：主要是来处理binary文件和EFI格式的文件，产生最终的UEFI Flash Images， Capsules，Applications和PCI Option ROMs。
![[Pasted image 20231229171323.png]]

# 03 boot flow 
为了解决无内存但需要用C语言stack的问题，SEC阶段采用Cache as RAM，并配置cache使其有non eviction的效果
CAR=Cache As RAM
NEM=Non Eviction Mode
**SEC阶段的功能：**
SEC作为整个系统的起点，可能会遇到各种异常，就需要设置IDT，有了中断描述符表接收异常，就能让系统遭遇意外情况时不至于崩溃，同时它还为PEI阶段的代码设置临时内存的基地址和长度，并传给PEI，还需要找到PEI代码的入口点，将控制权移交过去，并且处理临时内存。

UEFI系统开机或重启后首先进入SEC阶段，SEC阶段系统执行以下四种任务：

接收并处理系统启动和重启信号，系统加电信号、系统重启信号、系统运行过程中的异常信号。
初始化临时存储区域：系统运行在SEC阶段时，仅CPU和CPU内部资源被初始化，而各种外部设备和内存都没有被初始化，主要是出了最初的汇编代码，SEC阶段还有C代码。因此系统需要一部分临时内存用于代码和数据的存储，一般称为临时RAM，临时RAM只能位于CPU内部（CPU和CPU内部的资源最先被初始化）。最常用的临时RAM是Cache，通过将Cache设置为no-eviction模式，（noeviction:不删除策略，不淘汰，如果内存已满，添加数据是报错的），来把其当成内存使用（此时读取命中则返回Cache中的数据，读取缺失并不会向主存发出缺失事件；写命中时写入Cache，写缺失时也不会向主存发出缺失事件），这种技术称为CAR（Cache As RAM）。
SEC阶段是可信系统的根：作为系统启动的第一部分，只有SEC能被系统信任，以后的各个阶段才有被信任的基础。因此，大部分情况下SEC再转交控制权给PEI前可以验证PEI是否可信。
传递系统参数给下一阶段：SEC阶段的一切工作都是为PEI阶段做准备的，最重要把系统的控制权转交给PEI，并将SEC阶段的运行信息汇报给PEI。SEC通过将以下信息作为参数传递给PEI的入口程序来向PEI汇报信息：
系统当前状态，PEI根据状态值判断系统当前的健康情况。
可启动固件（Boot Firmware Volume）的地址和大小，PEI据此判断可用硬件。
临时RAM区域的地址和大小。
栈的地址和大小。
**PEI阶段的功能任务：**
初始化内存。
为DXE阶段准备执行环境。
简单而言分为以下几点：
基本的Chipset初始化
Memory Sizing
BIOS Recovery
S3 Resume
切换Stack到Memory （Disable CAR， Enable Cache）
启动DXEIPL（DXE Initial Program Loader）

PEI划分：
PEI内核（PEI core）：负责PEI基础服务和流程。
PEIM（PEI Module）派遣器：找出系统中的所有PEIM，并根据PEIM之间的依赖关系按顺序执行PEIM。PEI阶段对系统的初始化主要由PEIM完成。
每个PEIM都是一个独立的模块。通过PEIServices，PEIM可以调用PEI阶段（UEFI？）提供的系统服务。通过调用这些服务，PEIM可以访问PEI内核。PEIM之间的的通信通过PPI（PEIM-to-PEIM Interfaces）完成。

PEI阶段执行流程：
进入PEI入口。
根据SEC阶段传入的信息初始化PS（PEI Core Service）。
调度系统中的PEIM（PEI Module），准备HOB列表。
具体调用的系统中的PEIM有：
CPU PEIM（提供CPU相关功能，如进行Cache设置、主频设置等）；
平台相关PEIM（初始化内存控制器、I/O控制器等）；
内存初始化PEIM（对内存进行初始化，此时内存才可用，之前使用的CPU模拟的临时内存）。
调用PEIServices得到DEX IPL PPI的Entry服务（即DEXLoadCore）。
注：PPI与DEX阶段的Protocol类似，每个PPI都是一个结构体，包含有函数指针和变量。每个PPI都有一个GUID。通过PEIServices的LocatePPI服务可以找到GUID对应的PPI实例。
DXELoadCore服务找出并运行DXEImage的入口函数，将HOB列表传递给DXE。
流程描述及流程图
SEC模块找到PEI Image的入口函数 _ModuleEntryPoint（函数位于MdePkg/Library/PeimEntryPoint/PeimEntryPoint.c）
_ModuleEntryPoint函数最终调用PEI模块的入口函数PEICore
进入PEICore后，首先根据从SEC阶段出入的信息设置PEI Core Services，
调用PEIDispatcher执行系统总的PEIM， 在内存初始化完成后，系统切换栈并重新进入PEICore。（重新进入PEICore后使用的不再是 临时RAM 而是真正的内存。）
在所有PEIM执行完成后，调用PEIServices的LocatePPI服务得到DXE IPL PPI， 并调用DXE IPL
PPI的Entry服务（即DEXLoadCore）， 找出DEX Image的入口函数，执行DXE Image函数并将HOB列表传递给DXE。
**dxe阶段的driver**
![[Pasted image 20231229191737.png]]
handle的概念就有点虚了，经常会看到driver handle，device handle, image handle等等。可以将handle理解为一个逻辑的设备，这个逻辑设备将N个有关联的protocol interface组合到一起，方便于UEFI管理。

# 04 ACPI
**ACPI（高级配置与电源管理接口）**
规范同时对硬件和操作系统的实现都提出了要求和标准。ACPI是一种规范，它定义了计算机系统中的硬件与操作系统之间的接口和交互方式，以实现高效的电源管理、硬件资源管理和事件通知。
具体而言，ACPI规范包括以下方面的要求：
硬件要求： ACPI规范规定了硬件制造商需要提供的ACPI数据表、电源管理支持、事件通知机制和硬件状态描述等信息。硬件需要遵守这些规定，以便操作系统能够正确识别和管理硬件资源。
操作系统要求： ACPI规范定义了操作系统需要解释和使用ACPI数据的方式，包括如何管理电源、如何处理事件、如何配置硬件资源等。操作系统需要遵循这些规定，以便与硬件设备有效地通信。
ACPI规范的目标是为不同硬件设备和不同操作系统提供一种标准的接口，以确保它们能够有效地协同工作。这有助于实现以下目标：
- 高效的电源管理，包括系统休眠、唤醒、电源状态转换等，以提高能效。
- 有效的硬件资源管理，包括中断分配、设备配置、内存地址范围等，以避免冲突和提高系统性能。
-  事件通知和处理，以便及时响应系统事件，如中断、警告、热插拔事件等。
因此，ACPI规范对硬件制造商和操作系统开发者都提出了一定的要求，以确保计算机系统的高效性、可维护性和可扩展性。这也有助于确保不同硬件和操作系统之间的兼容性。

**ACPI 全称是 Advanced Configuration Power Interface。**它是由 Intel, Microsoft, Toshiba, HP, Phoenix 在90年代中期的时候一起合作开发和制定的标准。ACPI是为了解决APM的缺陷而问世的。在此过程中它定义了许多新的规范所以把现有的PNP BIOS Spec, MP Spec 也一并集合了进来形成了新的规范。 那么APM是什么呢，APM全称是 Advanced Power Management（高级电源管理）它是一种基于BIOS 的系统电源管理方案 (是由BIOS实现）提供CPU和外设的电源管理功能；当空闲的时候会被OS调用提供CPU的电源管理。这个做法有什么缺陷呢？

由于基于APM 的每家的BIOS都有它自己的实现，使得它成为了一个黑盒子，而且不同的计算机的实现之间缺乏一致性，每个 BIOS 开发者必须精心维护自己的APM BIOS代码和功能。
系统进入挂起的原因无法知晓。用户是否按了进入睡眠按钮，还是BIOS认为系统已进入了空闲状态，或者电池电压过低，这些信息APM都无法知道，但是Windows必须要知道挂起的原因，即使系统 没有进入空闲状态。
BIOS 无法知道用户在干什么，只有通过监视中断和I/O端口来猜测用户的活动。有时，BIOS会使系统处于完全混乱的状态，当系统没有空闲时将系统挂起或者当系统处于空闲状态时，却不进入挂 起状态。
早期APM（1.0和1.1）不提供任何系统性能信息，系统是否支持睡眠状态就只有尝试将系统转入睡眠模式才知道。如果BIOS不支持睡眠模式，那将导致死机。BIOS APM 1.2解决了这个缺陷。
BIOS对USB设备、加插的电脑配件卡和IEEE1394设备全然不知，导致当以上设备没有进入空闲状态，而BIOS却认为系统已经进入空闲状态，从而发生冲突，使这些设备无法正常使用或系统死机。 微软为了推动发展笔记本电脑，提供更好的电源管理体验，所以提出来ACPI解决混乱的电源管理问题。
ACPI怎么解决APM存在的问题的呢？我觉得主要是通过定义Interface，硬件Interface，软件Interface，以及ACPI 数据结构，并把它们汇报给OS，由OS统一控制管理这些设备并实现电源管理的算法，减少BIOS和OS之间的冲突增加可靠性。
**ACPI结构**
1. ACPI System Description Table是是整个实现的核心，它描述了硬件的接口，例如一些控制寄存器的定义通常实现在固定的模块或者表格中，被称为fixed ACPI description table （FADT）。另外一种table叫做Definition blocks,它是使用ACPI Source Langauge(ASL)定义object和control method，所有的object组成了ACPI namespace。

2. ACPI Register Interface也是通过System Description Table汇报出去的。

3. ACPI BIOS其实就是bootloader，它实现了少量的用于sleep, wake,restart的操作；这些操作很少会被调用。另外ACPI System Description Table也是由BIOS创建和提供的。ACPI System Description Tabl本质上包含了两种类型的共享数据结构接口，并通过他们来架起OS和系统固件之间的桥梁，而且因为是接口，所以不同的平台可以按照自己的硬件定义来实现，从而可以做到架构独立，平台无关。这两种数据结构分别是Data Table 和 Definition Block. Data table里面是一些原始数据供OS和driver使用，Definition Block则包含了可以被解释器执行的字节码。
相互配合：在现代计算机系统中，UEFI固件通常会支持加载并执行ACPI表格，这些表格包含了系统的配置信息和硬件特性。操作系统通过ACPI表格与硬件通信，而UEFI固件提供了加载和传递这些表格的功能。
电源管理：ACPI负责电源管理方面的功能，而UEFI固件作为系统启动和初始化的一部分，也可以参与电源管理。

# 05 EDK II Modules: Libraries, Drivers & Applications

EDK II中的**Library Modules**是提供通用功能和服务的模块化代码单元，可用于UEFI固件开发。这些库模块提供了一系列功能，涵盖了各种常见任务，开发者可以利用这些模块来简化固件开发过程，提高代码的可重用性和可维护性。
**UEFI Driver和UEFI Application在其本质上有一些重要区别，主要体现在它们的功能、目的和运行环境上：**
**UEFI Driver：**
作用：UEFI Driver是用于管理和控制硬件设备的程序，它们提供了与硬件设备交互的接口和功能。UEFI Driver在UEFI启动阶段加载和执行，负责对硬件进行初始化、配置和控制。
示例：例如，磁盘驱动器、网络适配器或图形显示适配器的驱动程序都属于UEFI Driver。
**UEFI Application：**
作用：UEFI Application是在UEFI环境中运行的应用程序，它们通常执行特定的任务、提供用户界面或执行特定的功能，不直接与硬件交互。
示例：启动管理器、诊断工具、配置程序等都可以是UEFI Application。
关系：
合作：UEFI Application可以依赖于UEFI Driver来访问硬件设备。例如，一个UEFI Application可能需要硬盘驱动程序来读取或写入硬盘数据。
互相独立：UEFI Driver和UEFI Application是不同类型的程序，它们通常独立编写和开发，不是同一个项目的一部分。
协同工作：尽管它们是不同类型的程序，但在系统启动和运行时，UEFI Driver和UEFI Application可以协同工作，通过UEFI固件提供的标准接口实现各自的功能。
![[Pasted image 20231229204453.png]]
# 09 uefi aware OS ，安全启动， 机密虚拟化
GRUB（GRand Unified Bootloader）是一个常用的开源启动加载程序，用于在多操作系统环境下引导计算机。在传统的BIOS系统中，GRUB通常被用作引导管理器，帮助用户选择并引导操作系统。而在UEFI系统中，也有称为GRUB2的版本，可用于类似的目的。
**UEFI Secure Boot是一种安全机制，用于确保在计算机启动过程中只能加载和运行经过数字签名的可信软件。以下是UEFI Secure Boot的基本流程：**
1. 启用Secure Boot：
开启UEFI设置中的Secure Boot选项，这样在计算机启动时Secure Boot机制才会生效。
2. UEFI固件验证：
启动过程：计算机启动时，UEFI固件是第一个被加载和执行的程序。
验证UEFI固件：UEFI固件包含了证书、密钥或签名，用于验证下一阶段的Boot Loader是否经过授权。
3. 加载Boot Loader：
验证Boot Loader：UEFI固件验证通过后，会加载并验证Boot Loader。
Boot Loader验证内核：Boot Loader（如GRUB或Windows Boot Manager）也包含数字签名，用于验证操作系统内核或引导程序的签名。
4. 加载操作系统：
操作系统验证：Boot Loader验证通过后，会加载并启动操作系统。
操作系统内核验证：操作系统内核或引导程序也会进行数字签名验证，以确保只有经过授权的操作系统可以被加载和执行。
5. 防止未经授权的软件：
如果任何一个验证步骤失败，Secure Boot机制将阻止未经授权的、没有经过数字签名的软件加载和执行。
通过这种流程，UEFI Secure Boot可以确保只有经过数字签名、来自可信源的软件才能在计算机启动时加载和执行，提高了系统的安全性，防止了恶意软件或未经授权的软件的启动。

**可信平台模块（Trusted Platform Module，TPM）是一种硬件安全模块，通常嵌入在计算机主板或安全芯片中，用于提供硬件级别的安全功能和保护。**
安全启动和认证：TPM可以确保系统在启动时是可信的，并防止未经授权的软件启动。
数据加密：TPM可以提供安全的加密功能，保护存储在系统中的敏感数据。
数字签名：TPM可以用于生成和验证数字签名，确保文件的完整性和真实性。
安全认证：TPM可以与身份验证过程结合使用，提供额外的安全认证层级。
TPM的主要目标是增强计算机系统的安全性，并为数字安全提供硬件级别的支持。它可以在安全性较高的应用场景下提供额外的保护层，例如企业级系统、敏感数据处理和安全认证领域。
# 10 SMM ，SMI ，与虚拟化，相关安全技术
## 特权级
#### 特权级（Intel Ring）（硬件提供）
ring 3 用户态，app
ring 1/2 常用于拓展新功能可以访问一些特权页（页表条目Usr/Kernel）
ring 0 kernel态，全权限，可以执行特权指令
#### 特权级（ARM EL）
EL0 user
EL1 kernel
EL2 H 虚拟化
EL3 ATF固件特权（类似于SMM），具有私有内存
#### 特权级（RISC-V USM）
U 用户
S 系统
M opensbi，类似EL3

## SMM （system management mode）介绍
在ring0级，但特权级比kernel更高。硬件提供实现保证，具有私用数据块。
通过中断（SMI）来管理系统范围的功能。
![[Pasted image 20231128103132.png]]

## SMI（system management interrupt）
- 只能通过SMI访问SMM
- 可以通过处理器SM引脚/APIC总线接收（硬件保证优先级）
- 不会像普通中断一样被masked
- SMI 独立于正常的处理器中断和异常处理机制
- SMI 优先于所有中断
#### SMI的产生
- **异步SMI**: 硬件事务生产（error，timer）
- **同步SMI**： 软件调用（write port 0XB2，核间中断IPI）
![[Pasted image 20231128104940.png]]
![[Pasted image 20231128105021.png]]
SMI是一种中断，通知处理器有重要的系统管理任务需要处理，而SMM是处理SMI的一种特殊工作模式。
当处理器收到SMI时，会切换到SMM，执行预定义的SMM代码，处理系统管理任务，然后返回到操作系统正常执行的状态。
#### 进入SMM
1. 等待当前指令结束并存储完成
2. 在可中断点上进行SMI处理（每个线程最后有一个SMI位，用于是否进入SMI）
3. 保存处理器上下文 in SMRAM
4. 多核处理器中需要所有核全部进入SMM后再处理SMI
ps:因硬件I/O而进入SMM的场景下，退出smm后需要重新执行I/0指令（因为前次调用可能是因失败而陷入SMM）示例：如果设备处于睡眠状态，则其端口 IO 可能会生成 SMI#。然后，SMI 处理程序可以唤醒设备并重新执行生成原始 SMI 的指令#
#### 退出SMM（RSM）
退出 SMM 的唯一方法是通过 RSM 指令（或系统重置/关闭）
 将控制权交还给被 SMI 中断的应用程序或操作系统过程
 处理器的状态是从 SMRAM 中的保存状态区域恢复的。如果处理器在状态恢复过程中检测到无效的状态信息，则会进入关机状态。
 恢复 SMI 时处理器所处的操作模式。
 RSM 只能从 SMM 内部执行
 在不在 SMRAM 中执行 RSM 会生成无效的操作码异常

## SMRAM（system-management RAM）
SMM私用内存空间，硬件保证权限
SMRAM 是处理器在进入 SMM 时切换到的地址空间，包含SMI处理程序和数据
处理器的预 SMI 寄存器上下文保存在 SMRAM 中的预定义位置（与 SMBASE 的固定偏移量）SMBASE 是 SMRAM 的基址，位于主 RAM 的保留部分
# 11 遇到错误如何debug，代码级启动流程
略
# 12 Min Platform and Board
**MinPlatform是一个UEFI固件开发的基础平台，提供了一个最小化的、可扩展的固件环境。它通常是用于构建具体产品的基础，并作为基本的参考平台。MinPlatform不是一个特定的硬件产品，而是一个可用作起点的通用平台。**

**Intel® Firmware Support Package（FSP）是由英特尔提供的一种固件支持软件包，包含了用于特定英特尔处理器平台的初始化和配置代码。FSP针对特定的处理器和芯片组提供了固件初始化所需的二进制代码和文档。**
将MinPlatform和Intel® FSP结合使用，可以实现以下功能：
**基于通用平台的开发**：MinPlatform作为一个通用的基础平台，可以帮助开发者快速开始UEFI固件的开发。Intel® FSP提供了特定处理器平台的初始化代码和支持，可用于定制化MinPlatform以满足特定硬件产品的需求。
**硬件抽象和可移植性**：MinPlatform提供了一个抽象的硬件平台，可以用于不同的产品开发。结合Intel® FSP，可以针对不同的处理器平台进行定制，从而实现固件在不同硬件上的可移植性。
**加速开发**：使用MinPlatform和Intel® FSP可以加速固件开发流程，因为它们提供了基本的环境和支持，开发者可以在此基础上构建和定制符合特定产品需求的固件。

这种结合使用的方式允许开发者在一个通用的平台上快速开始UEFI固件开发，并根据具体产品的需求进行定制和扩展。这两者结合起来通常用于构建特定的UEFI固件实现。MinPlatform作为通用的基础平台，提供了一个起点，而FSP提供了处理器平台的初始化代码，可以与MinPlatform结合使用，用于定制化、扩展和构建特定处理器平台的UEFI固件。

UEFI是一种规范和标准，而MinPlatform和FSP是用于在符合UEFI规范的基础上构建、定制和实现UEFI固件的工具和资源。它们帮助开发者构建适用于特定硬件的UEFI固件实现。

**在UEFI中，"board" 通常指的是特定硬件平台或开发板，它代表着固件所运行的特定硬件配置。这个术语通常指代一块特定的主板或处理器平台，可能有不同的组件、外围设备和特定的硬件配置。**
在UEFI开发中，通常需要为特定的硬件板载或处理器平台进行固件开发和适配。这需要根据具体的硬件特性和组件进行配置和调整，以确保固件能够正确地运行和支持该板载或处理器平台。
为了适配特定的硬件，UEFI固件可能需要对各种设备、接口、GPIOs（通用输入输出）、时钟等进行配置。因此，"board" 在UEFI开发中是一个关键的概念，代表了特定硬件平台所需的固件支持。
对于不同的硬件板载或处理器平台，可能会有不同的UEFI固件版本或配置文件，以便适配和支持特定的硬件。这种板级适配对于确保固件在特定硬件环境下的稳定性和可靠性至关重要。
**GPIO（General Purpose Input/Output）是通用输入输出端口，用于与数字电路中的外部设备或其他芯片进行通信和控制。GPIO通常由处理器或控制器内部集成，用于向外部设备发送电信号或接收来自外部设备的电信号。**
GPIO（通用输入输出）和HSIO（高速输入/输出）是在硬件设计中用于不同目的的两种接口类型。
**GPIO（通用输入输出）：**
功能：GPIO是一种通用的数字输入输出接口，用于与数字电路中的外部设备进行通信和控制。它可以用于读取外部设备的状态（输入）或控制外部设备的状态（输出）。
用途：常用于连接和控制较低速的数字设备，如按键、LED灯、传感器等。
特点：GPIO通常速度较慢，用于低速、较简单的数字信号传输和控制。
**HSIO（高速输入/输出）：**
功能：HSIO是用于处理高速信号的输入输出接口，通常用于连接高速设备，如PCIe、USB、SATA等。
用途：常用于连接和支持高速设备传输，具有较高的数据传输速率。
特点：HSIO速度较快，可以支持高速、复杂的数字信号传输和通信，需要更复杂的信号调节和设计。
USB与HSIO的关系：USB通常属于高速设备之一，需要支持高速输入/输出（HSIO）接口。在计算机主板上，USB端口通常由专门的USB控制器管理，这些控制器支持高速数据传输，并与主板上的其他HSIO接口（如PCIe、SATA等）进行协调。
**Board和MinPlatform的关系在于，MinPlatform可以作为一个通用的起点，用于构建特定Board的UEFI固件。开发者可以根据特定的Board的硬件配置和要求，在MinPlatform的基础上进行定制和扩展，以满足特定硬件产品的需求。因此，MinPlatform提供了一个通用的固件开发基础，可帮助加快特定Board的固件开发。**
FSP与Board和MinPlatform的关系：
与Board的关系：FSP可以作为针对特定Board的硬件平台的基础。它为特定的英特尔处理器平台提供初始化代码，有助于在特定Board上实现UEFI固件的启动和硬件初始化。
与MinPlatform的关系：FSP可以与MinPlatform结合使用。MinPlatform作为通用的UEFI固件开发基础，而FSP提供了特定处理器平台的初始化代码。结合使用两者可帮助在MinPlatform的基础上定制和扩展适用于特定处理器平台的UEFI固件。
# 13 PCIe 与 CXL

**PCI架构的基本结构包括：**
![[Pasted image 20231230183321.png]]
![[Pasted image 20231230183256.png]]
总线
PCI总线是连接计算机主板和各种外部设备的物理通道。它是一种串行的、并行传输数据的总线结构，通过电路板上的插槽（插槽被称为PCI插槽）连接设备和主板。每个PCI插槽都有一条独立的数据通道，允许设备与主板进行通信。
**设备**
PCI架构中的设备是指连接到PCI总线上的各种外部硬件组件，如网卡、显卡、声卡、存储控制器等。这些设备通过PCI插槽插入主板上，并利用PCI总线与主板通信。
**桥接器**
桥接器是PCI架构中的重要组成部分，用于连接不同PCI总线之间的通信。它们可以连接不同速度、不同类型的PCI总线，允许数据在这些总线之间进行交换和传输。
**控制器**
控制器是PCI架构的一部分，用于管理和控制PCI总线上的数据传输和通信。它负责确保设备之间的正确通信和数据传输。
**总线拓扑**
PCI架构可以形成多种不同的总线拓扑结构，如单总线、多总线、星型结构等，以满足不同计算机系统的需求和扩展性要求。

总体而言，PCI架构提供了一个灵活且高效的方式，允许不同类型的设备连接到计算机系统，实现数据传输和通信。这种结构在计算机硬件的发展中扮演着重要的角色，为设备互联和性能提升提供了基础。

**PCI Express（PCIe）是一种高速串行计算机总线标准，用于连接计算机主板和外部设备。它是PCI架构的进化版，旨在提供更高的数据传输速度和更大的带宽，以满足日益增长的数据传输需求。**
结构和特点：
**高速传输**：
PCIe采用串行传输，与传统的并行PCI总线相比，能够提供更高的传输速度和更大的带宽。它的速度通常以“通道”的数量来描述（例如，PCIe x1、PCIe x4、PCIe x8、PCIe x16等），每个通道代表一个物理通道，速度和带宽不同。
**多通道设计**：
PCIe允许多个通道并行工作，每个通道都能独立传输数据，这使得在一个PCIe插槽上支持多个通道，提供更高的总带宽。
**热插拔支持**：
类似于PCI，PCIe也支持热插拔功能，允许用户在系统运行时插入或移除设备而无需关闭计算机。
**逐步演进**：
PCIe标准经过多次更新和演进，不断提升速度和性能。不同的PCIe代数（如PCIe 1.0、PCIe 2.0、PCIe 3.0、PCIe 4.0、PCIe 5.0等）拥有不同的传输速度和性能指标。
**适应性强**：
PCIe接口在各种设备中得到广泛应用，例如图形卡、存储控制器、网卡等。它的灵活性和高性能使得它成为连接高速设备的首选接口。
PCIe在计算机硬件领域具有重要地位，随着技术的不断进步，不断更新的PCIe标准提供了更高的性能和更快的数据传输速度，满足了多种设备和应用场景的需求。
**CXL（Compute Express Link）是一种高速、高效的互连标准，旨在连接处理器、存储器和加速器等不同类型的设备，实现数据传输和共享，提高系统性能和灵活性。**
主要特点：
**高速互连**：
CXL提供了高速的数据传输通道，支持非常高的带宽和低延迟，有助于加速计算机系统内部各个组件之间的通信。
**内存扩展**：
CXL允许外部设备直接访问主机内存，这种直接内存访问（DMA）的能力提高了数据共享和处理效率，有助于提升整个系统的性能。
**加速器连接**：
它设计用于与加速器（如GPUs、FPGAs等）进行连接，让这些加速器能够更有效地与主处理器和其他设备进行通信，加速特定计算任务。
**灵活性和兼容性**：
CXL标准的设计考虑到了向后兼容性和未来的扩展，使其在不同设备和应用场景中更具灵活性。
**生态系统发展**：
由多家主要的技术公司支持和推动，这有助于形成一个庞大的生态系统，提供更多兼容性和可用性。
CXL标准的出现是为了解决传统互连技术在处理大规模数据和复杂计算时的瓶颈问题。它的目标是提供更高效、更灵活的数据互连方式，使各种设备更好地协同工作，从而推动数据中心和高性能计算领域的发展。
# 14 memory 与 存储
**课程中的内存定义：**
在这个背景下，“内存”通常指的是主要的计算机内存，通常称为RAM（随机存取存储器）。它是一种易失性内存，用于存储CPU正在使用或处理的数据。这种内存速度很快，但在断电时会丢失其内容。
**计算机主内存中信息的物理形式（DRAM）：**
在计算机的主内存中（比如DRAM - 动态随机存取存储器），信息以电荷的形式存储。DRAM将每个位的信息存储为集成电路中微小电容器中的电荷。
**为什么现代计算机使用二进制而不是十进制：**
计算机使用二进制（二进制数制）是因为计算机内的数字电路能够轻松表示两种状态（开/关、高/低、或者1/0）。二进制表示简化了电子电路的设计，使操作更可靠和高效。这是数字计算的基础。
**电压低于基准电压时的数值：**
在计算机等数字系统中，电压通常与基准电压进行比较以解释数字值。如果电压低于基准电压，通常被解释为逻辑上的“0”。如果电压高于基准电压，则被解释为逻辑上的“1”。因此，如果电压低于基准电压，通常被视为“0”。

**当谈到计算机内存时，有一些关键的概念：**

**内存单元（Memory Cell）：**
内存单元是存储位（bit）的基本单位。它是计算机内存中最小的可寻址存储单位，通常由一个触发器或者电容器等构成，能够存储一个二进制位（0或1）的信息。
**内存矩阵（Memory Matrix）：**
内存矩阵是指内存单元按矩阵排列的方式组成的结构。它构成了计算机内部的存储结构，通过行和列的组合来编址和存储数据。
**内存页面（Memory Page）：**
内存页面是内存管理的一个概念，指的是内存被划分成固定大小的块。操作系统通常将物理内存划分成页面，以便更有效地管理内存空间。
**为何需要地址和数据执行内存操作：**
地址用于唯一标识内存中的特定位置，即确定要读取或写入的位置。数据则是要读取或写入的内容。地址和数据共同决定了内存操作的目标和内容。
**常见的基本内存操作：**
常见的基本内存操作包括：
**读取（Read）：从特定内存地址读取数据。**
**写入（Write）：向特定内存地址写入数据。**
*擦除（Erase）：在某些类型的存储中，特别是闪存等非易失性存储器中，擦除是指将存储单元中的数据清除为初始状态，以便重新写入新的数据。*
*拷贝（Copy）：将数据从一个内存位置复制到另一个位置。*
这些基本操作构成了对计算机内存进行读取、写入和管理的基础，使计算机能够存储和检索数据。
**DIMM模块（DDR技术）：**
DIMM代表双列直插式内存模块。它是一种常见的内存模块，通常用于桌面计算机和服务器，用于提供额外的RAM。DDR（双倍数据率）指的是这些模块中使用的内存技术，与较旧的SDRAM（同步动态随机存取存储器）相比，DDR技术允许更快的数据传输速率。DIMM模块插入主板上的插槽中，有不同的容量（以GB为单位）和速度（例如DDR3、DDR4）可供选择。
主板上焊接的存储（LPDDR技术）：

**LPDDR代表低功耗双倍数据率**。LPDDR存储器常见于移动设备，如智能手机、平板电脑和超薄便携式笔记本电脑，因为它具有低功耗的特点。在某些设备中，尤其是较小和更紧凑的设备中，LPDDR存储芯片直接焊接在主板上，而不是以DIMM模块的形式存在。这种集成节省了空间和功耗，但也意味着内存无法升级或更换，除非更换整个主板。

**易失性内存和非易失性内存：**

易失性内存（比如RAM）是一种在断电时会丢失存储内容的内存。换句话说，它需要持续供电来保持存储的数据。
非易失性内存（比如ROM、闪存）则是一种在断电时可以保持存储内容的内存。即使没有供电，它也能保持存储的数据。
缓存和其位置：

**缓存是一种高速临时存储**，用于暂时保存处理器频繁访问的数据或指令，以提高访问速度。它通常位于处理器内部（CPU内部缓存）、靠近处理器的主板上（L2、L3缓存），也有可能在存储控制器上（磁盘缓存）等地方。
用于存储DRAM中数据的是什么？为什么不使用触发器（Flip-flops）？：

**DRAM中存储数据的是电容器**。电容器中的电荷表示数据的位，但电容器会逐渐失去电荷，因此需要定期刷新来维持存储的数据。与触发器相比，电容器成本更低，但在存储和读取数据时速度较慢。
**“Memory Down”：**
“Memory Down”是一种内存模块的规范，它将内存芯片直接焊接到主板上，而不是使用传统的插槽和模块。这种设计可以减少内存模块的高度，有助于更小型化的设备设计。
**CD-R的内存类型：**
CD-R（可写光盘）是一种光学存储介质，属于只读存储器（ROM）的一种。它允许一次性写入数据，但之后无法修改或删除。所以，它不是随机访问内存，而是一种非易失性存储介质，类似于只读的硬盘或闪存。
**CPU（中央处理器）使用时钟信号来调节其操作。时钟信号是CPU内部的一个节拍信号，它以固定的频率发出脉冲，用于同步和协调CPU内部各部件的工作。**
CPU的时钟控制器会以固定的频率发送时钟脉冲，这些脉冲指示了CPU内部的工作节奏。每个时钟周期是CPU进行一系列操作（比如获取指令、执行指令、读写内存等）的基本单位。

# lab
## lab 06 write simple application in edk2

#### *Conf/target.txt* config platform and compiler
eg:x86+gcc5
```
# Conf/target.txt
ACTIVE_PLATFORM       = OvmfPkg/OvmfPkgX64.dsc
TARGET_ARCH           = X64
TOOL_CHAIN_TAG        = GCC5 #or CLANGPDB
```

#### *OvmfPkg/OvmfPkgX64.dsc*平台可用包配置(dsc中inf)（编辑新应用.c勿忘）
```conf
[Components]
  SampleApp/SampleApp.inf
```
```
  #
  # TPM support
  #
!include OvmfPkg/Include/Dsc/OvmfTpmComponentsDxe.dsc.inc

MdeModulePkg/Application/HelloWorld/HelloWorld.inf
```
#### *SampleApp/SampleApp.inf*编辑程序配置
```conf
[Defines]
  INF_VERSION                    = 0x00010005 #版本 
  BASE_NAME                      = SampleApp # 应用名
  MODULE_UNI_FILE                = SampleApp.uni # uni文件（语言）
  FILE_GUID                      = 6987936E-ED34-44db-AE97-1FA5E4ED2119 #GUID
  MODULE_TYPE                    = UEFI_APPLICATION #模块类型
  VERSION_STRING                 = 1.0 
  ENTRY_POINT                    = UefiMain # 入口函数（main）

#
#  This flag specifies whether HII resource section is generated into PE image.
#
  UEFI_HII_RESOURCE_SECTION      = TRUE

#
# The following information is for reference only and not required by the build tools.
#
#  VALID_ARCHITECTURES           = IA32 X64 EBC
#

[Sources]
  SampleApp.c # 源代码


# 所需包，"packages" 是一种组织代码和资源的方式，它们通常包含一组
#相关的功能、驱动程序、协议和应用程序。每个包可以看作是一个独立的模块，用于处理
#特定的任务或提供特定的功能。例如，可以有一个 ACPI 包用于处理高级配置和电源管
#理，或一个网络协议包用于支持网络通信。Packages 是 EDK2 项目的主要组织单元，可
#以包含多个库（libraries）、应用程序（applications）、设备驱动程序（drivers）等。
[Packages]
  MdePkg/MdePkg.dec 
  MdeModulePkg/MdeModulePkg.dec 

# "library classes" 是 EDK2 中的代码库，它们包含了通用的功
#能和类，可以在不同的包中重复使用。库类可以用于提供通用的功能，如字符串操作、内
#存管理、协议实现等。库类是可重用的代码段，有助于减少重复编写代码的工作，提高代
#码的可维护性和复用性。
[LibraryClasses] 
  UefiApplicationEntryPoint
  UefiLib
  PcdLib


#Packages 是可以独立编译和链接到 UEFI 固件中的功能模块，它们通常包含特定的功能
#或任务的代码和资源。Library Classes 则是可重用的代码库，用于提供通用功能。
#Library Classes 通常不是独立运行的应用程序或功能，它们的代码被包括在 
#Packages 中的其他组件中以实现特定功能。
#Packages 可以依赖于 Library Classes，以使用库类提供的通用功能。

```


#### *SampleApp/SampleApp.c*编辑具体的程序
```c
/** @file
  This sample application bases on HelloWorld PCD setting
  to print "UEFI Hello World!" to the UEFI Console.

  Copyright (c) 2006 - 2018, Intel Corporation. All rights reserved.<BR>
  SPDX-License-Identifier: BSD-2-Clause-Patent

**/

#添加各种头文件
#include <Uefi.h>
#include <Library/PcdLib.h>
#include <Library/UefiLib.h>
#include <Library/UefiApplicationEntryPoint.h>
#include <Library/UefiBootServicesTableLib.h>
#include <Library/BaseMemoryLib.h>
#define CHAR_DOT  0x002E    // '.' in Unicode


//
// String token ID of help message text.
// Shell supports to find help message in the resource section of an application image if
// .MAN file is not found. This global variable is added to make build tool recognizes
// that the help string is consumed by user and then build tool will add the string into
// the resource section. Thus the application can use '-?' option to show help message in
// Shell.
//
GLOBAL_REMOVE_IF_UNREFERENCED EFI_STRING_ID  mStringHelpTokenId = STRING_TOKEN (STR_HELLO_WORLD_HELP_INFORMATION);

/**
  The user Entry Point for Application. The user code starts with this function
  as the real entry point for the application.

  @param[in] ImageHandle    The firmware allocated handle for the EFI image.
  @param[in] SystemTable    A pointer to the EFI System Table.

  @retval EFI_SUCCESS       The entry point is executed successfully.
  @retval other             Some error occurs when executing this entry point.

**/
// EFI_STATUS
// EFIAPI
// UefiMain (
//   IN EFI_HANDLE        ImageHandle,
//   IN EFI_SYSTEM_TABLE  *SystemTable
//   )
// {
//   return EFI_SUCCESS;
// }

EFI_STATUS #函数返回状态
EFIAPI
UefiMain (
  IN EFI_HANDLE        ImageHandle, # 函数句柄
  IN EFI_SYSTEM_TABLE  *SystemTable #函数信息表
  )
{ 
  UINTN          EventIndex;
  BOOLEAN        ExitLoop;
  EFI_INPUT_KEY  Key;
  
  Print(L"Enter text. Include a dot ('.') in a \
        sentence then <Enter> to exit:\n\n");
  ZeroMem (&Key, sizeof (EFI_INPUT_KEY));

  ExitLoop = FALSE;
  do {
    gBS->WaitForEvent (1, &gST->ConIn->WaitForKey,  &EventIndex);
    gST->ConIn->ReadKeyStroke (gST->ConIn, &Key);
    Print(L"%c", Key.UnicodeChar);
    if (Key.UnicodeChar == CHAR_DOT){
      ExitLoop = TRUE;
    }
  } while (!(Key.UnicodeChar == CHAR_LINEFEED  || 
             Key.UnicodeChar == CHAR_CARRIAGE_RETURN) || 
           !(ExitLoop));

  Print(L"\n");
  return EFI_SUCCESS;

}
#可以在.chm中发现需要的接口
```


#### 编译与运行
`build`:也许需要重新`source edksetup.sh`

`run-over/RunQemu.sh`


#### *run-ovmf/RunQemu.sh* config qemu 
```sh
#!/bin/sh
export BUILDIR=../Build/OvmfX64/DEBUG_GCC5
# export QEMU_BIN=/usr/local/bin

rm $BUILDIR/X64/*.debug

qemu-system-x86_64 -net none \
 --bios $BUILDIR/FV/OVMF.fd \
 -drive file=fat:rw:$BUILDIR/X64,id=fat32,format=raw \
 -debugcon file:"ovmf-boot.log" \
 -global isa-debugcon.iobase=0x402 \
 -global ICH9-LPC.disable_s3=1 \
 -nographic
```

ps:graph界面需要特定库支持
ps:远程ssh链接库会开在服务器端

## lab 07——driver的编写

#### inf文件
```conf
#Samplepei.inf 模块声明文件
[Defines]
  INF_VERSION                    = 0x00010005
  BASE_NAME                      = SamplePei #编译输出文件名
  FILE_GUID                      = EED5EA31-38E2-463d-B623-2C57702B8A88 #guid
  MODULE_TYPE                    = PEIM 
  VERSION_STRING                 = 1.0
  ENTRY_POINT                    = SamplePeiEntry #模块入口函数
  # MODULE_UNI_FILE                = SamplePei.uni

[Sources]
  SamplePei.c #列出源文件与资源文件

[Packages]
  MdePkg/MdePkg.dec #依赖包文件

[LibraryClasses]
  PeimEntryPoint #依赖库文件


[Ppis] #链接声明
  gEfiPeiMemoryDiscoveredPpiGuid #内存
[Depex]
  TRUE #依赖声明，在发现阶段生效，指明依赖，只有在依赖满足的情况下才加载。TRUE为无依赖
```
#### dsc文件
OvmfPkg/OvmfPkgX64.dsc
[Components]块下增加SamplePei/SamplePei.inf(尽量加在对应phase modules)

#### fdf文件
OvmfPkg/OvmfPkgX64.fdf
[FV.PEIFV]块下增加INF  SamplePei/SamplePei.inf
按顺序发现，满足依赖者加载。
循环遍历直至所有都加载
APRIORI PEI {}块中优先加载，无视依赖（依靠用户保证正确性）

#### c文件 hook函数
```c
#include <PiPei.h>
#include <Library/DebugLib.h>
#include <Library/PeiServicesLib.h>

#handle函数
EFI_STATUS
EFIAPI
SamplePeimCallback (
  IN EFI_PEI_SERVICES **PeiServices,
  IN EFI_PEI_NOTIFY_DESCRIPTOR *NotifyDescriptor,
  IN VOID *Ppi
 )
{
 DEBUG((DEBUG_INFO, "%a(): PostMem phase\n", __FUNCTION__));
 return EFI_SUCCESS;
}

#函数绑定,gEfiPeiMemoryDiscoveredPpiGuid时调用SamplePeimCallback
EFI_PEI_NOTIFY_DESCRIPTOR mSamplePeimNotifyListTemplate = {
 (EFI_PEI_PPI_DESCRIPTOR_NOTIFY_CALLBACK | EFI_PEI_PPI_DESCRIPTOR_TERMINATE_LIST),
 &gEfiPeiMemoryDiscoveredPpiGuid,
 SamplePeimCallback
};

EFI_STATUS
EFIAPI
SamplePeiEntry (
  IN       EFI_PEI_FILE_HANDLE  FileHandle,
  IN CONST EFI_PEI_SERVICES     **PeiServices
  )
{
  EFI_STATUS              Status;

  DEBUG ((DEBUG_INFO, "%a(): Hello! liuzhuo\n", __FUNCTION__));
  DEBUG((DEBUG_INFO, "%a(): PreMem phase\n", __FUNCTION__));
  #设置回调
  Status = PeiServicesNotifyPpi(&mSamplePeimNotifyListTemplate);
  ASSERT_EFI_ERROR(Status);
  return EFI_SUCCESS;
}
```
#### shadow a driver
```
//本句柄注册到shadow里面（shadow内的driver将在memory ready后再次调用）
Status = (*PeiServices)->RegisterForShadow(FileHandle);
```

## slides 08 write a UEFI driver model

## DRIVER MODEL 理论了解

#### UEFI driver model
UEFI 驱动程序管理硬件并扩展固件

UEFI 中引入了驱动模型的概念，用于简化设备/总线驱动的设计和实现。
https://zhuanlan.zhihu.com/p/26210523

>UEFI driver is chained into a link list of Drivers Managing Devices

UEFI driver model 以链式结构组织stack，层层嵌套，可以共用底层，节省代码量，新driver可以插入链中。

#### UEFI protocol
- protocols:functions+GUID in handle DB. dxe阶段的函数接口，类似pei中的ppi
- handle DB:everything in UEFI用一个句柄
- GUIDS：在DB中找protocol的标识
![Alt text](finish%20class/UEFI/image.png)

#### UEFI Driver Binding Protocol（*UEFI驱动模型核心，管理驱动程序，必装）

- supported():检查设备是否支持该驱动
- start()：将驱动安装到设备
- stop()：卸载驱动

![Alt text](finish%20class/UEFI/image-1.png)
1. load *driver
2. connect controller
3. disconnect controller
4. unload *driver
>如遍历所有设备,调用supported()，找到所有鼠标驱动可以支持的鼠标，对这些鼠标调用start().

