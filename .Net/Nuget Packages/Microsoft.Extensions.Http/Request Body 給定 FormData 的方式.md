# Request Body 給定 FormData 的方式

參考資料

- [How to upload file to server with HTTP POST multipart/form-data](https://stackoverflow.com/questions/19954287/how-to-upload-file-to-server-with-http-post-multipart-form-data)

- MultipartFormDataContent.Add(new StringContent(value), key)
  - key 跟 value 的位置要注意 !


```cs
HttpClient httpClient = new HttpClient();
MultipartFormDataContent form = new MultipartFormDataContent();

form.Add(new StringContent(username), "username");
form.Add(new StringContent(useremail), "email");
form.Add(new StringContent(password), "password");            
form.Add(new ByteArrayContent(file_bytes, 0, file_bytes.Length), "profile_pic", "hello1.jpg");
HttpResponseMessage response = await httpClient.PostAsync("PostUrl", form);

response.EnsureSuccessStatusCode();
httpClient.Dispose();
string sd = response.Content.ReadAsStringAsync().Result;
```