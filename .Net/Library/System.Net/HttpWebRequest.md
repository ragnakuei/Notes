# HttpWebRequest

## 發送夾帶 Certificate 的 Request

資料來源：[[faq]解決C#呼叫有ssl憑證問題的網站出現遠端憑證是無效的錯誤問題](https://blog.alantsai.net/posts/2017/12/csharp-ssl-remote-validation-error)

1. 加事件至 Application_Start()

    ```csharp
    // 要與 .cer 上所註冊的 domain 一致
    var cerHost = "test.com";

    ServicePointManager.ServerCertificateValidationCallback += (sender, cert, chain, sslPolicyErrors) =>
    {
        if (sslPolicyErrors == SslPolicyErrors.None)
        {
            return true;
        }
        
        var request = sender as HttpWebRequest;
        if (request != null)
        {
            var result = request.RequestUri.Host == "problem.com";
            return result;
        }
        return false;
    };

    Net.ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls | SecurityProtocolType.Tls11 | SecurityProtocolType.Tls12;
    ```

1. HttpWebRequest Sample Code

    ```csharp
    public static string GetResponseText(string url, string cerFilePath)
    {
        var request = (HttpWebRequest)WebRequest.Create(url);

        // 抓本機使用者所安裝的憑證，前提是憑証已安裝至該台主機的該使用者上
        //var store = new X509Store(userName, StoreLocation.LocalMachine);
        //store.Open(OpenFlags.ReadOnly);
        //var cerCollection = store.Certificates.Find(X509FindType.FindBySubjectName, hostName, true);
        //request.ClientCertificates = cerCollection;

        var certificate = X509Certificate.CreateFromCertFile(cerFilePath);
        request.ClientCertificates.Add(certificate);

        using (var response = (HttpWebResponse)request.GetResponse())
        {
            using (var responseStream = response.GetResponseStream())
            using (var reader = new StreamReader(responseStream, Encoding.UTF8))
            {
                return reader.ReadToEnd();
            }
        }
    }
    ```