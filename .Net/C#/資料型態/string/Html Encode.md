# Html Encode

```cs
void Main()
{
	var str = "一二三";
	
	var encodedString = str.HtmlEncode();
	
	encodedString.Dump();

	encodedString.HtmlDecode().Dump();	
}

public static class Utf8Helper
{
	public static string HtmlEncode(this string s)
	{
        // System.Web.HttpUtility.HtmlEncode() 達不到想要的效果，經 google 後，下方的語法可以達成 !

		return s.Select(c => "&#" + (int)c + ";").Join("");
	}

	public static string HtmlDecode(this string s)
	{
		return System.Web.HttpUtility.HtmlDecode(s);

        // 與下面效果相同
		return s.Split(";").Where(c => string.IsNullOrWhiteSpace(c) == false)
		        .Select(c => {
                    code = c.TrimStart("&#");
                    var intCode = Convert.ToInt32(code);
                    return char.ConvertFromUtf32(intCode);
		        })
		        .Join("");
	}
}
```
