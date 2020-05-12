# DependencyProperty

- [DependencyProperty](#dependencyproperty)
  - [CustomButton 增加 DependencyProperty 的方式](#custombutton-%e5%a2%9e%e5%8a%a0-dependencyproperty-%e7%9a%84%e6%96%b9%e5%bc%8f)
  - [透過 Code 給定 UIElement 的 DependencyProperty 的方式](#%e9%80%8f%e9%81%8e-code-%e7%b5%a6%e5%ae%9a-uielement-%e7%9a%84-dependencyproperty-%e7%9a%84%e6%96%b9%e5%bc%8f)

---

在 MVVM 架構下

---

## CustomButton 增加 DependencyProperty 的方式

延續 [Button](../DevExpress/Behavior.md/EventArgsConverter.md#Button) 的範例

- CustomButton

    ```c#
    public class CustomButton : Button
    {
        public int CustomParameterInt { get; set; }
        public string CustomParameterString { get; set; }

        public static readonly DependencyProperty TestListBoxProperty
            = DependencyProperty.Register(nameof(TestListBox)
                , typeof(ListBox)
                , typeof(CustomButton)
                , new FrameworkPropertyMetadata(null,
                        FrameworkPropertyMetadataOptions.AffectsRender,
                        new PropertyChangedCallback(ChangeListBox)
            ));

        private static void ChangeListBox(DependencyObject d, DependencyPropertyChangedEventArgs e)
        {
        }

        public ListBox TestListBox
        {
            get { return (ListBox)this.GetValue(TestListBoxProperty); }
            set { this.SetValue(TestListBoxProperty, (object)value); }
        }
    }
    ```

- View

    ```xml
    <ListBox x:Name="list" ItemsSource="{Binding Persons}" Grid.Row="1">
        <dxmvvm:Interaction.Behaviors>
            <dxmvvm:EventToCommand EventName="MouseLeftButtonUp" Command="{Binding EditCommand}" ModifierKeys="Ctrl">
                <dxmvvm:EventToCommand.EventArgsConverter>
                    <Common:ListBoxEventArgsConverter />
                </dxmvvm:EventToCommand.EventArgsConverter>
            </dxmvvm:EventToCommand>
            <dxmvvm:KeyToCommand Command="{Binding EditCommand}" KeyGesture="Ctrl+Enter" CommandParameter="{Binding ElementName=list, Path=SelectedItem}" />
        </dxmvvm:Interaction.Behaviors>
        <ListBox.ItemTemplate>
            <DataTemplate>
                <TextBlock>
                    <Run Text="{Binding FirstName}" /> <Run Text="{Binding LastName}" />
                </TextBlock>
            </DataTemplate>
        </ListBox.ItemTemplate>
    </ListBox>
    <ViewModel:CustomButton
                Content="Click"
                Grid.Row="2"
                CustomParameterInt="1"
                TestListBox="{Binding ElementName=list}"
                CustomParameterString="A">  
        <dxmvvm:Interaction.Behaviors>
            <dxmvvm:EventToCommand EventName="Click"
                            PassEventArgsToCommand="True"
                            CommandTarget="{Binding ElementName=list}"
                            Command="{Binding ClickBtnCommand}">
                <dxmvvm:EventToCommand.EventArgsConverter>
                    <Common:ButtonEventArgsConverter />
                </dxmvvm:EventToCommand.EventArgsConverter>
            </dxmvvm:EventToCommand>
        </dxmvvm:Interaction.Behaviors>
    </ViewModel:CustomButton>
    ```

- ViewModel

    可在這邊下 BreakPoint 來看 sender 的內容

    ```c#
    public class ButtonEventArgsConverter : EventArgsConverterBase<RoutedEventArgs>
    {
        protected override object Convert(object sender, RoutedEventArgs argsObj)
        {
            var button = sender as CustomButton;

            return new
            {
                Id = button.CustomParameterInt,
                Name = button.CustomParameterString
            };
        }
    }
    ```

## 透過 Code 給定 UIElement 的 DependencyProperty 的方式

透過 `DependencyObject.SetValue(DependencyProperty, object)` 就可以了

```csharp
this.SetValue(BarManager.DXContextMenuProperty, popupMenu);

var barButtonItem = new BarButtonItem
{
    Content = "A"
};

popupMenu.Items.Add(barButtonItem);
popupMenu.ShowPopup(this);
```