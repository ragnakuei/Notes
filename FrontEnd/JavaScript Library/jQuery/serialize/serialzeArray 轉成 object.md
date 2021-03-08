# serialzeArray 轉成 object

## 單層 物件

物件

```csharp
public class FormDto
{
    public Guid FormGuid { get; set; }

    public Guid[] AGuids { get; set; }

    public Guid[] BGuids { get; set; }
}
```

js

-   將 Guids 的 Property 都重新 reIndex

    ```js
    const formDataArray = $('#postEditForm').serializeArray();
    const requestBody = {};
    for (let pair of formDataArray) 
    {
        let newName = pair.name;

        // 重新組 Guids 的 key
        if (newName.endsWith('Guids')) 
        {
            for (let i = 0; i < 1000; i++) 
            {
                newName = pair.name + `[${i}]`;

                if (requestBody.hasOwnProperty(newName) === false) 
                {
                    break;
                }
            }
        }

        requestBody[newName] = pair.value;
    }

    $.ajax({
        url: searchEmployeeApiUrl,
        type: 'post',
        data: requestBody,
        success: response,
        error: function () {
            response([]);
        },
    });
    ```
