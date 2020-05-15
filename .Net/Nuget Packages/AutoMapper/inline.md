# inline

環境：DotNetCore 3

```csharp
var mapper = new MapperConfiguration(cfg => cfg.AddProfile(new AutoMapperProfile()));
_mapper = mapper.CreateMapper();

var result = _dtos.Select(dto =>  _mapper.Map<Class2>(dto)).ToArray();
return result;

```
