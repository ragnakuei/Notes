# ScenarioContext

## Set

二種語法

```csharp
ScenarioContext.Set(value, "key");
ScenarioContex["key"] = value;
```

## Get

二種語法

```csharp
var valut = ScenarioContext.Get\<T>("key");
var value = (T)ScenarioContex["key"];
```
