# 套用 html attributes 技巧

## Tip 1

如果要輸出帶 減號 的 html attribute
必須在 new { } 裡面給定 底線，輸出後會自動轉成 減號
如果 html attribute 沒有效果，請參考 Tip 4 的寫法

```csharp
@Html.TextBox("Test","Test Value",new { data_item_id = "123" })
```

```html
<input data-item-id="123" id="Test" name="Test" type="text" value="Test Value" />
```

## Tip 2

如果要輸出帶 class 的 html attribute
必須在new { } 裡面給定 @，輸出後會自動將@刪除

```csharp
@Html.TextBox("Test","Test Value",new { @class = "class1" })
```

```html
<input class="123" id="Test" name="Test" type="text" value="Test Value" />
```

### Tip 3

name無法指定 (所以不用指定)

```csharp
@Html.TextBox("Test", "TestValue", new { id = 1, name = 2 });
```

```html
<input id="1" name="Test" type="text" value="TestValue" />
```

## Tip 4

輸出為disabled
html可接受disabled或是disabled="disabled"，這二種寫法

```csharp
@Html.EditorFor(model => model.VdrNo
                       , new { htmlAttributes = new { @class = "form-control", @disabled = "disabled" } }
)
```

```html
<input class="form-control text-box single-line" disabled="disabled" id="VdrNo" name="VdrNo" type="text" value="" />
```

Tip5 ：
設定初始值的方式參考：EditorFor