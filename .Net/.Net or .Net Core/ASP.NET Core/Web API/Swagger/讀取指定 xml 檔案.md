# 讀取指定 xml 檔案

一開始的設定有可能不會顯示 Summary 與 Remarks 的內容

調整步驟如下

1. Rider

    1. Debug 組態下，XML Document 要勾選 Generate
    1. Documentation file 會自動產生 xml 檔案的路徑

1. Program.cs AddSwaggerGen() 調整為

    ```cs
    builder.Services.AddSwaggerGen(c =>
                                {
                                    // 上述的 xml 檔案絕整路徑
                                    var xmlPath = Path.Combine(AppContext.BaseDirectory, "上述的 xml 檔案名稱，不用路徑");
                                    c.IncludeXmlComments(xmlPath);
                                });
    ```

這樣就可以了 !