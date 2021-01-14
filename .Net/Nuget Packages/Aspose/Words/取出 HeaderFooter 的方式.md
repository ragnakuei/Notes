#


```csharp
var doc = new Document(exportFileDto.TemplateFile);

var headerFooters = doc.GetChildNodes(NodeType.HeaderFooter, true);
```