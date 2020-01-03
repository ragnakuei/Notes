# [ViewModels 間傳遞參數](https://documentation.devexpress.com/WPF/17448/MVVM-Framework/View-Models/Passing-Data-Between-ViewModels-ISupportParameter)

二種方式

- [Event](../../MVVM/ViewModels%20間傳遞參數.md#Event)
- [Parameter](#parameter)

---

## Parameter

- 一定要給定外層控制項的 Element
- Binding 時，指定外層控制項的 DataContext 或是 DataContext.Property

  ```xml
  <Grid Name="LayoutRoot">
      <iChildView:IChildAView x:Name="ChildAView" Grid.Column="0" Grid.Row="1"
                                      dxmvvm:ViewModelExtensions.Parameter="{Binding DataContext.TextBoxValue, ElementName=LayoutRoot }"/>
  </Grid>
  ```

  - Overrider `void OnParameterChanged(object parameter)` - 此 Method 是 Parameter Changed Callback Method

  ```csharp
  public class IChildAViewModel : ViewModelBase
  {
      public IChildAViewModel()
      {
      }

      private string _textBoxValue;

      public string TextBoxValue
      {
          get => _textBoxValue;
          set
          {
              SetValue(ref _textBoxValue, value, nameof(TextBoxValue));
          }
      }

      protected override void OnParameterChanged(object parameter)
      {
          base.OnParameterChanged(parameter);
          if (parameter?.ToString() != null)
          {
              TextBoxValue = parameter.ToString();
          }
      }
  }
  ```
