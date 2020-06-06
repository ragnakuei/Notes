# [nvabar](https://bootstrapdocs.com/v3.0.3/docs/components/#navbar)

```html
<div class="navbar navbar-inverse navbar-fixed-top">
    <div class="container">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            @Html.ActionLink("Application name", "Index", "Home", new { area = "" }, new { @class = "navbar-brand" })
        </div>
        <div class="navbar-collapse collapse">
            <ul class="nav navbar-nav">
                <li>
                    <a href="/member/">Member Info</a>
                </li>
                <li>
                    <a href="/member/role1">Role1</a>
                </li>
                <li>
                    <a href="/member/role2">Role2</a>
                </li>
                <li>
                    @{
                        if (isAuthenticated)
                        {
                            <a href="/auth/logout">Logout</a>
                        }
                        else
                        {
                            <a href="/auth/login">Login</a>
                        }
                    }
                </li>
                <li>
                    <a href="/groups">Group</a>
                </li>
                <!-- 下拉選單 -->
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">Dropdown <b class="caret"></b></a>
                    <ul class="dropdown-menu">
                        <li>
                            <a href="#">Action</a>
                        </li>
                        <li>
                            <a href="#">Another action</a>
                        </li>
                        <li>
                            <a href="#">Something else here</a>
                        </li>
                        <li class="divider"></li>
                        <li>
                            <a href="#">Separated link</a>
                        </li>
                        <li class="divider"></li>
                        <li>
                            <a href="#">One more separated link</a>
                        </li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</div>
```