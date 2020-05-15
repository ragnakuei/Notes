# [Drag And Drop Overview](https://docs.microsoft.com/en-us/dotnet/framework/wpf/advanced/drag-and-drop-overview)

- [Drag And Drop Overview](#drag-and-drop-overview)
  - [順序](#%e9%a0%86%e5%ba%8f)
  - [程式範例](#%e7%a8%8b%e5%bc%8f%e7%af%84%e4%be%8b)

如果需要變更拖拉時的外觀，可參考關鍵字 Adorner Layer

---

## 順序

1. 於 Source.(Preview)MouseMove Event 中
   1. 執行 [DragDrop.DoDragDrop()](https://docs.microsoft.com/en-us/dotnet/api/system.windows.dragdrop.dodragdrop?view=netframework-4.8)
      1. 可把傳遞的資料放至 data 引數中
   1. 此時程式不會繼續執行此 Event 之後的程式碼
1. 進行 Drop 的動作 (滑鼠左鍵放掉)
1. 執行 Target Drop Event
   1. 可從 DragEventArgs.Data.GetData(typeof(DragChip)) 來取出 data 的引數 (資料型態為 object，要記得轉型)
1. Target Drop Event 執行完畢後，會在 Source 的 DragDrop.DoDragDrop() 地方接下去執行

---

## 程式範例

```csharp

// Source

public partial class DragSource : Window
{
    public DragSource()
    {
        InitializeComponent();
    }

    private Point _lastMouseDown;
    private AccordionItem _draggedItem;

    private void PreviewMouseDown(object sender, MouseButtonEventArgs e)
    {
        AccordionControl accordion = sender as AccordionControl;

        IInputElement element = accordion.InputHitTest(e.GetPosition(accordion));
        var item = LayoutTreeHelper.GetVisualParents((DependencyObject)element).OfType<AccordionItem>().FirstOrDefault();

        if (item != null)
        {
            _draggedItem = item;
        }
    }

    private void PreviewMouseUp(object sender, MouseButtonEventArgs e)
    {
        _draggedItem = null;
    }

    private void PreviewMouseMove(object sender, MouseEventArgs e)
    {
        if (e.LeftButton == MouseButtonState.Pressed)
        {
            Point currentPosition = e.GetPosition((UIElement)e.Source);

            if ((Math.Abs(currentPosition.X - _lastMouseDown.X) > 5.0) ||
                (Math.Abs(currentPosition.Y - _lastMouseDown.Y) > 5.0))
            {
                if (_draggedItem != null)
                {
                    var dragChip = new DragChip
                    {
                        Name = _draggedItem.Header
                    };

                    DragDropEffects finalDropEffect = DragDrop.DoDragDrop((UIElement)e.Source, dragChip, DragDropEffects.Move);
                }
            }
        }
    }
}

// Target

public partial class DropTarget : UserControl
{
    public DropTarget()
    {
        InitializeComponent();
    }

    private void DropObject(object sender, DragEventArgs e)
    {
        e.Effects = DragDropEffects.None;
        e.Handled = false;

        DragChip dropObject = e.Data?.GetData(typeof(DragChip)) as DragChip;

        if (dropObject == null)
        {
            return;
        }
    }
}
```