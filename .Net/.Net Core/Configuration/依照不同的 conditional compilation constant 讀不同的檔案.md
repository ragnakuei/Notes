# 依照不同的 conditional compilation constant 讀不同的檔案

預設的 conditional compilation constant 通常是 DEBUG 跟 RELEASE

可以搭配 conditional compilation 來給定不同的參數

-   針對執行的專案上，加上不同的 Configuration
-   開啟 Project Properties > `Build` Tab > 在 `Conditional compilation constant` 輸入對應 Configuration 的字串
-   在 Program.cs 中加上 conditional compilation，在不同的 conditional compilation constant 給定不同的變數值

    ```csharp
    public class Program
    {
        public static void Main(string[] args)
        {
            CreateHostBuilder(args).Build().Run();
        }

        public static IHostBuilder CreateHostBuilder(string[] args)
            => Host.CreateDefaultBuilder(args)
                .ConfigureAppConfiguration((hostingContext, config) =>
                                           {
                                               config.AddJsonFileByConfiguration(optional: false, reloadOnChange: true);
                                           })
                .ConfigureWebHostDefaults(webBuilder =>
                                            {
                                                webBuilder.UseStartup<Startup>();
                                            });
    }

    public static class AddJsonFileByConfigurationHelper
    {
        public static IConfigurationBuilder AddJsonFileByConfiguration(this IConfigurationBuilder builder, bool optional, bool reloadOnChange)
        {
    #if Debug
            var configConst = "Debug";
    #elif SiteA
            var configConst = "SiteA";
    #elif SiteB
            var configConst = "SiteB";
    #elif SiteC
            var configConst = "SiteC";
    #elif Release
            var configConst = "Release";
    #endif
            builder.AddJsonFile($"appsettings.{configConst}.json", optional, reloadOnChange);
            return builder;
        }
    }
    ```

-   就可以在不同的 configuration 下，來讀取不同的組態檔了 !
