# TinyMCE 7

可用以下方式安裝

-   [Nuget](https://www.nuget.org/packages/TinyMCE/)
-   [自行下載](https://www.tiny.cloud/get-tiny/)

### Nuget

透過 Nuget 安裝後，要等下載完畢，相關檔案才會被加到專案中

## License 指定方式

[License Key](https://www.tiny.cloud/docs/tinymce/latest/license-key/)

```js
tinymce.init({
    // 指定 使用 license GPL 版
    // 如果沒有指定，則會在 console 顯示警告
    // 如果有 license key，則將 key 取代下方 gpl 字串
    license_key: 'gpl',
    selector: 'textarea',
    // ...
});
```
