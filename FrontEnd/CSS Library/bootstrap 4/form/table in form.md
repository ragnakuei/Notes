# table in form

- table 

## 範例

- table > tbody > tr > td 內，以 .row 來包住 .form-control
- 再加上 mx-3
- 會比較像是完整套用 bootstrap style 

    ```html
    <td>
        <div class="row">
            <input type="text"
                   class="form-control mx-3"
                   v-model="detail.Item" />
        </div>
    </td>
    ```

- 完整範例

    ```html
    <form id="app"
        v-cloak>
        <div class="form-group form-inline">
            <label for="Name"
                   class="control-label">
                Name
            </label>
            <input id="Name"
                   v-model="vm.Name"
                   class="form-control mx-3" />
        </div>
        <div class="table-responsive">
            <table class="table table-sm">
                <thead>
                <tr>
                    <th scope="col">項目</th>
                    <th scope="col">單價</th>
                    <th scope="col">數量</th>
                    <th scope="col"
                        style="width: 100px;">
                        金額
                    </th>
                    <th scope="col"
                        style="width: 50px;">
                    </th>
                </tr>
                </thead>
                <tbody>
                <tr v-for="(detail, detailIndex) in vm.Details"
                    :key="detailIndex">
                    <td>
                        <div class="row">
                            <input type="text"
                                class="form-control mx-3"
                                v-model="detail.Item" />
                        </div>
                    </td>
                    <td>
                        <div class="row">
                            <input type="text"
                                class="form-control mx-3"
                                v-model="detail.UnitPrice" />
                        </div>
                    </td>
                    <td>
                        <div class="row">
                            <input type="text"
                                class="form-control mx-3"
                                v-model="detail.Count" />
                        </div>
                    </td>
                    <td>{{ detail.Amount }}</td>
                    <td>
                        <button type="button"
                                class="btn btn-danger"
                                v-on:click="DeleteDetail(detailIndex)">
                            Delete
                        </button>
                    </td>
                </tr>
                <tr>
                    <td colspan="3"
                        class="textRight"
                        style="border: none;">
                        小計
                    </td>
                    <td>{{vm.SubTotal}}</td>
                    <td></td>
                </tr>
                <tr>
                    <td colspan="3"
                        class="textRight"
                        style="border: none;">
                        營業稅
                    </td>
                    <td>{{vm.BusinessTax}}</td>
                    <td></td>
                </tr>
                <tr>
                    <td colspan="3"
                        class="textRight"
                        style="border: none;">
                        總計
                    </td>
                    <td>{{vm.Total}}</td>
                    <td></td>
                </tr>
                </tbody>
            </table>
        </div>
        <div class="form-row align-items-center">
            <div class="col-auto mr-auto">
                <button type="button"
                        class="btn btn-primary mb-2"
                        v-on:click="AddDetail()">
                    Add Detail
                </button>
            </div>
            <div class="col-auto">
                <button type="button"
                        class="btn btn-primary mb-2">
                    Calculate
                </button>
            </div>
        </div>
        <div class="float-right">
            <div class="col-auto">
                <button type="button"
                        class="btn btn-primary mb-2">
                    Submit
                </button>
            </div>
        </div>
        <a v-bind:href="backUrl">Back to List</a>
    </form>
    ```