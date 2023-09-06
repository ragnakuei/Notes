# 搭配 xslt 產生 html

- 可以視為 Razor 組合 html 的更早一個版本
- xsl syntax 可以參考 [W3Schools XSLT](https://www.w3schools.com/xml/xsl_intro.asp)

## 範例：WebForm

Default.aspx.cs


```cs
using System;
using System.Linq;
using System.Web;
using System.Xml.Xsl;
using System.Xml;
using System.IO;

namespace WebFormAjaxXml
{
    public partial class AjaxHtml : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                var userList = new[]
                               {
                                   // 建立 UserDto List， No 從 1 開始，Name 從 A 開始，Created 跟 Updated 都遞增一日一小時一分鐘，共五人
                                   new UserDto { No = "1", Name = "A", Created = new DateTime(2015, 1, 1, 1, 1, 1), Updated = new DateTime(2015, 1, 1, 1, 1, 1) },
                                   new UserDto { No = "2", Name = "B", Created = new DateTime(2015, 1, 2, 2, 2, 2), Updated = new DateTime(2015, 1, 2, 2, 2, 2) },
                                   new UserDto { No = "3", Name = "C", Created = new DateTime(2015, 1, 3, 3, 3, 3), Updated = new DateTime(2015, 1, 3, 3, 3, 3) },
                                   new UserDto { No = "4", Name = "D", Created = new DateTime(2015, 1, 4, 4, 4, 4), Updated = new DateTime(2015, 1, 4, 4, 4, 4) },
                                   new UserDto { No = "5", Name = "E", Created = new DateTime(2015, 1, 5, 5, 5, 5), Updated = new DateTime(2015, 1, 5, 5, 5, 5) },
                               };

                var xmlDocument = new XmlDocument();

                var dataHtml = string.Join("", userList.Select(x => $@"
<data>
    <No>{ x.No }</No>
    <Name>{ x.Name }</Name>
    <Created>{ x.Created :yyyy/MM/dd HH:mm:ss}</Created>
    <Updated>{ x.Updated :yyyy/MM/dd HH:mm:ss}</Updated>
</data>"));

                xmlDocument.LoadXml("<root>" + dataHtml + "</root>");
                var userListParameter = xmlDocument.CreateNavigator()?.Select("*/data");

                var xsltArgumentList = new XsltArgumentList();
                xsltArgumentList.AddParam("Today",    "", DateTime.Now.ToString("yyyy/MM/dd"));
                xsltArgumentList.AddParam("UserList", "", userListParameter);
                XslCompiledTransform xslDoc = GetXslTransform(Server.MapPath("UserList.xslt"));

                // 直接回傳 html ，但會有 xss 風險
                //xslDoc.Transform(new XmlDocument(), xArgs, Response.Output);

                // 取出 html 字串，並進行 html encode  
                using (var stringWriter = new StringWriter())
                {
                    xslDoc.Transform(new XmlDocument(), xsltArgumentList, stringWriter);
                    var result = HttpUtility.HtmlEncode(stringWriter.ToString());
                    Response.Write(result);
                }
            }
            catch (Exception ex)
            {
                throw;
            }
        }

        private static XslCompiledTransform GetXslTransform(string filename)
        {
            var xslCompiledTransform = new XslCompiledTransform();

            XmlReaderSettings xmlReaderSettings = new XmlReaderSettings();

            // Obsolete
            // xmlReaderSettings.ProhibitDtd = false;
            xmlReaderSettings.DtdProcessing = DtdProcessing.Ignore;

            XmlReader xmlReader    = XmlReader.Create(filename, xmlReaderSettings);
            var       xsltSettings = new XsltSettings(true, true);

            xslCompiledTransform.Load(xmlReader, xsltSettings, new XmlUrlResolver());
            xmlReader.Close();
            return xslCompiledTransform;
        }
    }

    public class UserDto
    {
        public string   No      { get; set; }
        public string   Name    { get; set; }
        public DateTime Created { get; set; }
        public DateTime Updated { get; set; }
    }
}
```

UserList.xslt


```xml
<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE stylesheet[
        <!ENTITY nbsp "&#160;">
        <!ENTITY times "&#215;">
        <!ENTITY copy "&#169;">
        <!ENTITY bull "&#8226;">
        ]>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <!-- <xsl:import href="../xslt/footer.xslt" /> -->
    <xsl:output method="html"
                doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
                doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"
                indent="yes"/>
    <xsl:param name="UserList"/>

    <xsl:template match="/">
        <table id="tablelist" class="table table-striped table-hover">
            <thead>
                <tr>
                    <th>工號</th>
                    <th>姓名</th>
                    <th>建立時間</th>
                    <th>更新時間</th>
                    <th>功能列</th>
                </tr>
            </thead>
            <tbody>
                <xsl:for-each select="$UserList">
                    <tr id="tr_{No}" nowrap="">
                        <td id="td_empno_{No}">
                            <xsl:value-of select="No" disable-output-escaping="yes"/>
                        </td>
                        <td id="td_edit_cname{No}">
                            <xsl:value-of select="Name" disable-output-escaping="yes"/>
                        </td>
                        <td id="td_usedate_{No}">
                            <xsl:value-of select="Created" disable-output-escaping="yes"/>
                        </td>
                        <td>
                            <xsl:value-of select="Updated" disable-output-escaping="yes"/>
                        </td>
                        <td>
                            <button type="button" 
                                    class="btn btn-sm btn-primary" 
                                    data-toggle="modal" title="編輯" 
                                    onclick="EditUserShow('{No}')"
                                    data-target="#edituserright">
                                編輯
                            </button>
                            <button type="button" 
                                    class="btn btn-sm btn-danger" 
                                    data-toggle="modal" 
                                    title="刪除" 
                                    onclick="deleteManagerUser('{No}')">
                                刪除
                            </button>
                        </td>
                    </tr>
                </xsl:for-each>
            </tbody>
        </table>
    </xsl:template>
</xsl:stylesheet>
```