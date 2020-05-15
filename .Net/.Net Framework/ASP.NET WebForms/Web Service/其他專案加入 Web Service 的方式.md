# 其他專案加入 Web Service 的方式

---

---

## 新增 WebService

新增 WebForm 專案

![txt](./_images/其他專案加入%20Web%20Service%20的方式/01.png)

在專案內新增項目:Web 服務 (ASMX)

![txt](./_images/其他專案加入%20Web%20Service%20的方式/02.png)

替換以下 `[WebMethod]` 程式碼

```csharp
/// <summary>
///WebService1 的摘要描述
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
[System.ComponentModel.ToolboxItem(false)]
// 若要允許使用 ASP.NET AJAX 從指令碼呼叫此 Web 服務，請取消註解下列一行。
// [System.Web.Script.Services.ScriptService]
public class WebService1 : System.Web.Services.WebService
{

    [WebMethod]
    public string HelloWorld()
    {
        return "Hello World";
    }

    [WebMethod]
    public double Add(double n1, double n2)
    {
        return n1 + n2;
    }
    [WebMethod]
    public double Subtract(double n1, double n2)
    {
        return n1 - n2;
    }
    [WebMethod]
    public double Multiply(double n1, double n2)
    {
        return n1 * n2;
    }
    [WebMethod]
    public double Divide(double n1, double n2)
    {
        return n1 / n2;
    }
}
```

ctrl + f5 執行

開啟 web service 所在的 url
http://{{host}}/WebService1.asmx

該頁面上列出所提供的 api 項目

![txt](./_images/其他專案加入%20Web%20Service%20的方式/03.png)

可以實際執行看看

![txt](./_images/其他專案加入%20Web%20Service%20的方式/04.png)

執行後的結果以 XML 顯示

![txt](./_images/其他專案加入%20Web%20Service%20的方式/05.png)

## 與 WebForm 結合

開啟 Default.aspx 將 Label 加至 BodyContent 下方

![txt](./_images/其他專案加入%20Web%20Service%20的方式/06.png)

加入服務參考

![txt](./_images/其他專案加入%20Web%20Service%20的方式/07.png)

點擊進階

![txt](./_images/其他專案加入%20Web%20Service%20的方式/08.png)

點擊下方加入 Web 參考

![txt](./_images/其他專案加入%20Web%20Service%20的方式/09.png)

點擊 這個方案中的 Web 服務

![txt](./_images/其他專案加入%20Web%20Service%20的方式/10.png)

點擊所建立的服務

![txt](./_images/其他專案加入%20Web%20Service%20的方式/11.png)

設定 Web 參考名稱 (如有必要)

![txt](./_images/其他專案加入%20Web%20Service%20的方式/12.png)

點擊 加入參考

![txt](./_images/其他專案加入%20Web%20Service%20的方式/13.png)

在 Default.aspx.cs 中的 Page_Load() 的內容改為以下:

```csharp
protected void Page_Load(object sender, EventArgs e)
{
		var calc = new localhost.WebService1();
		var result = calc.Add(1, 2);
		Label1.Text = result.ToString();
}
```

ctrl + f5 執行
看到數字 3 就代表成功了

![txt](./_images/其他專案加入%20Web%20Service%20的方式/14.png)

如果是別的專案要使用該 url 的 web service 服務
那就在 URL 的地方輸入 web service url 後，按下 enter
也會出現對應的內容