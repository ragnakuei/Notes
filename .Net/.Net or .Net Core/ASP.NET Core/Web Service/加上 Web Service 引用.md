# 加上 Web Service 引用

參考資料
- [在ASP.NET Core呼叫Web/WCF服務](https://blogs.uuu.com.tw/Articles/post/2019/02/06/%E5%9C%A8ASPNET-Core%E5%91%BC%E5%8F%ABWebWCF%E6%9C%8D%E5%8B%99.aspx)

### vs2022

1. 建立 webform 專案
    1. 建立 web service (.asmx)
1. 建立 asp.net core web api 專案
    1. 在 Connected Services 上面按下滑鼠右鍵，選擇 Manage Connected Services > 開啟 Connected Services Tab
    1. Service Reference (OpenAPI, gRPC, WCF Web Service) > 右邊 + 號 (Add a new service reference)
        1. 選擇 WCF Web Service
            1. 執行上面 webform 專案，讓 Web Service 可以被存取
        1. URI 輸入 Web Service URL，例：https://localhost:44390/TestWS.asmx
        1. 按下 Discover，確認 Service / Operations 都正常顯示
        1. 輸入想要的 namespace
        1. 勾選 Reuse types in referenced assemblies
        1. Next
        1. Access level for generated classes，選擇 Public
        1. Finish
    1. 在 Controller 中，直接用類似下面的語法呼叫
        ```cs
        [HttpGet]
        public async Task<IActionResult> GetAsync()
        {
            var binding = new BasicHttpBinding();
            
            // 如果要以 https 存取 web service
            binding.Security.Mode = BasicHttpSecurityMode.Transport;

            var address = new EndpointAddress("https://localhost:44390/TestWS.asmx");

            var result = await new TestWSSoapClient(binding, address).SumAsync(1, 2);
            return Ok(result);
        }
        ```
 1. vs2022 設定二個專案同時啟動
 1. 測試成功
