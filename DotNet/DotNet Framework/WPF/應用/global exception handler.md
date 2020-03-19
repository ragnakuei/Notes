# global exception handler

## 範例

主要就是透過 `Application.Current.DispatcherUnhandledException` 所給定的事件進行處理 !

```xml
<Application x:Class="WpfApp1.App"
             xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
             xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
             xmlns:local="clr-namespace:WpfApp1"
             Startup="Application_Startup"
             StartupUri="MainWindow.xaml">
    <Application.Resources>

    </Application.Resources>
</Application>
```

```csharp
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Threading;

namespace WpfApp1
{
    /// <summary>
    /// Interaction logic for App.xaml
    /// </summary>
    public partial class App : Application
    {
        private void Application_Startup(object sender, StartupEventArgs e)
        {
            // Global exception handling  
            Application.Current.DispatcherUnhandledException += new DispatcherUnhandledExceptionEventHandler(AppDispatcherUnhandledException);
        }

        void AppDispatcherUnhandledException(object sender, DispatcherUnhandledExceptionEventArgs e)
        {
            e.Handled = false;
            ShowUnhandledException(e);
        }

        void ShowUnhandledException(DispatcherUnhandledExceptionEventArgs e)
        {
            e.Handled = true;

            string errorMessage = $@"An application error occurred.
Please check whether your data is correct and repeat the action. If this error occurs again there seems to be a more serious malfunction in the application, and you better close it.
Error: { e.Exception.Message + e.Exception.InnerException?.Message }
            
Do you want to continue?
(if you click Yes you will continue with your work, if you click No the application will close)";

            var messageBoxResult = MessageBox.Show(errorMessage
                                                 , "Application Error"
                                                 , MessageBoxButton.YesNoCancel
                                                 , MessageBoxImage.Error);
            if (messageBoxResult == MessageBoxResult.No)
            {
                var message = @"WARNING: The application will close. Any changes will not be saved!
Do you really want to close it?";
                var confirmMessageBoxResult = MessageBox.Show(message
                                                            , "Close the application!"
                                                            , MessageBoxButton.YesNoCancel
                                                            , MessageBoxImage.Warning);
                if (confirmMessageBoxResult == MessageBoxResult.Yes)
                {
                    Application.Current.Shutdown();
                }
            }
        }
    }
}
```