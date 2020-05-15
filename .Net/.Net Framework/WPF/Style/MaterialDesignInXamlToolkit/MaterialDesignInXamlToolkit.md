# [MaterialDesignInXamlToolkit](https://github.com/MaterialDesignInXAML/MaterialDesignInXamlToolkit)

- [MaterialDesignInXamlToolkit](#materialdesigninxamltoolkit)
  - [wiki](#wiki)
  - [套用方式](#%e5%a5%97%e7%94%a8%e6%96%b9%e5%bc%8f)
  - [Style 清單](#style-%e6%b8%85%e5%96%ae)
  - [範例](#%e7%af%84%e4%be%8b)

---

Material Design 套件

---

## [wiki](https://github.com/MaterialDesignInXAML/MaterialDesignInXamlToolkit/wiki)

可以參考右邊目錄

## 套用方式

App.xaml Application.Resources 中，新增以下語法

```xml
<ResourceDictionary>
    <ResourceDictionary.MergedDictionaries>
        <ResourceDictionary Source="pack://application:,,,/MaterialDesignThemes.Wpf;component/Themes/MaterialDesignTheme.Light.xaml" />
        <ResourceDictionary Source="pack://application:,,,/MaterialDesignThemes.Wpf;component/Themes/MaterialDesignTheme.Defaults.xaml" />
        <ResourceDictionary Source="pack://application:,,,/MaterialDesignColors;component/Themes/Recommended/Primary/MaterialDesignColor.DeepPurple.xaml" />
        <ResourceDictionary Source="pack://application:,,,/MaterialDesignColors;component/Themes/Recommended/Accent/MaterialDesignColor.Lime.xaml" />
    </ResourceDictionary.MergedDictionaries>
</ResourceDictionary>
```

在要套用的 xaml 新增以下語法

```xml
<Window ....

        xmlns:materialDesign="http://materialdesigninxaml.net/winfx/xaml/themes"
        TextElement.Foreground="{DynamicResource MaterialDesignBody}"
        TextElement.FontWeight="Regular"
        TextElement.FontSize="13"
        TextOptions.TextFormattingMode="Ideal"
        TextOptions.TextRenderingMode="Auto"
        Background="{DynamicResource MaterialDesignPaper}"
        FontFamily="{DynamicResource MaterialDesignFont}"
        >
    <Grid>
        <materialDesign:Card Padding="32" Margin="16">
            <TextBlock Style="{DynamicResource MaterialDesignTitleTextBlock}">My First Material Design App</TextBlock>
        </materialDesign:Card>
    </Grid>
</Window>

```

## [Style 清單](https://github.com/MaterialDesignInXAML/MaterialDesignInXamlToolkit/wiki/ControlStyleList)

---

## [範例](https://github.com/Keboo/MaterialDesignInXaml.Examples)
