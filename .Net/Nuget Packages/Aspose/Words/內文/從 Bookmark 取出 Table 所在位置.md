# 

[Bookmark 設定方式](../../../../Tools/Microsoft%20Office/Word/新增%20Bookmark.md)

```csharp
var doc = new Document(filePath);

var bookmark = doc.Range.Bookmarks["表 B"];

var table = bookmark.BookmarkStart.GetAncestor(NodeType.Table) as Table;
```