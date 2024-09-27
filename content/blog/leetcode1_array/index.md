---
title: leetcode1_array
summary: summary
date: 2024-09-26
authors:
- admin
tags:
- example
image:
caption: "Image credit: [**Unsplash**](https://unsplash.com)"
commentable: true
---
# 数组
记得vector容器也可能通过下标访问（[]）
## **数组理论基础**
**数组是存放在连续内存空间上的相同类型数据的集合。**
数组可以方便的通过下标索引的方式获取到下标下对应的数据。
举一个字符数组的例子，如图所示：
![](Pasted%20image%2020240926110739.png)
- **数组下标都是从0开始的。**
- **数组内存空间的地址是连续的**
正是**因为数组的在内存空间的地址是连续的，所以我们在删除或者增添元素的时候，就难免要移动其他元素的地址。**
![](Pasted%20image%2020240926110750.png)
而且大家如果使用C++的话，要注意vector 和 array的区别，vector的底层实现是array，严格来讲vector是容器，不是数组。
**数组的元素是不能删的，只能覆盖。**
**二维数组**
![](Pasted%20image%2020240926110902.png)

**那么二维数组在内存的空间地址是连续的么？**
**在C++中二维数组在地址空间上是连续的**。
像Java是没有指针的，同时也不对程序员暴露其元素的地址，寻址操作完全交给虚拟机。地址是没有规则的，更谈不上连续。所以Java的二维数组可能是如下排列的方式：
![](Pasted%20image%2020240926110917.png)
## 数据题目
### 27 移除元素
``` c++
/*
 * @lc app=leetcode.cn id=27 lang=cpp
 *
 * [27] 移除元素
 *
 * https://leetcode.cn/problems/remove-element/description/
 * 给你一个数组 nums 和一个值 val，你需要 原地
 * 移除所有数值等于 val 的元素，并返回移除后数组的新长度。
 * 不要使用额外的数组空间，你必须仅使用 O(1) 额外空间并 原地 修改输入数组。
 *
 * 元素的顺序可以改变。你不需要考虑数组中超出新长度后面的元素。
 * 说明:
 * 为什么返回数值是整数，但输出的答案是数组呢?
 * 请注意，输入数组是以「引用」方式传递的，这意味着在函数里修改输入数组对于调用者是可见的。
 *
 * 你可以想象内部操作如下:
 *
 *
 * // nums 是以“引用”方式传递的。也就是说，不对实参作任何拷贝
 * int len = removeElement(nums, val);
 *
 * // 在函数里修改输入数组对于调用者是可见的。
 * // 根据你的函数返回的长度, 它会打印出数组中 该长度范围内 的所有元素。
 * for (int i = 0; i < len; i++) {
 * print(nums[i]);
 * }
 *
 *
 *
 *
 * 示例 1：
 *
 *
 * 输入：nums = [3,2,2,3], val = 3
 * 输出：2, nums = [2,2]
 * 解释：函数应该返回新的长度 2, 并且 nums 中的前两个元素均为
 * 2。你不需要考虑数组中超出新长度后面的元素。例如，函数返回的新长度为 2 ，而
 * nums = [2,2,3,3] 或 nums = [2,2,0,0]，也会被视作正确答案。
 *
 *
 * 示例 2：
 *
 *
 * 输入：nums = [0,1,2,2,3,0,4,2], val = 2
 * 输出：5, nums = [0,1,3,0,4]
 * 解释：函数应该返回新的长度 5, 并且 nums 中的前五个元素为 0, 1, 3, 0,
 * 4。注意这五个元素可为任意顺序。你不需要考虑数组中超出新长度后面的元素。
 *
 *
 *
 *
 * 提示：
 *
 *
 * 0 <= nums.length <= 100
 * 0 <= nums[i] <= 50
 * 0 <= val <= 100
 *
 *
 */

// @lc code=start

// a[i];  //直接访问a中第i个元素
// a.at(i);  //同上
// a.empty();  //判断是否为空，是则返回true，否则返回false
// a.size();  //返回a中的所存储元素的数量
// a.push_back(x);  //将x压入a的末尾
// a.pop_back();  //将a的末尾元素出栈(返回值为void类型)
// a.front();  //返回第一个元素
// a.clear();  //清除a中所有的元素
// a.insert(it,x);  //在it前添加x
// a.insert(it,n,x);  //在it前添加n个x
// a.max_size();  //返回vector的最大容量
// a.capacity();  //返回a所能容纳的最大元素值
// a.erase(it);  //删除it这个迭代器所指向的值
// a.erase(first,last);  //删除从[first，last)的值
// a.resize(n);  //改变长度，超过的话则删除多余部分，少的话则增添默认值
// a.resize(n,x);  //同上，默认值改为x
// a.clear();  //删除所有的元素
// a.assign(first,last);  //a中替换first，last，first到last这个区间的值不能为a
// vector<int>::iterator it1;  //正向迭代器
// vector<int>::reverse_iterator it2;  //反向迭代器
// a.begin();  a.end();  //正向迭代器所用
// a.rbegin();  a.rend();
// //反向迭代器所用，rbegin()相当于end()-1,rend()相当于begin()+1
// reverse(a.begin(),a.end());  //将a翻转
// sort(a.begin(),a.end(),cmp);
// //排序，cmp处可以不写，默认为正向,也可以自己写排序的函数，默认有less<int>()和greater<int>()

#include <algorithm>
#include <vector>

using namespace std;
class Solution {
public:
  int removeElement(vector<int> &nums, int val) {
    // vector<int>::iterator it;
    // for (it = nums.begin(); it != nums.end(); it++) {
    //   // //
    //   //
    //
    // 当您在迭代向量时删除向量中的元素时，会使迭代器无效，从而导致未定义的行为,如：
    //   //   if (*it == val) {
    //   //     nums.erase(it);
    //   //   }

    // std::remove 是一个算法，位于 <algorithm>
    // 头文件中。它用于在序列中移除满足特定条件的元素，并
    //将它们移到序列的末尾，但不会改变序列的大小。
    //它返回一个指向被移除元素的末尾的迭代器。下面先移到末尾并返回该元素头，一起删除
    nums.erase(std::remove(nums.begin(), nums.end(), val), nums.end());
    return nums.size();
  }
};

// 题目标准解答
class Solution {
public:
  int removeElement(vector<int> &nums, int val) {
    //由于不需要保持原来的顺序，所以可以直接用后面的值填充删掉的位置
    int length = nums.size();
    int index = 0;
    while (index < length) {
      if (nums[index] == val) {
        nums[index] = nums[length - 1];
        length--;
      } else { //注意到应检查换得的值是否为val
        index++;
      }
    }
    return length;
  }
};

//如果要求数组顺序不能发生改变，则题目需要重新思考，考虑双指针法，一个检索，一个存储。
class Solution {
public:
  int removeElement(vector<int> &nums, int val) {
    //快指针扫过，val值跳过，非val值存入慢指针位置并移动慢指针，由于快指针一定比慢指针走的
    //快，从而实现in-place更改。当快指针遍历一遍后，慢指针位置即为结果数组尾部。
    int length = nums.size();
    int fastIndex = 0, lowIndex = 0;
    while (fastIndex < length) {
      if (nums[fastIndex] != val) {
        nums[lowIndex] = nums[fastIndex];
        lowIndex++;
      }
      fastIndex++;
    }
    return lowIndex;
  }
};
//相关题目推荐
// 26.删除排序数组中的重复项
// 283.移动零
// 844.比较含退格的字符串
// 977.有序数组的平方

```