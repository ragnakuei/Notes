# checkbox

1. 透過 `$(Form).serialize()` 可以直接取出有勾選的 checkbox input 的 value
2. value 所對應的欄位名稱來自於 `name`

```html
@{
    ViewData["Title"] = "Home Page";

    var engineers = new TestDto[]
                    {
                        new TestDto { Guid = Guid.NewGuid(), Name = "A", },
                        new TestDto { Guid = Guid.NewGuid(), Name = "B", },
                        new TestDto { Guid = Guid.NewGuid(), Name = "C", },
                        new TestDto { Guid = Guid.NewGuid(), Name = "D", },
                        new TestDto { Guid = Guid.NewGuid(), Name = "E", },
                    };
}

<form id="postEditForm">
    <div>
        <label for="AssignDate">指派日期</label>
        <input type="date"
               name="AssignDate"
               id="AssignDate" />
    </div>

    <label for="AssignDate">指派人員</label>
    @for (int index = 0; index < engineers.Length; index++)
    {
        <div>
            <input type="checkbox"
                   name="assignEngineer"
                   id="assignEngineer@(index)"
                   value="@(engineers[index].Guid)" />
            <label for="assignEngineer@(index)">@(engineers[index].Name)</label>
        </div>
    }
    <div>
        <input type="button"
               onclick="check()"
               value="指派" />
    </div>
</form>

<script>
    function check()
    {
        const requestBody = $('#postEditForm').serialize();
        console.table(requestBody);
    }
</script>

```