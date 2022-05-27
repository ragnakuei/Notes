# 顯示頁面的最前方加上 js script


```cs
if(string.IsNullOrWhiteSpace(AccountInfo.Accid))
{
    var jsScript = string.Format(@"
alert('{0}');
location.href='login.aspx';", 
                                    "請先登入");
    ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "enable", jsScript, true);
    return;
}
```