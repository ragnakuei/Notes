# 透過 Ollama API 呼叫

此版本必須加上 #pragma 來避免警告

```cs
#pragma warning disable SKEXP0010
var builder = Kernel.CreateBuilder()
                    .AddOpenAIChatCompletion(modelId: "llama3:8b",
                                             apiKey: null,
                                             endpoint: new Uri("http://localhost:11434"));
#pragma warning restore SKEXP0010
```