# [PagerTemplate](https://docs.microsoft.com/zh-tw/dotnet/api/system.web.ui.webcontrols.gridview.pagertemplate)

在 GridView 內的 自動產生 (AllowPaging="True") 的分頁功能

> 注意：如果 GridView 的資料筆數沒有超過 PageSize 的話，自動分頁功能就不會出現

實際長出來的 html 會在原本的資料列內，再多一列，裡面以 table 的方式呈現分頁列

```html
<tr>
  <td colspan="7">
    <table>
      <tbody>
        <tr>
          <td>
            <a
              href="javascript:__doPostBack('ctl00$MainContent$orderList','Page$1')"
              >1</a
            >
          </td>
          <td>
            <a
              href="javascript:__doPostBack('ctl00$MainContent$orderList','Page$2')"
              >2</a
            >
          </td>
          <td>
            <a
              href="javascript:__doPostBack('ctl00$MainContent$orderList','Page$3')"
              >3</a
            >
          </td>
          <td><span>4</span></td>
          <td>
            <a
              href="javascript:__doPostBack('ctl00$MainContent$orderList','Page$5')"
              >5</a
            >
          </td>
          <td>
            <a
              href="javascript:__doPostBack('ctl00$MainContent$orderList','Page$6')"
              >6</a
            >
          </td>
          <td>
            <a
              href="javascript:__doPostBack('ctl00$MainContent$orderList','Page$7')"
              >7</a
            >
          </td>
          <td>
            <a
              href="javascript:__doPostBack('ctl00$MainContent$orderList','Page$8')"
              >8</a
            >
          </td>
          <td>
            <a
              href="javascript:__doPostBack('ctl00$MainContent$orderList','Page$9')"
              >9</a
            >
          </td>
          <td>
            <a
              href="javascript:__doPostBack('ctl00$MainContent$orderList','Page$10')"
              >10</a
            >
          </td>
          <td>
            <a
              href="javascript:__doPostBack('ctl00$MainContent$orderList','Page$11')"
              >...</a
            >
          </td>
        </tr>
      </tbody>
    </table>
  </td>
</tr>
```
