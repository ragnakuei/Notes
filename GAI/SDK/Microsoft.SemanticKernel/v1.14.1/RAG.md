# RAG

```cs
using System.Diagnostics.CodeAnalysis;
using System.Text;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Microsoft.KernelMemory;
using Microsoft.SemanticKernel;
using Microsoft.SemanticKernel.Connectors.OpenAI;
using Microsoft.SemanticKernel.Embeddings;
using Microsoft.SemanticKernel.Memory;
using Microsoft.SemanticKernel.Plugins.Memory;
using MiniExcelLibs;
using SemanticKernelPractice.Models;

namespace SemanticKernelPractice.Practice;

/// <summary>
/// 碳足跡 QA.xls
/// </summary>
public class CfpQA
{
    private readonly IOptionsMonitor<OpenAiConfigDTO> _openAiConfig;
    private readonly LogLevel                         _logLevel = LogLevel.Error;

    public CfpQA(IOptionsMonitor<OpenAiConfigDTO> openAiConfig)
    {
        _openAiConfig = openAiConfig;
    }

    /// <summary>
    /// 透過 KernelMemory 來找出最相關的答案
    /// </summary>
    [Experimental("SKEXP")]
    public async Task RagWithKernelMemoryAsync(CancellationToken cancellationToken)
    {
        var openAiConfig = _openAiConfig.CurrentValue;

        var kernelBuilder = Kernel.CreateBuilder()
                                  .AddOpenAIChatCompletion(openAiConfig.TextModel, openAiConfig.ApiKey)
                                  .AddOpenAITextEmbeddingGeneration(openAiConfig.EmbeddingModel, openAiConfig.ApiKey);

        kernelBuilder.Services.AddLogging(c => c.AddConsole().SetMinimumLevel(_logLevel));

        var kernel = kernelBuilder.Build();

        var kernelMemoryBuilder = new KernelMemoryBuilder().WithOpenAITextEmbeddingGeneration(new OpenAIConfig
                                                                                              {
                                                                                                  EmbeddingModel = openAiConfig.EmbeddingModel,
                                                                                                  APIKey         = openAiConfig.ApiKey,
                                                                                              })
                                                           .WithOpenAITextGeneration(new OpenAIConfig
                                                                                     {
                                                                                         TextModel = openAiConfig.TextModel,
                                                                                         APIKey    = openAiConfig.ApiKey,
                                                                                     });

        kernelMemoryBuilder.Services.AddLogging(c => c.AddConsole().SetMinimumLevel(_logLevel));

        var kernelMemory = kernelMemoryBuilder.Build();

        // MemoryPlugin 要裝 Nuget 套件 Microsoft.KernelMemory.SemanticKernelPlugin
        kernel.ImportPluginFromObject(new MemoryPlugin(kernelMemory), "memory");

        var referenceItems = ReadFromExcel();

        foreach (var item in referenceItems)
        {
            var rowContent = $"類別：{item.Category}\n問：{item.Q}\n答：{item.A}";

            await kernelMemory.ImportTextAsync(rowContent, cancellationToken: cancellationToken);
        }

        var arguments = new KernelArguments();

        // {{memory.ask $userInput}} 這個指令會將 $userInput 的問題，透過 memory plugin 找出最相關的答案，進行替換 
        var skPrompt = @"你現在是碳足跡(CFP)問答機器人，並遵循以下規則：
###
1. 只回答與碳足跡相關的問題。
2. 需附上參考資料的完整內容，不得做刪減。
###

參考資料：
###
{{memory.ask $userInput}}
###

請回答使用者的問題:
###
{{$userInput}}
###";

        var chatFunction = kernel.CreateFunctionFromPrompt(skPrompt,
                                                           new OpenAIPromptExecutionSettings
                                                           {
                                                               MaxTokens   = 2000,
                                                               Temperature = 0.8
                                                           });

        var userInput = string.Empty;

        do
        {
            Console.Write("請輸入問題：");
            userInput = Console.ReadLine()!;

            if (string.IsNullOrWhiteSpace(userInput)) break;

            arguments["userInput"] = userInput;

            var invokeResult = kernel.InvokeStreamingAsync(chatFunction, arguments, cancellationToken: cancellationToken);
            await foreach (var result in invokeResult)
            {
                Console.Write(result);
            }

            Console.WriteLine();
        } while (true);
    }

    /// <summary>
    /// 手動將與問題最相關的 Embeddings 找出來
    /// </summary>
    /// <param name="cancellationToken"></param>
    [Experimental("SKEXP")]
    public async Task RagWithManualMemory(CancellationToken cancellationToken)
    {
        #region OpenAI API

        var openAiConfig = _openAiConfig.CurrentValue;

        var kernelBuilder = Kernel.CreateBuilder()
                                  .AddOpenAIChatCompletion(openAiConfig.TextModel, openAiConfig.ApiKey)
                                  .AddOpenAITextEmbeddingGeneration(openAiConfig.EmbeddingModel, openAiConfig.ApiKey);

        kernelBuilder.Services.AddLogging(c => c.AddConsole().SetMinimumLevel(_logLevel));

        var kernel = kernelBuilder.Build();

        var memory = new MemoryBuilder().WithMemoryStore(new VolatileMemoryStore())

                                         // 當 Kernel 有 AddOpenAITextEmbeddingGeneration 時，就可以透過這個方法取得 ITextEmbeddingGenerationService
                                        .WithTextEmbeddingGeneration(kernel.GetRequiredService<ITextEmbeddingGenerationService>())
                                        .WithLoggerFactory(kernel.LoggerFactory)
                                        .Build();

        #endregion

        var referenceItems = ReadFromExcel();
        var collectionName = "碳足跡QA";

        foreach (var item in referenceItems)
        {
            // 如需針的回應的內容做控制，可以在這邊做處理

            var rowContent = $"類別：{item.Category}\n問：{item.Q}\n答：{item.A}";
            await memory.SaveInformationAsync(collectionName, rowContent, item.Id.ToString(), cancellationToken: cancellationToken);
        }

        // 這一行似乎沒有用到
        kernel.ImportPluginFromObject(new TextMemoryPlugin(memory));

        var memoryRelevanceLimit = 5;

        var arguments = new KernelArguments();
        arguments[TextMemoryPlugin.CollectionParam] = collectionName;
        arguments[TextMemoryPlugin.LimitParam]      = memoryRelevanceLimit.ToString();
        arguments[TextMemoryPlugin.RelevanceParam]  = "0.8";

        var skPrompt = @"你現在是碳足跡問答機器人，只回答與碳足跡相關的問題。
使用者提問內容如下：
###
{{$userInput}}
###

參考資料的回應如下：
###
{{$references}}
###

請依照上述資訊回答使用者的問題。";

        var chatFunction = kernel.CreateFunctionFromPrompt(skPrompt,
                                                           new OpenAIPromptExecutionSettings
                                                           {
                                                               MaxTokens   = 2000,
                                                               Temperature = 0.8
                                                           });

        var userInput = string.Empty;

        do
        {
            Console.Write("請輸入問題：");
            userInput = Console.ReadLine()!;

            if (string.IsNullOrWhiteSpace(userInput)) break;

            arguments["userInput"] = userInput;

            var ask = $"{userInput}";
            var memories = memory.SearchAsync(collectionName,
                                              ask,
                                              limit: memoryRelevanceLimit,
                                              minRelevanceScore: 0.7,
                                              cancellationToken: cancellationToken);

            var references = new StringBuilder();
            await foreach (var mem in memories)
            {
                references.AppendLine($" Relevance:{mem.Relevance} Text:{mem.Metadata.Text} ");
            }

            arguments["references"] = references.ToString();

            await foreach (var result in chatFunction.InvokeStreamingAsync(kernel, arguments, cancellationToken: cancellationToken))
            {
                Console.Write(result);
            }

            Console.WriteLine();
        } while (true);
    }

    /// <summary>
    /// Embeddings 找出最相關的答案
    /// </summary>
    [Experimental("SKEXP")]
    public async Task EmbeddingsSearchMemoryAsync(CancellationToken cancellationToken)
    {
        #region OpenAI API

        var openAiConfig = _openAiConfig.CurrentValue;

        var kernelBuilder = Kernel.CreateBuilder()
                                  .AddOpenAIChatCompletion(openAiConfig.TextModel, openAiConfig.ApiKey)
                                  .AddOpenAITextEmbeddingGeneration(openAiConfig.EmbeddingModel, openAiConfig.ApiKey);

        kernelBuilder.Services.AddLogging(c => c.AddConsole().SetMinimumLevel(_logLevel));

        var kernel = kernelBuilder.Build();

        var memory = new MemoryBuilder().WithMemoryStore(new VolatileMemoryStore())
                                        .WithTextEmbeddingGeneration(kernel.GetRequiredService<ITextEmbeddingGenerationService>())
                                        .WithLoggerFactory(kernel.LoggerFactory)
                                        .Build();

        #endregion

        var referenceItems = ReadFromExcel();
        var collectionName = "碳足跡QA";

        foreach (var item in referenceItems)
        {
            var rowContent = $"類別：{item.Category}\n問：{item.Q}\n答：{item.A}";
            await memory.SaveInformationAsync(collectionName, rowContent, item.Id.ToString(), cancellationToken: cancellationToken);
        }

        var userInput = string.Empty;
        do
        {
            Console.Write("請輸入問題：");
            userInput = Console.ReadLine()!;

            if (string.IsNullOrWhiteSpace(userInput)) break;

            var ask = $"問：{userInput}";
            var memories = memory.SearchAsync(collectionName,
                                              ask,
                                              limit: 5,
                                              minRelevanceScore: 0.7,
                                              cancellationToken: cancellationToken);

            var i = 0;
            await foreach (var mem in memories)
            {
                Console.WriteLine($"Result {++i}:");
                Console.WriteLine("  Id: " + mem.Metadata.Id);

                // Console.WriteLine("  Description: " + mem.Metadata.Description);
                Console.WriteLine("  Relevance: "   + mem.Relevance);
                Console.WriteLine("  IsReference: " + mem.Metadata.IsReference);
                Console.WriteLine("  Text: "        + mem.Metadata.Text);
                Console.WriteLine();
            }
        } while (true);
    }

    private List<CfpQaDTO> ReadFromExcel()
    {
        var       path   = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "References", "碳足跡QA.xlsx");
        using var stream = File.OpenRead(path);
        var items = stream.Query(excelType: ExcelType.XLSX)
                          .Select((row, index) => new CfpQaDTO
                                                  {
                                                      // +2 是因為第 index 是 base 0，再加上 標題列
                                                      Id       = index + 2,
                                                      Q        = row.A,
                                                      A        = row.B,
                                                      Category = row.C,
                                                  })

                           // Skip header
                          .Skip(1)
                          .ToList();

        return items;
    }
}
```