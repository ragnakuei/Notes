# DockingDocumentUIService

用來產生 DocumentPanel 的 Service

---

## 透過 Service 產生 DocumentPanel

- 註冊 DockingDocumentUIService 的地方是要在 DocumentGroup 中

- MainView

    ```xml
    <UserControl x:Class="WpfApp8.Main.MainView"
                xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
                xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
                xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
                xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
                xmlns:local="clr-namespace:WpfApp8.Main"
                xmlns:dxb="http://schemas.devexpress.com/winfx/2008/xaml/bars"
                xmlns:dxdo="http://schemas.devexpress.com/winfx/2008/xaml/docking"
                xmlns:dxmvvm="http://schemas.devexpress.com/winfx/2008/xaml/mvvm"
                mc:Ignorable="d"
                d:DesignHeight="450" d:DesignWidth="800">
        <UserControl.DataContext>
            <local:MainViewModel />
        </UserControl.DataContext>
        <DockPanel>
            <!-- DockPanel 工具列 -->
            <dxb:MainMenuControl DockPanel.Dock="Top">
                <dxb:MainMenuControl.Items>
                    <dxb:BarButtonItem Content="New Root Document" Command="{Binding OpenDocumentCommand}" />
                </dxb:MainMenuControl.Items>
            </dxb:MainMenuControl>

            <!-- DockPanel 內的 Layout -->
            <dxdo:DockLayoutManager>
                <dxdo:LayoutGroup Caption="LayoutRoot">
                    <dxdo:DocumentGroup x:Name="documentGroup" DestroyOnClosingChildren="False">
                        <!-- DockingDocumentUIService 一定要放在這裡面 -->
                        <!-- 在 ViewModel 內就可以透過這個 Service 來新增 DocumentPanel -->
                        <dxmvvm:Interaction.Behaviors>
                            <dxdo:DockingDocumentUIService/>
                        </dxmvvm:Interaction.Behaviors>

                        <!-- 這裡可以放 DocumentPanel -->

                    </dxdo:DocumentGroup>
                </dxdo:LayoutGroup>
            </dxdo:DockLayoutManager>
        </DockPanel>
    </UserControl>
    ```

    DocumentManagerService.CreateDocument() 第一個 argument 要放入 View 的 Type Name

    ```csharp
    public class MainViewModel : ViewModelBase
    {
        private IDocumentManagerService DocumentManagerService => GetService<IDocumentManagerService>();

        public MainViewModel()
        {
            OpenDocumentCommand = new DelegateCommand(OpenDocumentCommandExecute);
        }
        public ICommand OpenDocumentCommand { get; set; }

        private void OpenDocumentCommandExecute()
        {
            var document = DocumentManagerService.CreateDocument(nameof(View01), null, this);
            document.Id = "Document" + Guid.NewGuid().ToString().Replace("-", "");
            document.DestroyOnClose = false;
            document.Title = "Root Document";

            // Content 可以取出該 ViewModel 的 DataContext
            // (document.Content as View01ViewModel).State = new ViewModelState { State = "Root" };

            document.Show();
        }

    }
    ```

- DocumentView


```xml

```

```csharp

```
