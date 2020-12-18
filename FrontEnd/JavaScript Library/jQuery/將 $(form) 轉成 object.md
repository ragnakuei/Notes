# 將 $(form) 轉成 object

## 簡單型別

網路上有些做法會用到 jQuery.serializeObject()

但實際上，jQuery 沒有提供對應的 function 

用以下方式可以解決

```javascript
// 擴充 jQuery 來支援轉成 json
$.fn.serializeObject = function () {
  let formArray = $(this).serializeArray();

  let obj = {};
  for (let i = 0; i < formArray.length; i++) {
    obj[formArray[i]["name"]] = formArray[i]["value"];
  }
  return obj;
};
```

使用範例

```javascript
$('#newGroup').serializeObject();
```

之後如果要使用 json，再以 `JSON.stringify(obj)`  就可以了

## 複雜型別

[範例連結](https://github.com/ragnakuei/FormDataToJson/blob/master/FormDataToJson/wwwroot/lib/jQuerySerializeJson.js)

- 透過解析 jQuery.serializeArray() 的資料，轉成 Json 格式
- 要解決的問題
  - 如果 jQuery.serializeArray() 產生出來的 FormData Index 不連續，Asp.Net Core 在做 Model Binding ，會有資料 Binding 不到的情況。
  - 只要轉成 Json 後，就不會受限於 FormData Index 不連續的問題了 !

可以把下面的 FormData 格式 (encode 過)

```js
Id: 1
Name: A1
Item[Id]: 100
Item[Name]: Item100
TestCategories[0][Sort]: 0
TestCategories[0][Id]: 11
TestCategories[0][Name]: A11
TestCategories[0][TestItems][0][Sort]: 0
TestCategories[0][TestItems][0][Id]: 111
TestCategories[0][TestItems][0][Name]: A111
TestCategories[0][TestItems][1][Sort]: 1
TestCategories[0][TestItems][1][Id]: 112
TestCategories[0][TestItems][1][Name]: A112
TestCategories[0][TestItems][2][Sort]: 2
TestCategories[0][TestItems][2][Id]: 113
TestCategories[0][TestItems][2][Name]: A113
TestCategories[2][Sort]: 2
TestCategories[2][Id]: 13
TestCategories[2][Name]: A13
TestCategories[2][TestItems][0][Sort]: 0
TestCategories[2][TestItems][0][Id]: 131
TestCategories[2][TestItems][0][Name]: A131
TestCategories[2][TestItems][1][Sort]: 1
TestCategories[2][TestItems][1][Id]: 132
TestCategories[2][TestItems][1][Name]: A132
TestCategories[2][TestItems][1][Detail][Id]: 1322
TestCategories[2][TestItems][1][Detail][Name]: A1322
TestCategories[2][TestItems][2][Sort]: 2
TestCategories[2][TestItems][2][Id]: 133
TestCategories[2][TestItems][2][Name]: A133
```

轉成 Json 格式

```js
{
    "Id": "1",
    "Name": "A1",
    "Item":
    {
        "Id": "100",
        "Name": "Item100"
    },
    "TestCategories": [
    {
        "Sort": 0,
        "Id": "11",
        "Name": "A11",
        "TestItems": [
        {
            "Sort": 0,
            "Id": "111",
            "Name": "A111"
        },
        {
            "Sort": 1,
            "Id": "112",
            "Name": "A112"
        },
        {
            "Sort": 2,
            "Id": "113",
            "Name": "A113"
        }]
    },
    {
        "Sort": 2,
        "Id": "13",
        "Name": "A13",
        "TestItems": [
        {
            "Sort": 0,
            "Id": "131",
            "Name": "A131"
        },
        {
            "Sort": 1,
            "Id": "132",
            "Name": "A132",
            "Detail":
            {
                "Id": "1322",
                "Name": "A1322"
            }
        },
        {
            "Sort": 2,
            "Id": "133",
            "Name": "A133"
        }]
    }]
}
```

使用方式

```js
$('#PostForm').submit(function (e)
{
    e.preventDefault();

    const requestBody = $(this).serializeJson();

    console.log(requestBody);

    $.ajax({
        url: '@(Url.Action("Index"))',
        data: requestBody,
        type: 'post',
        dataType: "json",
    }).done(function(e)
    {
        console.log(e);
    }).fail(function (e)
    {
        console.log(e);
    })
});
```

jQuerySerializeJson.js

```js
jQuery.fn.serializeJson = function () {
    const formDataArray = $(this).serializeArray();

    const clonedFormDataArray = JSON.parse(JSON.stringify(formDataArray));

    return new SerializeJson(clonedFormDataArray).Serialize();
};

window.SerializeJson = function (formDataArray) {

    const self = this;

    // properties
    self.FormDataArray = formDataArray;

    self.IndexPropertyName = 'Sort';

    self.Json = {};

    // methods
    self.Serialize = function () {

        self.Json = {};

        for (let i = 0; i < formDataArray.length; i++) {

            const formDataItem = formDataArray[i];

            const propertyInfo = ToPropertyInfo(formDataItem);

            AssignPropertyInfoToJson(propertyInfo);
        }

        return self.Json;
    }

    function AssignPropertyInfoToJson(propertyInfo) {
        switch (propertyInfo.PropertyType) {
            case PropertyType.Normal:
                self.Json[propertyInfo.Name] = propertyInfo.Value;
                break;
            case PropertyType.Array:
                AssignNestedProperty(propertyInfo);
                break;
            case PropertyType.Object:
                AssignNestedProperty(propertyInfo);
                break;
        }
    }

    function ToPropertyInfo(formDataArrayItem, arrayIndex = null) {

        const result = new PropertyInfo();

        if (arrayIndex !== null) {
            result.ArrayIndex = arrayIndex;
        }

        const nameParts = formDataArrayItem.name.split('.');

        result.Name = nameParts[0];

        if (result.Name.includes('[')) {
            result.PropertyType = PropertyType.Array;

            const arrayNameParts = result.Name.substr(0, result.Name.length - 1).split('[');
            const propertyName = arrayNameParts[0];
            const arrayIndex = parseInt(arrayNameParts[1]);

            formDataArrayItem.name = formDataArrayItem.name.replace(propertyName + '[' + arrayIndex + '].', '');

            // 原本的 result.Name 會加上 [index] 所以要重新給定
            result.Name = propertyName;
            result.ChildPropertyInfo = ToPropertyInfo(formDataArrayItem, arrayIndex);

        } else if (nameParts.length > 1) {
            result.PropertyType = PropertyType.Object;

            // 刪掉第一層的 property name
            formDataArrayItem.name = formDataArrayItem.name.replace(result.Name + '.', '');

            result.ChildPropertyInfo = ToPropertyInfo(formDataArrayItem);
        } else {
            result.Value = formDataArrayItem.value;
            result.PropertyType = PropertyType.Normal;
        }
        return result;
    }

    function AssignNestedProperty(propertyInfo) {
        // 最內層的 PropertyType 為 Normal
        // 把最內層的 JsonProperty 路徑建立起來

        let tempJsonProperty = self.Json;
        let tempPropertyInfo = propertyInfo;

        while (tempPropertyInfo.PropertyType !== PropertyType.Normal) {

            // 建立不存在的結構
            if (tempJsonProperty.hasOwnProperty(tempPropertyInfo.Name) === false) {
                if (tempPropertyInfo.PropertyType === PropertyType.Object) {
                    tempJsonProperty[tempPropertyInfo.Name] = {}
                } else if (tempPropertyInfo.PropertyType === PropertyType.Array) {
                    tempJsonProperty[tempPropertyInfo.Name] = []
                }
            }

            if (tempPropertyInfo.PropertyType === PropertyType.Object)
            {
                // object 往內層找
                tempJsonProperty = tempJsonProperty[tempPropertyInfo.Name];
                tempPropertyInfo = tempPropertyInfo.ChildPropertyInfo;
            }

            if (tempPropertyInfo.PropertyType === PropertyType.Array)
            {
                // array 往內層找
                const tempJsonProperties = tempJsonProperty[tempPropertyInfo.Name];


                const tempJsonArrayItem = tempJsonProperties.filter(p => p[self.IndexPropertyName] === tempPropertyInfo.ChildPropertyInfo.ArrayIndex)[0];

                if (tempJsonArrayItem) {
                    // 已建立對應的 object

                    tempJsonProperty = tempJsonArrayItem;
                } else {
                    // 未建立對應的 object

                    const newArrayItemObject = {};
                    newArrayItemObject[self.IndexPropertyName] = tempPropertyInfo.ChildPropertyInfo.ArrayIndex;

                    tempJsonProperty[tempPropertyInfo.Name].push(newArrayItemObject);

                    tempJsonProperty = newArrayItemObject;
                }

                tempPropertyInfo = tempPropertyInfo.ChildPropertyInfo;
            }
        }

        // 已找到最內層的 Property，給定值
        tempJsonProperty[tempPropertyInfo.Name] = tempPropertyInfo.Value;
    }
}


window.PropertyType = {
    None: 'None',
    Normal: 'Normal',
    Array: 'Array',
    Object: 'Object',
}

window.PropertyInfo = function () {
    const self = this;

    self.Name = null;
    self.PropertyType = PropertyType.None;
    self.ArrayIndex = null;
    self.ChildPropertyInfo = null;
    self.Value = null;
};
```