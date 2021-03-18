# NavigationWindow

- [NavigationWindow](#navigationwindow)
  - [範例](#%e7%af%84%e4%be%8b)
    - [MainPage](#mainpage)
    - [HomePage](#homepage)
    - [Step1](#step1)
    - [Step2](#step2)

---

最上層的控制項，裡面要放 Page 控制項

會根據使用者輸入，瀏覽至不同的內容。

---

## 範例

所有頁面的 .xaml.cs 沒有修改任何內容，就沒有列上來 !

### MainPage

```xml
<NavigationWindow x:Class="WpfApp14.MainPage"
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
        xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
        xmlns:local="clr-namespace:WpfApp14"
        mc:Ignorable="d"
        Title="Title"
        Source="Pages/HomePage.xaml"
        >
</NavigationWindow>
```

### HomePage

```xml
<Page x:Class="WpfApp14.Pages.HomePage"
      xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
      xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
      xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
      xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
      xmlns:local="clr-namespace:WpfApp14.Pages"
      mc:Ignorable="d"
      Title="HomePage">
    <StackPanel>
        <Label Content="HomePage" />
        <TextBlock>
            <Hyperlink NavigateUri="Step1.xaml">Step1</Hyperlink>
        </TextBlock>
    </StackPanel>
</Page>
```

### Step1

```xml
<Page x:Class="WpfApp14.Pages.Step1"
      xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
      xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
      xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
      xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
      xmlns:local="clr-namespace:WpfApp14.Pages"
      mc:Ignorable="d"
      Title="Step1">
    <StackPanel>
        <Label Content="Step1" />
        <TextBlock>
            <Hyperlink NavigateUri="Step2.xaml">Step2</Hyperlink>
        </TextBlock>
    </StackPanel>
</Page>
```

### Step2

```xml
<Page x:Class="WpfApp14.Pages.Step2_1"
      xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
      xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
      xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
      xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
      xmlns:local="clr-namespace:WpfApp14.Pages"
      mc:Ignorable="d"
      Title="Step2">
    <StackPanel>
        <Label Content="Step2" />
    </StackPanel>
</Page>

```
