# 透過 OpenAI API 呼叫

```cs
var builder = Kernel.CreateBuilder()
                    .AddOpenAIChatCompletion("gpt-4o", "api-key");

var kernel = builder.Build();
``