# Pager 範例

## 範例一

組件：

```html
<!-- Template
<nav aria-label="Page navigation example">
    <ul class="pagination">
    
        <li class="page-item"><a class="page-link" href="javascript:void(0)">1</a></li>
        
    </ul>
</nav>
-->

<script>
    class Pager {
        constructor(domId, itemCount = 0, pageSize = 10, pageOffSet = 3) {
            this.DomId = domId;
            this.PageSize = pageSize;
            this.PageNo = 1;
            this.PageOffSet = pageOffSet;
            this.ItemCount = itemCount;
        }
      
        ItemCount = null;
        
        get ['PageCount']() {
            return Math.ceil(this.ItemCount / this.PageSize);
        }; 
        
        OnChangePageNo = null;
        
        GetPageDtos = (array, pageNo) => {
            return array.slice((pageNo - 1) * this.PageSize, pageNo * this.PageSize);
        }
        
        ToPage = (pageNo) => {
            this.PageNo = pageNo;
            this.Render();
            
            if (this.OnChangePageNo) {
                this.OnChangePageNo(pageNo, this);
            }
        }
        
        Render = () => {
            const nav = document.createElement("nav");
            nav.setAttribute("aria-label", "Page navigation example");
            
            const ul = document.createElement("ul");
            ul.className = "pagination";
            ul.innerHTML = "";
            
            if(this.PageNo > 1) {
                const firstPageSpan = this.CreatePageItem('<<', 1, false);
                ul.appendChild(firstPageSpan);
                
                const prevPageSpan = this.CreatePageItem('<', Math.max(1, this.PageNo - 1), false);
                ul.appendChild(prevPageSpan);
            }
            
            const firstPageNo = Math.max(1, this.PageNo - this.PageOffSet);
            const lastPageNo = Math.min(this.PageNo + this.PageOffSet, this.PageCount);
            for (let i = firstPageNo; i <= lastPageNo; i++) {
                const pageSpan = this.CreatePageItem(i, i);
                ul.appendChild(pageSpan);
            }
            
            if(this.PageNo < this.PageCount) {
                const nextPageSpan = this.CreatePageItem('>', Math.min(this.PageCount, this.PageNo + 1), false);
                ul.appendChild(nextPageSpan);
                
                const lastPageSpan = this.CreatePageItem('>>', this.PageCount, false);
                ul.appendChild(lastPageSpan);
            }
            
            nav.appendChild(ul);
            
            const pager = document.getElementById(this.DomId);
            pager.innerHTML = "";
            pager.appendChild(nav);
        }
        
        CreatePageItem = (text, pageNo, isShowActive = true) => {
            const pageItem = document.createElement("li");
            pageItem.className = "page-item";
            
            if(this.PageNo === pageNo && isShowActive) {
                pageItem.className += " active";
            }
            
            const pageLink = document.createElement("a");
            pageLink.className = "page-link";
            pageLink.href = "javascript:void(0);";
            pageLink.innerText = text;
            pageLink.onclick = () => {
                this.ToPage(pageNo);
            }
            
            pageItem.appendChild(pageLink);
            return pageItem;
        }
    }
</script>
```

使用：

```html
<h2>Book List</h2>

<table class="table" >
    <thead>
        <tr>
            <th>Id</th>
            <th>Title</th>
            <th>Author</th>
            <th>Price</th>
        </tr>
    </thead>
    <tbody id="tbody" >
        @* <tr> *@
        @*     <td>item.Id</td> *@
        @*     <td>item.Title</td> *@
        @*     <td>item.Author</td> *@
        @*     <td>item.Price</td> *@
        @* </tr> *@
    </tbody>
</table>

<div id="pager"></div>
@Html.Partial("_Pager")

<script>
    const books = @Html.Raw(( ViewBag.Books as Book[] ).ToJson()) 
    window.onload = function() {
        
        const pager = new Pager("pager");
        pager.OnChangePageNo = (pageNo, instance) => {
                                    const pageDtos = instance.GetPageDtos(books, pageNo);
                                    const tbody = document.getElementById("tbody");
                                    tbody.innerHTML = "";
                                    pageDtos.forEach(book => {
                                        const tr = document.createElement("tr");
                                        
                                        const idTd = document.createElement("td");
                                        idTd.innerText = book.Id;
                                        tr.appendChild(idTd);
                                        
                                        const titleTd = document.createElement("td");
                                        titleTd.innerText = book.Title;
                                        tr.appendChild(titleTd);
                                        
                                        const authorTd = document.createElement("td");
                                        authorTd.innerText = book.Author;
                                        tr.appendChild(authorTd);
                                        
                                        const priceTd = document.createElement("td");
                                        priceTd.innerText = book.Price;
                                        tr.appendChild(priceTd);
                                        
                                        tbody.appendChild(tr);
                                    });
                                };
        pager.ItemCount = books.length;
        pager.ToPage(1);
    }
</script>

```