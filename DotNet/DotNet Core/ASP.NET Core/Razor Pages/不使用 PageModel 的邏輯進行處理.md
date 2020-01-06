# 不使用 PageModel 的邏輯進行處理

- 只需要 .cshtml 檔
- 不需要 .cshtml.cs 檔
- 不需要指定 @model
- @functions block 內，視為 csharp 語法

```html
@page
@{
    @functions{
        public string Message { get; set; } = "Initial Request";
    }
}

<h3 class="clearfix">@Message</h3>
```
