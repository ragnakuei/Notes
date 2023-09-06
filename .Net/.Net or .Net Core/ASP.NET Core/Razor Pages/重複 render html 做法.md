# 重複 render html 做法


### 範例


```cs
@inject NavServices.INavService NavService

@{
   var  navDtos = NavService.GetNav();
}

<div>
    <div>
        <nav>
            <ul>
                
                @foreach (var navDto in navDtos)
                {
                    CreateNode(navDto);
                }
                <li><a title="Node01" href="/Node01">Node01</a></li>
                <li><a title="Node02" href="/Node02">Node02</a></li>
            </ul>
        </nav>
    </div>
</div>

@functions
{
    private void CreateNode(NavDto dto)
    {
        <li> 
            <a title="@(dto.Text)" href="@(TrimAspx(dto.Url))" class="sf-with-ul">@(dto.Text)</a>
            @if (dto.ChildNodes.Length > 0)
            {
                <ul> 
                    @foreach(var item in dto.ChildNodes)
                    {
                        CreateNode(item);
                    }   
                </ul>
            }
            
        </li> 
    }

    private string TrimAspx(string url)
    {
        return url.Replace(".aspx", "");
    }
}

```