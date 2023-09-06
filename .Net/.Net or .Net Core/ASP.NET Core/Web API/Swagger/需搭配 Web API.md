# 需搭配 Web API

```cs
builder.Services.AddControllers();
```

一定要加上這行，不然會有下列錯誤，而且 swagger.json 裡面的 paths 跟 components 會是空的

```txt
No operations defined in spec!
```