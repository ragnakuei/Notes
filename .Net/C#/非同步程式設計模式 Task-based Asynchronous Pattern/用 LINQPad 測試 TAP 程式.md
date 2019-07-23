

用 LINQPad 測試 TAP 程式

因為 LINQPad 的功能比較強大，會抓出 Thread Pool 中所有 Thread 的 Exception
![Alt text](_images/01.png)

但實際上 C#  執行時，會抓不到 async void Method 內的 Exception

沒事就不要用 async void 的 Method
