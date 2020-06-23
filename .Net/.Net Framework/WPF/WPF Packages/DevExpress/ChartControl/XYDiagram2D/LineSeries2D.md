# LineSeries2D

## 以 Code 增加二條線，並顯示至不同的 Axis-Y 上

```xml
<Window xmlns:dxc="http://schemas.devexpress.com/winfx/2008/xaml/charts" x:Class="WpfApp1.MainWindow"
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
        xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
        xmlns:local="clr-namespace:WpfApp1"
        mc:Ignorable="d"
        Title="MainWindow" Height="450" Width="800">
    <Grid>
        <dxc:ChartControl Name="ChartControl">
            <dxc:ChartControl.Titles>
                <dxc:Title Content="Test"
                           HorizontalAlignment="Center" />
            </dxc:ChartControl.Titles>
            <dxc:ChartControl.Legend>
                <dxc:Legend />
            </dxc:ChartControl.Legend>

            <dxc:ChartControl.Diagram>
                <dxc:XYDiagram2D Name="XYDiagram2D" />
            </dxc:ChartControl.Diagram>
        </dxc:ChartControl>
    </Grid>
</Window>
```

先產生好 Axis-Y 跟 Secondary Axis-Y

在建立 LineSeries2D 時，就順便給定對應的 Axis-Y 就可以了

> 另一個角度來看就是給定相同 Axis-Y reference 就會視為是該 axis 的資料

```csharp
using DevExpress.Xpf.Charts;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace WpfApp1
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        private AxisY2D          _axisY2D;
        private SecondaryAxisY2D _secondaryAxisY2D;

        public MainWindow()
        {
            InitializeComponent();

            _axisY2D = new AxisY2D
                       {
                           Title      = new AxisTitle { Content = "Return Loss (Magnitude)" },
                           Visibility = Visibility.Hidden,
                           Brush      = new SolidColorBrush(Colors.Blue),
                           WholeRange = new Range { MinValue = 0, MaxValue = 10 },
                       };

            _secondaryAxisY2D = new SecondaryAxisY2D
                                {
                                    Title      = new AxisTitle { Content = "Insertion Loss (db)" },
                                    Brush      = new SolidColorBrush(Colors.Red),
                                    WholeRange = new Range { MinValue = 0, MaxValue = 50 },
                                };

            InitialXYDiagram2D();

            Add1stLineSeries2D();
            Add2ndLineSeries2D();
        }

        private void InitialXYDiagram2D()
        {
            XYDiagram2D.AxisX = new AxisX2D
                                {
                                    Title = new AxisTitle { Content = "Frequency (GHz)" },
                                };

            XYDiagram2D.AxisY = _axisY2D;

            XYDiagram2D.SecondaryAxesY.Add(_secondaryAxisY2D);
        }

        private void Add1stLineSeries2D()
        {
            var result = new LineSeries2D
                         {
                             DisplayName   = "2nd",
                             MarkerVisible = false,
                             LineStyle     = new LineStyle { Thickness = 4 },
                             Brush         = new SolidColorBrush(Colors.Blue),
                             AxisY         = _axisY2D,
                         };

            result.Points.Add(new SeriesPoint { Argument = "A", Value = 1 });
            result.Points.Add(new SeriesPoint { Argument = "B", Value = 3 });
            result.Points.Add(new SeriesPoint { Argument = "C", Value = 5 });
            result.Points.Add(new SeriesPoint { Argument = "D", Value = 7 });
            result.Points.Add(new SeriesPoint { Argument = "E", Value = 9 });
            result.Points.Add(new SeriesPoint { Argument = "F", Value = 2 });

            XYDiagram2D.Series.Add(result);
        }

        private void Add2ndLineSeries2D()
        {
            var result = new LineSeries2D
                         {
                             DisplayName   = "2nd",
                             MarkerVisible = false,
                             LineStyle     = new LineStyle { Thickness = 4 },
                             Brush         = new SolidColorBrush(Colors.Red),
                             AxisY         = _secondaryAxisY2D,
                         };

            result.Points.Add(new SeriesPoint { Argument = "A", Value = 10 });
            result.Points.Add(new SeriesPoint { Argument = "B", Value = 20 });
            result.Points.Add(new SeriesPoint { Argument = "C", Value = 30 });
            result.Points.Add(new SeriesPoint { Argument = "D", Value = 40 });
            result.Points.Add(new SeriesPoint { Argument = "E", Value = 50 });
            result.Points.Add(new SeriesPoint { Argument = "G", Value = 15 });

            XYDiagram2D.Series.Add(result);
        }
    }
}
```
