# [Paginator](https://material.angular.io/components/table/overview)

> import { MatPaginatorModule } from '@angular/material/paginator';

> 注意： pageIndex 是 base 0。後端可直接接 0， skip count 就可以不用減 1 再剩 pageSize 了

---

## 一個頁面有二個 Pagination

```typescript
@ViewChild("paginatorTop", { static: true })
private paginatorTop: MatPaginator;

@ViewChild("paginatorBottom", { static: true })
private paginatorBottom: MatPaginator;

public ngOnInit(): void {
    this.getOrderList(0, 10);

    this.paginatorTop.page.subscribe((page: PageEvent) => {
        this.getOrderList(page.pageIndex, page.pageSize);
    });

    this.paginatorBottom.page.subscribe((page: PageEvent) => {
        this.getOrderList(page.pageIndex, page.pageSize);
    });
}

private getOrderList(pageIndex: number, pageSize: number) {
    this.orderService.getList(pageIndex, pageSize).subscribe(
        resp => {
            this.orderListDataSource.data = resp.Items;
            this.totalCount = resp.TotalCount;

            this.paginatorTop.pageIndex = pageIndex;
            this.paginatorTop.pageSize = pageSize;
            this.paginatorBottom.pageIndex = pageIndex;
            this.paginatorBottom.pageSize = pageSize;
        },
        err => console.log("Error", err)
    );
}
```

```html
<mat-paginator
  #paginatorTop
  [length]="totalCount"
  [pageIndex]="0"
  [pageSize]="10"
  [pageSizeOptions]="[5, 10, 15]"
></mat-paginator>

<table mat-table [dataSource]="orderListDataSource"></table>

<mat-paginator
  #paginatorBottom
  [length]="totalCount"
  [pageIndex]="0"
  [pageSize]="10"
  [pageSizeOptions]="[5, 10, 15]"
></mat-paginator>
```
