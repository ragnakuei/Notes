# md5

## 對 file 做 md5 checksum

### 單一檔案

以下這個版本可以跟後端 C# 比對

```html
<p>
    <input type="file"
           onchange="file_on_change(event)" />
</p>

<script src="https://cdnjs.cloudflare.com/ajax/libs/spark-md5/3.0.0/spark-md5.min.js"
        integrity="sha512-5Cmi5XQym+beE9VUPBgqQnDiUhiY8iJU+uCUbZIdWFmDNI+9u3A7ntfO8fRkigdZCRrbM+DSpSHSXAuOn5Ajbg=="
        crossorigin="anonymous"
        referrerpolicy="no-referrer">
</script>
<script>
    const file_on_change = function(event) {
      event.preventDefault();

      const file = event.target.files[0];
      const reader = new FileReader();

      reader.onload = function(event) {
        const binary = event.target.result;

        const spark = new SparkMD5.ArrayBuffer();
        spark.append(binary);
        const md5 = spark.end();

        console.log(md5);
      };

      reader.readAsArrayBuffer(file);
    };
</script>
```

下面這個版本的 md5 與 csharp 對不上，需要再測試與釐清 !

```html
<p>
    <input type="file"
           onchange="file_on_change(event)" />
</p>

<script src="https://cdnjs.cloudflare.com/ajax/libs/crypto-js/4.1.1/crypto-js.min.js"
        integrity="sha512-E8QSvWZ0eCLGk4km3hxSsNmGWbLtSCSUcewDQPQWZF6pEU8GlT8a5fF32wOl1i8ftdMhssTrF/OhyGWwonTcXA=="
        crossorigin="anonymous"
        referrerpolicy="no-referrer">
</script>
<script>

    // e65d1698a844d8ee02da34e3022a775d
    // 04d1960d3d0e26256cf15e5074a4e25b
    // bbc5c717923cfc5b230803e0257e6f65
    // const file_on_change = function(event) {
    //
    //     const reader = new FileReader();
    //     const file = event.target.files[0];
    //
    //     reader.addEventListener("load", function () {
    //         const base64result = reader.result.split(',')[1]; // only get base64 string
    //         // const hash = SparkMD5.hash(base64result);
    //         const md5 = CryptoJS.MD5(base64result).toString();
    //         console.log(md5);
    //     }, false);
    //
    //     reader.readAsDataURL(file);
    //     // reader.readAsBinaryString(file);
    //     // reader.readAsArrayBuffer(file);
    // }

    const file_on_change = function(event) {
      event.preventDefault();
    
      const file = event.target.files[0];
      const reader = new FileReader();
    
      reader.onload = function(event) {
        const binary = event.target.result;
    
        // console.log(binary);   // 顯示所有文字內容
    
        const md5 = CryptoJS.MD5(binary).toString();
        console.log(md5);
      };
    
      // reader.readAsDataURL(file);
      reader.readAsBinaryString(file);
    //   reader.readAsArrayBuffer(file);
    };
</script>
```