# init accessor

- 可於 object initializer 時給定該 property 值，但之後不可以變更值

### 範例一

```csharp
public struct WeatherObservation
{
    public DateTime RecordedAt { get; init; }
    public decimal TemperatureInCelsius { get; init; }
    public decimal PressureInMillibars { get; init; }

    public override string ToString() =>
        $"At {RecordedAt:h:mm tt} on {RecordedAt:M/d/yyyy}: " +
        $"Temp = {TemperatureInCelsius}, with {PressureInMillibars} pressure";
}
```

### 範例二

```csharp
public class Point
{
    public int X { get; init; }

    public int Y { get; init; }
}
```