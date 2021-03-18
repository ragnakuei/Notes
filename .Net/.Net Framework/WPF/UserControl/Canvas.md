# Canvas

-   抓相對路徑的方式

```csharp
var targetPosition = rect.TranslatePoint(new Point(0, 0), cav_board);
lbChipX.Content = targetPosition.X;
lbChipY.Content = targetPosition.Y;
```

## 放大縮小 sample

```csharp

// 在指定的地方註冊 MouseWheel 事件
OutterBorder.MouseWheel += OutterBorderMouseWheelEvent;

/// <summary>
/// 實際倍率
/// </summary>
private const double _scaleRate = 1.1;

/// <summary>
/// 自訂倍率，數字愈小，看的晶片愈大
/// </summary>
/// <remarks>整體縮放比例透過 ScreenHelper.ScaleX 控制，而不是透過此變數計算的 !</remarks>
private int _scale = 0;

/// <summary>
/// 自訂最小倍率
/// </summary>
private int _minScale = -10;

/// <summary>
/// 自訂最大倍率
/// </summary>
private int _maxScale = 100;

private void OutterBorderMouseWheelEvent(object sender, MouseWheelEventArgs e)
{
    // OutterBorder 是 UserControl 最外層的 Border
    Point mousePosition = e.GetPosition(OutterBorder);

    if (Zoom(e.Delta, mousePosition) == false)
    {
        return;
    }

    e.Handled = true;
}

/// <summary>
/// 對 Canvas 進行縮放
/// </summary>
/// <param name="delta">大於 0 為放大，小於 0 為縮小</param>
/// <param name="mousePosition">以此點進行放大或縮小</param>
/// <returns>是否成功進行縮放</returns>
private bool Zoom(int delta, Point mousePosition)
{
    // _canvasContainer 是指 Border 內的第一層 Canvas，這個 Canvas 等於是所有物件的容器
    TransformGroup tg = _canvasContainer.RenderTransform as TransformGroup;

    if (tg == null)
    {
        tg = new TransformGroup();
    }

    double newScale = 0.0;
    if (delta > 0)
    {
        // 滾輪往上：放大
        if (_scale <= _minScale)
        {
            return false;
        }

        _scale--;
        newScale = 1 * _scaleRate;
    }
    else
    {
        // 滾輪往下：縮小
        if (_scale >= _maxScale)
        {
            return false;
        }

        _scale++;
        newScale = 1 / _scaleRate;
    }

    tg.Children.Add(new ScaleTransform(newScale, newScale
                                        , mousePosition.X, mousePosition.Y));

    _canvasContainer.RenderTransform = tg;
    return true;
}
```

## 以滑鼠中鍵進行 水平移動 Sample

透過三個事件來達成

```csharp

/// <summary>
/// 是否準備進行 TranslateTransform 的動作
/// </summary>
private bool _isTranslateStart = false;

private Point _previousPoint;

// 在指定的地方註冊 MouseDown、MouseUp、MouseMove 事件
OutterBorder.MouseDown  += OutterBorderMouseDownEvent;
OutterBorder.MouseUp    += OutterBorderMouseUpEvent;
OutterBorder.MouseMove  += OutterBorderMouseMoveEvent;

private void OutterBorderMouseUpEvent(object sender, MouseButtonEventArgs e)
{
    if (e.MiddleButton == MouseButtonState.Pressed
        && e.LeftButton == MouseButtonState.Released
        && e.RightButton == MouseButtonState.Released)
    {
        if (_isTranslateStart)
        {
            _isTranslateStart = false;
        }
    }

    e.Handled = true;
}

private void OutterBorderMouseDownEvent(object sender, MouseButtonEventArgs e)
{
    if (e.MiddleButton == MouseButtonState.Pressed
        && e.LeftButton == MouseButtonState.Released
        && e.RightButton == MouseButtonState.Released)
    {
        _previousPoint = e.GetPosition(OutterBorder);
        _isTranslateStart = true;
    }

    e.Handled = true;
}

private void OutterBorderMouseMoveEvent(object sender, MouseEventArgs e)
{
    if (e.MiddleButton == MouseButtonState.Pressed
    && e.LeftButton == MouseButtonState.Released
    && e.RightButton == MouseButtonState.Released)
    {
        if (_isTranslateStart)
        {
            Point currentPoint = e.GetPosition(OutterBorder); //不能用 inside，必须用outside
            Vector v = currentPoint - _previousPoint;
            TransformGroup tg = _canvasContainer.RenderTransform as TransformGroup;

            if (tg == null)
            {
                tg = new TransformGroup();
            }

            tg.Children.Add(new TranslateTransform(v.X, v.Y)); //centerX和centerY用外部包装元素的坐标，不能用内部被变换的Canvas元素的坐标

            _previousPoint = currentPoint;
        }
    }

    e.Handled = true;
}
```
