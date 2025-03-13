---
title: leetcode2_list
summary: summary
date: 2024-09-26
authors:
  - admin
tags:
  - leetcode
  - list
image: 
caption: "Image credit: [**Unsplash**](https://unsplash.com)"
commentable: true
---
单链表与双链表

![](https://m6jnrjuldk.feishu.cn/space/api/box/stream/download/asynccode/?code=YmFlZmVmN2UxNDI1NzU0OTYwMmRjOGMxYThhZWE3MDNfdjNLYWlJUFpnNm5vVkMwV0hLM3ZkclZVVXVwQVMwSWFfVG9rZW46TElXV2I0M0R5b2J1aFp4Q1gxU2MwdzFCbnNjXzE3NDE4NjQzNTE6MTc0MTg2Nzk1MV9WNA)

![](https://m6jnrjuldk.feishu.cn/space/api/box/stream/download/asynccode/?code=NGFhNzliMWUyNTNlNzQ5YjQxYjZmNDU4ZTQ3ODE4MWFfYmlpTFdXTmhHc09PcEdqejFzT0RDbklUalhTUWc4Zk1fVG9rZW46WHBjWWJYNVBnb2lZOHR4c2E1TGM2NVpObnJlXzE3NDE4NjQzNTE6MTc0MTg2Nzk1MV9WNA)

```C++
//单链表节点
struct ListNode {
    int val;  // 节点上存储的元素
    ListNode *next;  // 指向下一个节点的指针
    ListNode(int x) : val(x), next(NULL) {}  // 节点的构造函数
};
```

再把链表的特性和数组的特性进行一个对比，如图所示：

![](https://m6jnrjuldk.feishu.cn/space/api/box/stream/download/asynccode/?code=ZTM2NTM3NmUxZTNjNjlkYjMzMWVmYWNkMjFmMzRlN2RfdmpGWDluVXo0aVNnVlV6UHlqN0JxWkoyQXBHdUFacHBfVG9rZW46UDlDYWJrVzgwb1dTbDJ4eUtXMGN2SFo3bkdlXzE3NDE4NjQzNTE6MTc0MTg2Nzk1MV9WNA)

数组在定义的时候，长度就是固定的，如果想改动数组的长度，就需要重新定义一个新的数组。

链表的长度可以是不固定的，并且可以动态增删， 适合数据量不固定，频繁增删，较少查询的场景。

链表常见的特殊情况：头节点，空链表，单数据链表——常见利用虚拟头节点统一特殊情况。

## 206 反转链表

![](https://m6jnrjuldk.feishu.cn/space/api/box/stream/download/asynccode/?code=MzBmYmM1OWZmNTUwNWQ3ZGEzNWJmZWUzZjY4NDY2NTBfbDZ2dnRob01HWnBzVkEzT1hBUURKQXRCU0RqVG9xdWxfVG9rZW46SmszMmJJS2hnb1JzWTZ4dHVUeGNydkFVbjZnXzE3NDE4NjQzNTE6MTc0MTg2Nzk1MV9WNA)

首先定义一个cur指针，指向头结点，再定义一个pre指针，初始化为null。

然后就要开始反转了，首先要把 cur->next 节点用tmp指针保存一下，也就是保存一下这个节点。

为什么要保存一下这个节点呢，因为接下来要改变 cur->next 的指向了，将cur->next 指向pre ，此时已经反转了第一个节点了。

```C++
struct ListNode {
  int val;
  ListNode *next;
  ListNode() : val(0), next(nullptr) {}
  ListNode(int x) : val(x), next(nullptr) {}
  ListNode(int x, ListNode *next) : val(x), next(next) {}
};
class Solution {
public:
  ListNode *reverseList(ListNode *head) {
    //担心丢失前向数据时，多创建变量记录即可（也可理解为用多指针进行迭代）
    ListNode *pre = nullptr;
    ListNode *cur = head;
    ListNode *tmp;
    //本题建议画图进行流程表达，明确过程与终止条件。也可做为指针指代的练习，记住指针赋值为指向同一地址。
    while (cur) {
      tmp = cur->next;
      cur->next = pre;
      pre = cur;
      cur = tmp;
    }
    head = pre;
    return head;
  }
};

//递归方式
class Solution {
  //多品味一下递归的写法
public:
  ListNode *reverse(ListNode *pre, ListNode *cur) {
    if (cur) {
      ListNode *tmp = cur->next;
      cur->next = pre;
      pre = cur;
      cur = tmp;
      //记得return
      return reverse(pre, cur);
    }
    return pre;
  }
  ListNode *reverseList(ListNode *head) {
    head = reverse(nullptr, head);
    return head;
  }
};
```

## 29 删除倒数第n个元素

双指针的经典应用，如果要删除倒数第n个节点，让fast移动n步，然后让fast和slow同时移动，直到fast指向链表末尾。删掉slow所指向的节点就可以了。

推荐大家使用虚拟头结点，这样方便处理删除实际头结点的逻辑。

- 定义fast指针和slow指针，初始值为虚拟头结点，如图：
    

![](https://m6jnrjuldk.feishu.cn/space/api/box/stream/download/asynccode/?code=NWQwNzBlNzVhZDIxZWVjOTFiZDZhYWE0MjRlNGRlNWJfSFptanRBUVhFZUt6czBTZkp1ejZJQzZlR2c5NUQ0NjdfVG9rZW46UTd6WGI2VFd4b01pNHV4ckNHS2NETjhJbjhlXzE3NDE4NjQzNTE6MTc0MTg2Nzk1MV9WNA)

- fast首先走n + 1步 ，为什么是n+1呢，因为只有这样同时移动的时候slow才能指向删除节点的上一个节点（方便做删除操作），如图：
    

![](https://m6jnrjuldk.feishu.cn/space/api/box/stream/download/asynccode/?code=NDViYjY5M2NlNmVmYTY0ODU4OTIzYjVmMzNmOTg1ZGZfc3U3cExHMnBkTkFMY3ViYWRaZGZNbG5LTEZnV1FsdUdfVG9rZW46V2RFM2JpcEhWb0ZYcHV4bXpDR2NFMldzbkJiXzE3NDE4NjQzNTE6MTc0MTg2Nzk1MV9WNA)

- fast和slow同时移动，直到fast指向末尾，如题：
    

![](https://m6jnrjuldk.feishu.cn/space/api/box/stream/download/asynccode/?code=OTQ4M2IyY2E3MDIzYTJlMWJhMGFhODNlODlkZWNhM2ZfU0I2V1Zkcm40OTNRSGo0bTNxOHh2YmVMcVdMaFpwMXZfVG9rZW46WDYzYWJlS0hDb3ByZVF4bjZ4dWNiZEtDblprXzE3NDE4NjQzNTE6MTc0MTg2Nzk1MV9WNA)

- 删除slow指向的下一个节点，如图：
    

![](https://m6jnrjuldk.feishu.cn/space/api/box/stream/download/asynccode/?code=ZDIwZTYwYzc5YmJlYjJlYmY2NTc3YzMzZDQwN2NjNThfQXVlbXFqeWVuTWl3VlJuc0xqRURlZ1BSNTkxUGg2WnNfVG9rZW46UWhLTmJqc3pOb0dEWkh4UzZucWNlZ01vblRjXzE3NDE4NjQzNTE6MTc0MTg2Nzk1MV9WNA)

```C++
class Solution {
public:
  ListNode *removeNthFromEnd(ListNode *head, int n) {
    ListNode *high = head;
    ListNode *low = head;
    while (n > 0) {
      high = high->next;
      n--;
    }
    // high->val有意义，有值

    //当high移动到了nullptr而非一个具体的节点时，即删除头节点，即长度不支持窗口。
    //若采用创建虚拟头节点的方式则无需考虑该问题。
    if (!high) {
      head = head->next;
      return head;
    }
    while (high->next) {
      high = high->next;
      low = low->next;
    }
    ListNode *tmp;
    tmp = low->next;
    if (low->next) {
      low->next = low->next->next;
    } else {
      low->next = nullptr;
    }
    delete tmp;
    return head;
  }
};
```

## 24 两两交换链表元素

_**本题主要练习过程模拟中的细节考虑以及虚拟头节点的使用**_

接下来就是交换相邻两个元素了，**此时一定要画图，不画图，操作多个指针很容易乱，而且要操作的先后顺序**

初始时，cur指向虚拟头结点，然后进行如下三步：

![](https://m6jnrjuldk.feishu.cn/space/api/box/stream/download/asynccode/?code=NjI1ZTQ5NDZhOTZlODg0YjAwNzkwODc4NmI2NjMzY2NfT3FnQkgzV3BUTzdqOXMzQkhSZTkxRnhzdjk2eGlKc1RfVG9rZW46STh6Z2JFWHpJbzlUd0N4YzVCTWNQN0xvbm9kXzE3NDE4NjQzNTE6MTc0MTg2Nzk1MV9WNA)

操作之后，链表如下：

看这个可能就更直观一些了：

![](https://m6jnrjuldk.feishu.cn/space/api/box/stream/download/asynccode/?code=YmMyZGYwYWNiYjMzY2Q5MTc4OGE2ZmE4ZmRlNzU3MWFfTnlVazVyYjN1RGEyWWpKY2k1MDZTamNMY0c2dW5IWmVfVG9rZW46SmlaZmJpbFhQb2pjNGZ4cGpkcGMyS2JFbmxkXzE3NDE4NjQzNTE6MTc0MTg2Nzk1MV9WNA)

```C++
class Solution {
public:
  ListNode *swapPairs(ListNode *head) {
    //多用几个指针记录后继即可解决，链表指针操作记得多画图
    //利用虚拟头节点消去特殊性
    ListNode *tmp;
    ListNode *dummyHead = new ListNode(0, head);
    ListNode *p = dummyHead;
    while (p->next && p->next->next) {
      tmp = p->next;
      //画图明确三步走，想清楚再写
      p->next = p->next->next;
      tmp->next = tmp->next->next;
      p->next->next = tmp;
      //使用while注意迭代变化条件
      p = p->next->next;
    }
    //注意head指向的节点可能不再是要返回的头节点。尤其在使用dummyHead时。
    return dummyHead->next;
  }
};
```

  

## 142 环形链表入环点

解题思路：

这类链表题目一般都是使用双指针法解决的，例如寻找距离尾部第 K 个节点、寻找环入口、寻找公共尾部入口等。

在本题的求解过程中，双指针会产生两次“相遇”。

双指针的第一次相遇：

设两指针 fast，slow 指向链表头部 head 。

令 fast 每轮走 2 步，slow 每轮走 1 步。

执行以上两步后，可能出现两种结果：

第一种结果： fast 指针走过链表末端，说明链表无环，此时直接返回 null。

如果链表存在环，则双指针一定会相遇。因为每走 1 轮，fast 与 slow 的间距 +1，fast 一定会追上 slow 。

第二种结果： 当fast == slow时， 两指针在环中第一次相遇。下面分析此时 fast 与 slow 走过的步数关系：

设链表共有 a+b个节点，其中 链表头部到链表入口 有 a 个节点（不计链表入口节点）， 链表环 有 b个节点；设两指针分别走了 f，s 步，则有：

![](https://m6jnrjuldk.feishu.cn/space/api/box/stream/download/asynccode/?code=Y2Q3OWJmMzE5YjRmNGVlYjQyOGJkYWY2ZjUxY2Q4Yzlfdndpa3NXcG10RTdDT3FUN01YOHpnMzQ0Zkdtb2lKcUpfVG9rZW46Qk9iRWIwNU1EbzdtV2h4clVLTmNMNG9HbndnXzE3NDE4NjQzNTE6MTc0MTg2Nzk1MV9WNA)

fast 走的步数是 slow 步数的 2 倍，即 f=2s；

fast 比 slow 多走了 n个环的长度，即 f=s+nb；

将以上两式相减得到 f=2nb，s=nb，即 fast 和 slow 指针分别走了 2n，n 个环的周长。

如果让指针从链表头部一直向前走并统计步数k，那么所有 走到链表入口节点时的步数 是：k=a+nb。而目前 slow 指针走了 nb步。因此让 slow 再走 a就可以到环的入口，而从头节点走a部也到入口点。

因此可以再次启用双指针。

```C++
class Solution {
public:
  ListNode *detectCycle(ListNode *head) {
    ListNode *fast = head, *slow = head;
    //快慢重合，定位到距入环点x距离，同时x也是head到入环点距离。
    while (fast && fast->next) {
      fast = fast->next->next;
      slow = slow->next;
      if (fast == slow) {
        break;
      }
    }
    if (fast == nullptr)
      return nullptr;
    if (fast->next == nullptr)
      return nullptr;
    fast = head;
    while (fast != slow) {
      fast = fast->next;
      slow = slow->next;
    }
    return fast;
  }
};
```

  

## 总结

![](https://m6jnrjuldk.feishu.cn/space/api/box/stream/download/asynccode/?code=MmY0NDdjYzI5ODJlOWUxYjE5ZjI5ZDBiMTlhMzg3YjdfblBIaXJxakVCckd0OGNYWUIxbkNvbGMwSFRGZ2hvZHRfVG9rZW46TzRSZGJZZXJNbzZvODJ4azJ4MGN5dHQzbmNkXzE3NDE4NjQzNTE6MTc0MTg2Nzk1MV9WNA)