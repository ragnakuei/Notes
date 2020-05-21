# 自訂：CheckListBox

CheckBoxList( List<CheckBoxInfo> , n )
- List<CheckBoxInfo> ：CheckBoxInfo 的 List 集合，必填
- n ：要以幾個 columns來顯示，不指定為1

新增一個類別來存放要放進列表的所有CheckBox

### Model

CheckBoxInfo.cs

```csharp
namespace ef_01.Models
{
    public class CheckBoxInfo
    {
        public string IdName { get; set; }
        public bool IsChecked { get; set; }
    }
}
```

### CustomHtmlHelper

~/Helpers/CustomHtmlHelper.cs

```csharp
using ef_01.Models;
using System;
using System.Collections.Generic;
using System.Text;
using System.Web.Mvc;

namespace ef_01.Helpers
{
    public static class CustomHtmlHelpers
    {
        public static MvcHtmlString CheckBoxList(this HtmlHelper helper, List<CheckBoxInfo> item_list, int col_count = 1)
        {
            int row_count = (item_list.Count / col_count) + 1;
            int nth = 0;
            StringBuilder sb = new StringBuilder();

            sb.Append("<table class=\"table\">");
            sb.Append(Environment.NewLine);
            for (int j = 1; j <= row_count; j++)
            {
                sb.Append("<tr>");
                sb.Append(Environment.NewLine);
                for (int i = 1; i <= col_count; i++)
                {
                    sb.Append("<td>");
                    if (nth < item_list.Count)
                    {
                        //增加<input type="checkbox"/>的部份
                        TagBuilder tb = new TagBuilder("input");
                        tb.MergeAttribute("type", "checkbox");
                        tb.MergeAttribute("id",item_list[nth].IdName);
                        tb.MergeAttribute("name", item_list[nth].IdName);
                        tb.MergeAttribute("value", item_list[nth].IsChecked.ToString());
                        if (item_list[nth].IsChecked == true) tb.MergeAttribute("checked", "checked");
                        sb.Append(tb.ToString(TagRenderMode.SelfClosing));
                        sb.Append(item_list[nth].IdName);

                        //增加<input type="hidden"/>的部份
                        TagBuilder tb_hidden = new TagBuilder("input");
                        tb_hidden.MergeAttribute("name", item_list[nth].IdName);
                        tb_hidden.MergeAttribute("type", "hidden");
                        tb_hidden.MergeAttribute("value", item_list[nth].IsChecked.ToString());
                        sb.Append(tb_hidden.ToString(TagRenderMode.SelfClosing));

                        nth = nth + 1;
                    }
                    sb.Append("</td >");
                    sb.Append(Environment.NewLine);
                }
                sb.Append("</tr>");
                sb.Append(Environment.NewLine);
            }
            sb.Append("</table>");
            sb.Append(Environment.NewLine);
            return MvcHtmlString.Create(sb.ToString());
        }
    }
}
```

### View	

如果此處找不到該函數，請確認@using是否已經引用以及該函數的第一個引數是否有輸入this HtmlHelper helper

```csharp
@using ef_01.Helpers	
@using ef_01.Models
@{
    ViewBag.Title = "List";
}

<h2>List</h2>

@{
    List<CheckBoxInfo> item_list = new List<CheckBoxInfo>(){
        new CheckBoxInfo { IdName = "a", IsChecked = true }
        , new CheckBoxInfo { IdName = "b", IsChecked = false }
        , new CheckBoxInfo { IdName = "c", IsChecked = false }
        , new CheckBoxInfo { IdName = "d", IsChecked = true }
        , new CheckBoxInfo { IdName = "e", IsChecked = true }
        , new CheckBoxInfo { IdName = "f", IsChecked = false }
        , new CheckBoxInfo { IdName = "g", IsChecked = true }
        , new CheckBoxInfo { IdName = "h", IsChecked = false }
        , new CheckBoxInfo { IdName = "i", IsChecked = true }
        , new CheckBoxInfo { IdName = "j", IsChecked = false }
    };
}

@Html.CheckBoxList(item_list, 4)
```

### 原始碼結果

```csharp
<table class="table">
<tr>
        <td><input checked="checked" id="a" name="a" type="checkbox" value="True" />a<input name="a" type="hidden" value="True" /></td >
        <td><input id="b" name="b" type="checkbox" value="False" />b<input name="b" type="hidden" value="False" /></td >
        <td><input id="c" name="c" type="checkbox" value="False" />c<input name="c" type="hidden" value="False" /></td >
        <td><input checked="checked" id="d" name="d" type="checkbox" value="True" />d<input name="d" type="hidden" value="True" /></td >
</tr>
<tr>
        <td><input checked="checked" id="e" name="e" type="checkbox" value="True" />e<input name="e" type="hidden" value="True" /></td >
        <td><input id="f" name="f" type="checkbox" value="False" />f<input name="f" type="hidden" value="False" /></td >
        <td><input checked="checked" id="g" name="g" type="checkbox" value="True" />g<input name="g" type="hidden" value="True" /></td >
        <td><input id="h" name="h" type="checkbox" value="False" />h<input name="h" type="hidden" value="False" /></td >
</tr>
<tr>
        <td><input checked="checked" id="i" name="i" type="checkbox" value="True" />i<input name="i" type="hidden" value="True" /></td >
        <td><input id="j" name="j" type="checkbox" value="False" />j<input name="j" type="hidden" value="False" /></td >
        <td></td >
        <td></td >
</tr>
</table>
```
