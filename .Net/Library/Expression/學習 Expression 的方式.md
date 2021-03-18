# 學習 Expression 的方式

可以透過 Linqpad 觀察 `Body`、`Parameters` 的內容

逐步拆解看看是什麼內容組成的 !

```csharp
void Main()
{   
    Expression<Func<Student, bool>> e = s => s.Score > 60;
    e.Dump();
}

public class Student
{ 
    public int Id { get; set; }
    
    public string Name { get; set; }
    
    public int Score { get; set; }
}
```