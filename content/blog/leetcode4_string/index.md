---
title: leetcode4_string
summary: summary
date: 2024-09-26
authors:
  - admin
tags:
  - string
  - leetcode
image: 
caption: "Image credit: [**Unsplash**](https://unsplash.com)"
commentable: true
---
c++字符串 https://www.runoob.com/cplusplus/cpp-strings.html

技巧，多次reverse(s.begin,s.end)实现字符串变换操作——整体reverse加字串reverse

技巧，替换/增添/删除字符串（数组）时，可能导致resize，从后向前填充，可以in-place实现

## KMP

理论：https://www.cnblogs.com/zzuuoo666/p/9028287.html

实现（别看了，看油管视频吧）：https://github.com/youngyangyang04/leetcode-master/blob/master/problems/0028.%E5%AE%9E%E7%8E%B0strStr.md

youtube：https://www.youtube.com/watch?v=af1oqpnH1vA

主串指针是不会回退的。

![](https://m6jnrjuldk.feishu.cn/space/api/box/stream/download/asynccode/?code=NGEzOWU1N2M0Nzg3MGI0ZDQ2MWRlM2E2MjNjYTUyMmZfZ3ZPUlJEdUNkcG11M0U3V1Y2OTBtNk1sMkZDUjJWZ25fVG9rZW46SHd1ZGJlc0lab2FLcGt4c1U2S2NoTUNwbmtjXzE3NDE4NjQ0NDU6MTc0MTg2ODA0NV9WNA)

next数组代表下一位匹配失败时，字串可以跳过匹配（后缀已经匹配成功前缀的）的数量——即前两个已经匹配成功了(论证可行：首先匹配失败点前面肯定没有字串。数字越大，代表可以已经匹配成功的越多，子串移动的越小。实际上是逐渐移动，直至失败点前面再次匹配)

![](https://m6jnrjuldk.feishu.cn/space/api/box/stream/download/asynccode/?code=MDhjNjI2MjY3YmNkNDRhZWIwMWY4M2M3ODY1ZTMxOWZfMEJ2NnFrVXg5OVk4eHdLTWt6c0ZOQngxSWxUcTYzak9fVG9rZW46VXZxaWJEaWY3bzJlbHl4MHhuTGNPVHBkbmZjXzE3NDE4NjQ0NDU6MTc0MTg2ODA0NV9WNA)

next数组的求解，相同，共同前后缀长度加一，不同，查找前缀内部的共同前后缀，得到前缀，和后缀内部的共同前后缀一定相同，继续匹配，直至0终止（有种动规的美）

  

## 459重复的子字符串

那么既然前面有相同的子串，后面有相同的子串，用 s + s，这样组成的字符串中，

后面的子串做前串，前面的子串做后串，中间就一定还能组成一个s

```C++
class Solution {
public:
  bool repeatedSubstringPattern(string s) {
    string ss = s + s;
    ss.erase(ss.begin());
    //不能擦end，记得最后一个元素是end-1
    ss.erase(ss.end() - 1);
    //熟悉一下字符串的用法。
    if (ss.find(s) == string::npos)
      return false;
    return true;
  }
};
```