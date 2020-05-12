# re-throw Exception 效能

會有額外的成本來處理 Exception。但如果只是為了讓外層的 catch 可以明確分辨 Exception 來自於哪裡，勉強可以接受一次的 re throw exception 動作。

[Sample](https://github.com/ragnakuei/ReThrowExceptionPerformance)

| Method |     Mean |     Error |    StdDev |  Gen 0 | Gen 1 | Gen 2 | Allocated |
|------- |---------:|----------:|----------:|-------:|------:|------:|----------:|
|  測試項目1 | 17.94 us | 0.2144 us | 0.2006 us | 0.0305 |     - |     - |     216 B |
|  測試項目2 | 37.08 us | 0.3618 us | 0.3208 us |      - |     - |     - |     288 B |
