# 直接透過 axios 從 api 取得資料

## 範例

service

```ts
import { Component, Vue } from 'vue-property-decorator';
import axios, { AxiosResponse } from "axios";
import { IProductDTO } from "@/dtos/IProductDTO";

@Component
export class ProductService extends Vue {

    public async GetProductList(): Promise<Array<IProductDTO>> {
        // 第一種寫法
        // try {
        //     const response = await axios.post<Array<ProductDTO>>("https://localhost:5001/product/list");
        //     return response.data;
        // } catch (error) {
        //     console.log(error);
        //     return new Array<ProductDTO>();
        // }

        // 第二種寫法
        return await axios.post<Array<IProductDTO>>("https://localhost:5001/product/list")
                          .then(response => {
                              return response.data;
                          }).catch(error => {
                                console.log(error);
                                return new Array<IProductDTO>();
                            });
    }
}

```

DTO

```ts
﻿export interface IProductDTO {
    productID: number;
    productName: string;
    supplierID: number | null;
    categoryID: number | null;
    quantityPerUnit: string;
    unitPrice: number | null;
    unitsInStock: number | null;
    unitsOnOrder: number | null;
    reorderLevel: number | null;
    discontinued: boolean;
}

```

Vue

```vue
<template>
    <div>
        <h3>Product List</h3>
        <table>
            <thead>
            <tr>
                <th>ProductID</th>
                <th>ProductName</th>
                <th>SupplierID</th>
                <th>CategoryID</th>
                <th>QuantityPerUnit</th>
                <th>UnitPrice</th>
                <th>UnitsInStock</th>
                <th>UnitsOnOrder</th>
                <th>ReorderLevel</th>
                <th>Discontinued</th>
            </tr>
            </thead>
            <tbody>
            <tr v-for="(productDTO, name, index) in this.productDTOs" :key="index">
                <td>{{ productDTO.productID }}</td>
                <td>{{ productDTO.productName }}</td>
                <td>{{ productDTO.supplierID }}</td>
                <td>{{ productDTO.categoryID }}</td>
                <td>{{ productDTO.quantityPerUnit }}</td>
                <td>{{ productDTO.unitPrice }}</td>
                <td>{{ productDTO.unitsInStock }}</td>
                <td>{{ productDTO.unitsOnOrder }}</td>
                <td>{{ productDTO.reorderLevel }}</td>
                <td>{{ productDTO.discontinued }}</td>
            </tr>
            </tbody>
        </table>
    </div>
</template>

<script lang="ts">
    import { Component, Vue } from "vue-property-decorator"
    import { IProductDTO } from "@/dtos/IProductDTO";
    import { ProductService } from "@/components/ProductService";
    import axios from "axios";

    @Component
    export default class Products extends Vue {
        private productDTOs: Array<IProductDTO>;
        private productService: ProductService;

        constructor() {
            super();
            this.productDTOs = new Array<IProductDTO>();
            this.productService = new ProductService();
        }

        async mounted() {
            this.productDTOs = await this.productService.GetProductList();
        }
    }
</script>

<style scoped>

</style>
```


