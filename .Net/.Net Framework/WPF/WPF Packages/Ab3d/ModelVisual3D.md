# ModelVisual3D

可視為 Visual3D 的 Group

可以塞 BoxVisual3D、LineVisual3D ．．． 等

```csharp
eventSource3D.MouseEnter += MouseEnterTopViewItem;
eventSource3D.MouseLeave += MouseLeaveTopViewItem;

void MouseEnterTopViewItem(object sender, Ab3d.Common.EventManager3D.Mouse3DEventArgs e)
{
    Debug.WriteLine("MouseEnterTopViewItem");
    
    ViewTopViewport3d.Cursor = Cursors.Hand;

    if (sender is VisualEventSource3D target 
        && target.TargetVisual3D is BaseModelVisual3D visual3D )
    {
        _topViewBeforeMouseEnterOriginMaterial = visual3D.Material as DiffuseMaterial;

        visual3D.Material = new DiffuseMaterial(Brushes.Red);
    }
}

void MouseLeaveTopViewItem(object sender, Ab3d.Common.EventManager3D.Mouse3DEventArgs e)
{
    Debug.WriteLine("MouseLeaveTopViewItem");
    
    ViewTopViewport3d.Cursor = null;

    if (sender is VisualEventSource3D target 
        && target.TargetVisual3D is BaseModelVisual3D visual3D )
    {
        visual3D.Material = _topViewBeforeMouseEnterOriginMaterial;
    }
}
```
