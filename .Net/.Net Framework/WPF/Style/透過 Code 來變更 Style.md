# 透過 Code 來變更 Style

```c#
var styBlurbtn = new Style();
styBlurbtn.Setters.Add( new Setter( UIElement.OpacityProperty,       0.3 ) );
styBlurbtn.Setters.Add( new Setter( FrameworkElement.CursorProperty, Cursors.Hand ) );
```