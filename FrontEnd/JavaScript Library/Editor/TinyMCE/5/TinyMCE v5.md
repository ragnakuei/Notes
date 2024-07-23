


```js
tinymce.init({
  selector: b,
  language: c,
  menubar: false,
  plugins:
    "advlist lists contextmenu table textcolor colorpicker textpattern charmap fullscreen powerpaste imgupd FMathEditor svgedit ",
  toolbar:
    "undo redo | cut copy paste pastetext bold italic underline strikethrough | alignleft aligncenter alignright outdent indent | fontselect fontsizeselect | bullist numlist | forecolor backcolor subscript superscript charmap | imgupd FMathEditor svgedit table | fullscreen  | warning",
  advlist_bullet_styles: "circle,disc,square",
  height: 580,
  width: 895,
  statusbar: false,
  paste_data_images: true,
  images_upload_url: "../tinymce/utils/upload",
  contextmenu: "cut copy paste pastetext inserttable | cell row column deletetable ",
  font_formats:
    "\u65b0\u7d30\u660e\u9ad4=\u65b0\u7d30\u660e\u9ad4;\u6a19\u6977\u9ad4=\u6a19\u6977\u9ad4;\u5fae\u8edf\u6b63\u9ed1\u9ad4=\u5fae\u8edf\u6b63\u9ed1\u9ad4;Arial=arial;Arial Black=arial black;Times New Roman=times new roman;",
  valid_elements:
    "@[id|class|style|title|dir<ltr?rtl|lang|xml::lang|onclick|ondblclick|onmousedown|onmouseup|onmouseover|onmousemove|onmouseout|onkeypress|onkeydown|onkeyup],a[rel|rev|charset|hreflang|tabindex|accesskey|type|name|href|target|title|class|onfocus|onblur],strong/b,em/i,strike,u,#p,-ol[type|compact],-ul[type|compact],-li,br,img[border|class|data-mce-src|height|id|itri|src|alt|style|width|align],-sub,-sup,-blockquote,-table[border=0|cellspacing|cellpadding|width|frame|rules|height|align|summary|bgcolor|background|bordercolor],-tr[rowspan|width|height|align|valign|bgcolor|background|bordercolor],tbody,thead,tfoot,#td[colspan|rowspan|width|height|align|valign|bgcolor|background|bordercolor|scope],#th[colspan|rowspan|width|height|align|valign|scope],caption,-div,-span,-code,-pre,address,-h1,-h2,-h3,-h4,-h5,-h6,hr[size|noshade],-font[face|size|color],dd,dl,dt,cite,abbr,acronym,del[datetime|cite],ins[datetime|cite],object[classid|width|height|codebase|*],param[name|value|_value],embed[type|width|height|src|*],script[src|type],map[name],area[shape|coords|href|alt|target],bdo,button,col[align|char|charoff|span|valign|width],colgroup[align|char|charoff|span|valign|width],dfn,fieldset,form[action|accept|accept-charset|enctype|method],input[accept|alt|checked|disabled|maxlength|name|readonly|size|src|type|value],kbd,label[for],legend,noscript,optgroup[label|disabled],option[disabled|label|selected|value],q[cite],samp,select[disabled|multiple|name|size],small,textarea[cols|rows|disabled|name|readonly],tt,var,big",
  setup: function (a) {
    a.on("FullscreenStateChanged", function () {
      if ($(".mce-fullscreen").length > 1) {
        $("#PageHeader_MainMenu").hide();
      } else {
        $("#PageHeader_MainMenu").show();
      }
    });
    a.on("init", function () {
      this.getDoc().body.style.fontFamily = "Times New Roman";
      this.getBody().style.fontSize = "12pt";
    });
    a.on("change", function () {
      $(window).bind("beforeunload", function (e) {
        return "資料尚未存檔，確定是否要離開?";
      });
    });
    a.addButton("warning", {
      text: "\u8acb\u52ff\u63d2\u5165\u542b\u5916\u90e8\u9023\u7d50\u7684\u7db2\u5740",
      icon: false,
      classes: "warning-btn",
      onclick: function () {},
    });
  },
  invalid_elements: "script,object,applet,iframe,style",
  relative_urls: false,
  remove_script_host: false,
  document_base_url: d,
  entity_encoding: "raw",
});
```


### 圖片處理

#### paste

[Handling image uploads](https://www.tiny.cloud/docs/tinymce/latest/upload-images/)
- editor.uploadImages()