# checkmarx

## 高風險

- Action 以 Model 回傳至 View 時，如果沒有經過驗證，就會被視為高風險 !
  - 在使用輕前端 Vue 的情況下，可以直接改用 ViewBag 將資料傳遞至 View，然後直接 ToJson() 給 js 讀取。

- Partial View
  - Model 先 ToJson() 放在 C# 中，再加上 Html.Raw() 傳遞給 js，這仍然被視為高風險 !

- HttpGet 儘量不要用 query string & key 的資料型為 string，會被視為有 path traversal 的高風險。

### Path Traversal

被列出高風險的問題點

1. 不能切換到不同資料夾

   > 過濾 / \ .. 等字元，就可以解決 !
  
1. 不能判斷該資料夾內有哪些檔案
   > 只要一直儲存相同檔案，不會被阻擋或拒絕，就可以解決 !
   
   解決方式：
   1. 以亂數檔名儲存，例：Path.GetTempFileName()，實際檔名要存在資料庫中
   1. 儲存檔案時，先寫入資料表，取得 id 後，再以 id 當作檔名的一部份儲存


### Client DOM Stored XSS

  - 原因1: ajax 取回資料後，直接透過 jQuery.html() 放入 DOM 中。
  - 建議解法1：使用 jQuery.text() 或 jQuery.val() 來取代 jQuery.html()
  - 解法2：在 ajax 取回資料後，用以下的 js function 來過濾掉 html tag。
  
    ```js
    function check(data)  { 
      return data;
    }
    ```
  - 解法3：在 ajax 回傳前先做 html encode，在取回資料後，用以下的 js function 來做 html decode

    ```js
    function htmlDecode(input) {
      var doc = new DOMParser().parseFromString(input, "text/html");
      return doc.documentElement.textContent;
    }
    ```

  - 解法3：使用 DOMPurify 來過濾 html tag

    ```js
    $.ajax({
      type: 'POST',
      url: '/submit',
      data: {
        // 
      },
      success: function(response) {
        let purify = DOMPurify.sanitize(data, { RETURN_DOM_FRAGMENT: true });
        $('#result').html(purify);
      }
    });
    ```

  - 解法4：使用 DOMPurify 來過濾 html tag

    聽說用解法3 的功能會壞掉，所以可以試試用假的 

    ```js
    let DOMPurify = {
      sanitize : function(data) {
          return data;
      }
    }
    ```
