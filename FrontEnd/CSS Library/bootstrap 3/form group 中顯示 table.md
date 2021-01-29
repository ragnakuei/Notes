# form group 中顯示 table

```html
<div class="container body-content">
    

<h2>Detail</h2>

    <div class="form-horizontal">
        <hr>

        <div class="form-group">
            <label class="control-label col-md-2" for="Group_Id">編號</label>
            <div class="col-md-10">
                1
            </div>
        </div>

        <div class="form-group">
            <label class="control-label col-md-2" for="Group_Name">名稱</label>
            <div class="col-md-10">
                adminGroup
            </div>
        </div>

        <div class="form-group">
            <label class="control-label col-md-2" for="Group_Created">建立時間</label>
            <div class="col-md-10">
                2020/5/7 下午 05:21:46
            </div>
        </div>

        <div class="form-group">
            <label class="control-label col-md-2" for="UserNames">UserNames</label>

            <!-- 範例 -->
            <div class="table-responsive">
                <table class="table">
                        <tbody><tr>
                            <td>admin</td>
                        </tr>
                </tbody></table>
            </div>
        </div>

        <div class="form-group">
            <label class="control-label col-md-2" for="RoleNames">RoleNames</label>

            <!-- 範例 -->
            <div class="table-responsive">
                <table class="table">
                        <tbody><tr>
                            <td>Admin</td>
                        </tr>
                </tbody></table>
            </div>
        </div>
    </div>
    <hr>
    <footer>
        <p>© 2020 - My ASP.NET Application</p>
    </footer>
</div>
```