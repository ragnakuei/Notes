# 透過 Plugin > Function 呼叫

config.json 跟 skprompt.txt，要放在 指定的 Funtion 資料夾中

```cs
/// <summary>
/// 從檔案系統中的 Plugin 資料夾中，匯入 Function
/// 給定 Plugin 資料夾，該資料夾內為 Function 資料夾
/// 每個 Function 資料夾固定有二個檔案：config.json 與 skprompt.txt，不可更動
/// </summary>
public class PluginSample01
{
    public async Task RunAsync()
    {
        var builder = Kernel.CreateBuilder()
                            .AddOpenAIChatCompletion("gpt-4o", "api-key");

        var kernel = builder.Build();

        // 指定 MathPlugin 資料夾
        var pluginDirectoryPath = Path.Combine(Directory.GetCurrentDirectory(),
                                               "Plugins",
                                               "MathPlugin");

        // Import 該 Plugin 資料夾下的 Functions
        var pluginFunctions = kernel.ImportPluginFromPromptDirectory(pluginDirectoryPath);

        Console.WriteLine("請輸入一個數學計算式：");
        var question = Console.ReadLine();

        // 指定要使用的 Function 名稱
        var result = await kernel.InvokeAsync(pluginFunctions["Calculator"],
                                              new()
                                              {
                                                  // 在 prompt template 中，必須以 {{$xxx}} 的格式來指定參數名稱
                                                  ["userInput"] = question
                                              });

        Console.WriteLine($"答案：{result}");
    }
}
```

config.json

```json
{
    "schema": 1,
    "description": "Math Calculator",
    "execution_settings": {
        "default": {
            "max_tokens": 1000,
            "temperature": 0.9,
            "top_p": 0.0,
            "presence_penalty": 0.6,
            "frequency_penalty": 0.0,
            "stop_sequences": ["Human:", "AI:"]
        }
    }
}
```

skprompt.txt

```txt
你現在是數學計算機，請計算
###
{{$userInput}}
###
的結果。
回答的內容只需要答案，不需要其他贅字。
```
