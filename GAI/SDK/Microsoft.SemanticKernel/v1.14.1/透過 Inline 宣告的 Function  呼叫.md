# 透過 Inline 宣告的 Function 呼叫

```cs
/// <summary>
/// 透過 OpenAI API
/// inline 宣告 Function，不會透過 Plugin 匯入
/// </summary>
public class Function01
{
    public async Task RunAsync()
    {
        var builder = Kernel.CreateBuilder()
                            .AddOpenAIChatCompletion("gpt-4o", "api-key");

        var kernel = builder.Build();

        var promptTemplate = @"你現在是數學計算機，請計算
###
{{$userInput}}
###
的結果。
回答的內容只需要答案，不需要其他贅字。
";

        var function = kernel.CreateFunctionFromPrompt(promptTemplate,
                                                       executionSettings: new OpenAIPromptExecutionSettings
                                                                          {
                                                                              // ModelId              = null,
                                                                              // ExtensionData        = null,
                                                                              // Temperature          = 0,
                                                                              // TopP                 = 0,
                                                                              // PresencePenalty      = 0,
                                                                              // FrequencyPenalty     = 0,
                                                                              MaxTokens = 1000,

                                                                              // StopSequences        = null,
                                                                              // ResultsPerPrompt     = 0,
                                                                              // Seed                 = null,
                                                                              // ChatSystemPrompt     = null,
                                                                              // TokenSelectionBiases = null,
                                                                              // ToolCallBehavior     = null,
                                                                              // User                 = null
                                                                          });

        Console.WriteLine("請輸入一個數學計算式：");
        var question = Console.ReadLine();

        // 指定要使用的 Function 名稱
        var result = await kernel.InvokeAsync(function,
                                              new()
                                              {
                                                  // 在 prompt template 中，必須以 {{$xxx}} 的格式來指定參數名稱
                                                  ["userInput"] = question
                                              });

        Console.WriteLine($"答案：{result}");
    }
}
```
