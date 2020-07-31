# JSEncrypt

可用來針對 rsa 加密的 library

## 建立 rsa 1024 bit 的 key pair

```
openssl genrsa -out rsa_1024_priv.pem 1024
cat rsa_1024_priv.pem
openssl rsa -pubout -in rsa_1024_priv.pem -out rsa_1024_pub.pem
cat rsa_1024_pub.pem
```

## 建立 rsa 2048 bit 的 key pair

```
openssl genrsa -out rsa_2048_priv.pem 2048
cat rsa_2048_priv.pem
openssl rsa -pubout -in rsa_2048_priv.pem -out rsa_2048_pub.pem
cat rsa_2048_pub.pem
```

## asp.net mvc 範例

```csharp
@using MvcFormEncryptPassword.Store
@model MvcFormEncryptPassword.Controllers.LoginViewModel
@{
    ViewBag.Title = "Home Page";

    var publicKey = @"-----BEGIN PUBLIC KEY-----
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA0+qTcuPOpyAlfuCT0DQk
YzeuwSjVnPcckVgNR7qm2vDZUFxye05HH61vnSlmpxLL/4uIGGyaDOKJXrclxj06
sfwDFHl1vD21ERImCKsqsCFf7mxqDgWLNAD7/RERgcuw7EoQhPQWePg5lOnS1Bvr
xS3Sl0K5nQr75fvy2GOZNKpVHRl5K3c82DBMWdeqjpG7RI/SAmSpBox/NEuBEE+b
x17KtH77G2rAm3vYGqRLrHY/+ax0h0j44kvsJTFyU8e759cOE2jYWFWdL8YIImZx
4C3mjULjePxJDmL5BUwmlTjzhkQDWGhiLU7yLeUP54WfGEs9isST5Pi+QrHJ96iZ
xwIDAQAB
-----END PUBLIC KEY-----";
}

@using (Html.BeginForm("Index", "Home",
                       FormMethod.Post,
                       new
                       {
                           Id = "form"
                       }))
{
    @Html.AntiForgeryToken()
    <input type="hidden" id="publicKey" value="@(publicKey)"/>
    <p>
        @Html.DisplayFor(m => m.Username)
        @Html.EditorFor(m => m.Username)
    </p>
    <p>
        @Html.DisplayFor(m => m.Password)
        @Html.PasswordFor(m => m.Password, new { Id = "password" })
    </p>
    <p>
        <input id="submit" type="button" value="Login"/>
    </p>
}

@section scripts
{
    <script src="~/Scripts/jsencrypt.min.js"></script>
    <script>
    $('#submit').click(function ()
    {
        var publicKey = $('#publicKey').val();

        var encryptedPassword;
        var pwd = $('#password').val();

        if (pwd !== null && pwd !== "") {

            var crypt = new JSEncrypt();
            crypt.setPublicKey(publicKey);

            encryptedPassword = crypt.encrypt(pwd);

            console.log(encryptedPassword);
            $('#PWD').val(encryptedPassword);
        }
    })
</script>
}
```

## 搭配 vue

npm install jsencrypt

```ts
import { Component, Vue } from 'vue-property-decorator';
import { JSEncrypt } from 'jsencrypt'; // 這邊會產生警告，但可以暫時不管

@Component
export class JSEncryptService extends Vue {
    constructor() {
        super();

        this.jsEncrypt = new JSEncrypt();
    }

    async mounted() {
        const publicKey = (await this.$axios.get<string>('/rsa/publickey'))
            .data;
        this.jsEncrypt.setPublicKey(publicKey);
    }

    public Encrypt(str: string): string {
        return this.jsEncrypt.encrypt(str);
    }

    private jsEncrypt: any;
}
```
