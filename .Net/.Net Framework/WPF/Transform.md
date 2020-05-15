# Transform

## 增加 Transform3D 的語法

```csharp
private void AddTransform(Transform3D transform3D)
{
    if (Transform == null)
    {
        Transform = transform3D;
        return;
    }

    Transform3DGroup transform3DGroup = Transform as Transform3DGroup;
    if (transform3DGroup == null)
    {
        // If there is already some other transformation, then create a new Transform3DGroup
        transform3DGroup = new Transform3DGroup();
        transform3DGroup.Children.Add(Transform);

        Transform = transform3DGroup;
    }

    // Insert rotation as the first transformation - this way we are sure that it gets before any translations
    if (transform3DGroup.Children.Count > 0)
    {
        transform3DGroup.Children.Insert(0, transform3D);
    }
    else
    {
        transform3DGroup.Children.Add(transform3D);
    }
}
```

