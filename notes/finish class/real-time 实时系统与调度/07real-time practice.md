- hard real-time：missing is failure
> 自动驾驶，防抱死
- soft real-time：missing reduces usefulness
> 浏览网站

### RTOS —— real-time OS

实时特性：估测任务最大执行时间。
key： 中断处理，调度机制，关键部分处理

RTOS常实现为严格抢占式，高优先级任务先执行，确保更大的实时性。

>ps : GPOS（General Public Operating System）调度任务不总是遵照优先级，一些优化策略可能影响执行。如可并发的低优先级任务可能会先被调度以达到高吞吐量。

### FreeRTOS
FreeRTOS: FreeRTOS is a popular open-source real-time operating system designed for embedded systems and IoT devices. It's known for its small footprint and wide hardware support.

1. prvSetupHardware
2. xTaskCreate
3. vTaskStartScheduler
4. vApplicationIdleHook
设计与实现，详见chapter 7

### POK
