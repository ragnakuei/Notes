
當使用平行處理時
- 會佔用用到的 CPU 幾C幾T 的 幾T
  - 被佔用的 T，就只會負責所分配的作業
  - 如果作業時間過長
    - 也許會導致所佔用的 T 過於閒置
    - 讓其他的 T 更忙
- 建議最多只用到 總T 的一半，甚至只設定為 1
  - 看情況調整

https://dotblogs.com.tw/rainmaker/2016/05/23/154835

http://sharedderrick.blogspot.com/2009/12/parallelismmaxdopcost-threshold-for.html

