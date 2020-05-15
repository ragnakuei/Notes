# 所有 Command 清單

目前測試，部份內建 Command 沒有明確的用途，只有 Mapping 的功能。

---

## 所有 Command

可以透過以下語法，列出所有 WPF 內建的 Command

```csharp
public string[] GetAllCommands()
{
    return (
                from assembly in AppDomain.CurrentDomain.GetAssemblies()
                from type in assembly.GetTypes()
                from prop in type.GetProperties()
                where
                    typeof(ICommand).IsAssignableFrom(prop.PropertyType) &&
                    prop.GetAccessors()[0].IsStatic
                orderby type.Name, prop.Name
                select type.Name + "." + prop.Name
            ).ToArray();
}
```

上述的執行結果如下:

| Command                                   | 說明                               |
| ----------------------------------------- | ---------------------------------- |
| ApplicationCommands.CancelPrint           |                                    |
| ApplicationCommands.Close                 | 關閉 Application 所產生的 Instance |
| ApplicationCommands.ContextMenu           |                                    |
| ApplicationCommands.Copy                  |                                    |
| ApplicationCommands.CorrectionList        |                                    |
| ApplicationCommands.Cut                   |                                    |
| ApplicationCommands.Delete                |                                    |
| ApplicationCommands.Find                  |                                    |
| ApplicationCommands.Help                  |                                    |
| ApplicationCommands.New                   |                                    |
| ApplicationCommands.NotACommand           |                                    |
| ApplicationCommands.Open                  |                                    |
| ApplicationCommands.Paste                 |                                    |
| ApplicationCommands.Print                 |                                    |
| ApplicationCommands.PrintPreview          |                                    |
| ApplicationCommands.Properties            |                                    |
| ApplicationCommands.Redo                  |                                    |
| ApplicationCommands.Replace               |                                    |
| ApplicationCommands.Save                  |                                    |
| ApplicationCommands.SaveAs                |                                    |
| ApplicationCommands.SelectAll             |                                    |
| ApplicationCommands.Stop                  |                                    |
| ApplicationCommands.Undo                  |                                    |
| ComponentCommands.ExtendSelectionDown     |                                    |
| ComponentCommands.ExtendSelectionLeft     |                                    |
| ComponentCommands.ExtendSelectionRight    |                                    |
| ComponentCommands.ExtendSelectionUp       |                                    |
| ComponentCommands.MoveDown                |                                    |
| ComponentCommands.MoveFocusBack           |                                    |
| ComponentCommands.MoveFocusDown           |                                    |
| ComponentCommands.MoveFocusForward        |                                    |
| ComponentCommands.MoveFocusPageDown       |                                    |
| ComponentCommands.MoveFocusPageUp         |                                    |
| ComponentCommands.MoveFocusUp             |                                    |
| ComponentCommands.MoveLeft                |                                    |
| ComponentCommands.MoveRight               |                                    |
| ComponentCommands.MoveToEnd               |                                    |
| ComponentCommands.MoveToHome              |                                    |
| ComponentCommands.MoveToPageDown          |                                    |
| ComponentCommands.MoveToPageUp            |                                    |
| ComponentCommands.MoveUp                  |                                    |
| ComponentCommands.ScrollByLine            |                                    |
| ComponentCommands.ScrollPageDown          |                                    |
| ComponentCommands.ScrollPageLeft          |                                    |
| ComponentCommands.ScrollPageRight         |                                    |
| ComponentCommands.ScrollPageUp            |                                    |
| ComponentCommands.SelectToEnd             |                                    |
| ComponentCommands.SelectToHome            |                                    |
| ComponentCommands.SelectToPageDown        |                                    |
| ComponentCommands.SelectToPageUp          |                                    |
| DataGrid.DeleteCommand                    |                                    |
| DataGrid.SelectAllCommand                 |                                    |
| DocumentViewer.FitToHeightCommand         |                                    |
| DocumentViewer.FitToMaxPagesAcrossCommand |                                    |
| DocumentViewer.FitToWidthCommand          |                                    |
| DocumentViewer.ViewThumbnailsCommand      |                                    |
| EditingCommands.AlignCenter               |                                    |
| EditingCommands.AlignJustify              |                                    |
| EditingCommands.AlignLeft                 |                                    |
| EditingCommands.AlignRight                |                                    |
| EditingCommands.Backspace                 |                                    |
| EditingCommands.CorrectSpellingError      |                                    |
| EditingCommands.DecreaseFontSize          |                                    |
| EditingCommands.DecreaseIndentation       |                                    |
| EditingCommands.Delete                    |                                    |
| EditingCommands.DeleteNextWord            |                                    |
| EditingCommands.DeletePreviousWord        |                                    |
| EditingCommands.EnterLineBreak            |                                    |
| EditingCommands.EnterParagraphBreak       |                                    |
| EditingCommands.IgnoreSpellingError       |                                    |
| EditingCommands.IncreaseFontSize          |                                    |
| EditingCommands.IncreaseIndentation       |                                    |
| EditingCommands.MoveDownByLine            |                                    |
| EditingCommands.MoveDownByPage            |                                    |
| EditingCommands.MoveDownByParagraph       |                                    |
| EditingCommands.MoveLeftByCharacter       |                                    |
| EditingCommands.MoveLeftByWord            |                                    |
| EditingCommands.MoveRightByCharacter      |                                    |
| EditingCommands.MoveRightByWord           |                                    |
| EditingCommands.MoveToDocumentEnd         |                                    |
| EditingCommands.MoveToDocumentStart       |                                    |
| EditingCommands.MoveToLineEnd             |                                    |
| EditingCommands.MoveToLineStart           |                                    |
| EditingCommands.MoveUpByLine              |                                    |
| EditingCommands.MoveUpByPage              |                                    |
| EditingCommands.MoveUpByParagraph         |                                    |
| EditingCommands.SelectDownByLine          |                                    |
| EditingCommands.SelectDownByPage          |                                    |
| EditingCommands.SelectDownByParagraph     |                                    |
| EditingCommands.SelectLeftByCharacter     |                                    |
| EditingCommands.SelectLeftByWord          |                                    |
| EditingCommands.SelectRightByCharacter    |                                    |
| EditingCommands.SelectRightByWord         |                                    |
| EditingCommands.SelectToDocumentEnd       |                                    |
| EditingCommands.SelectToDocumentStart     |                                    |
| EditingCommands.SelectToLineEnd           |                                    |
| EditingCommands.SelectToLineStart         |                                    |
| EditingCommands.SelectUpByLine            |                                    |
| EditingCommands.SelectUpByPage            |                                    |
| EditingCommands.SelectUpByParagraph       |                                    |
| EditingCommands.TabBackward               |                                    |
| EditingCommands.TabForward                |                                    |
| EditingCommands.ToggleBold                |                                    |
| EditingCommands.ToggleBullets             |                                    |
| EditingCommands.ToggleInsert              |                                    |
| EditingCommands.ToggleItalic              |                                    |
| EditingCommands.ToggleNumbering           |                                    |
| EditingCommands.ToggleSubscript           |                                    |
| EditingCommands.ToggleSuperscript         |                                    |
| EditingCommands.ToggleUnderline           |                                    |
| MediaCommands.BoostBass                   |                                    |
| MediaCommands.ChannelDown                 |                                    |
| MediaCommands.ChannelUp                   |                                    |
| MediaCommands.DecreaseBass                |                                    |
| MediaCommands.DecreaseMicrophoneVolume    |                                    |
| MediaCommands.DecreaseTreble              |                                    |
| MediaCommands.DecreaseVolume              |                                    |
| MediaCommands.FastForward                 |                                    |
| MediaCommands.IncreaseBass                |                                    |
| MediaCommands.IncreaseMicrophoneVolume    |                                    |
| MediaCommands.IncreaseTreble              |                                    |
| MediaCommands.IncreaseVolume              |                                    |
| MediaCommands.MuteMicrophoneVolume        |                                    |
| MediaCommands.MuteVolume                  |                                    |
| MediaCommands.NextTrack                   |                                    |
| MediaCommands.Pause                       |                                    |
| MediaCommands.Play                        |                                    |
| MediaCommands.PreviousTrack               |                                    |
| MediaCommands.Record                      |                                    |
| MediaCommands.Rewind                      |                                    |
| MediaCommands.Select                      |                                    |
| MediaCommands.Stop                        |                                    |
| MediaCommands.ToggleMicrophoneOnOff       |                                    |
| MediaCommands.TogglePlayPause             |                                    |
| NavigationCommands.BrowseBack             |                                    |
| NavigationCommands.BrowseForward          |                                    |
| NavigationCommands.BrowseHome             |                                    |
| NavigationCommands.BrowseStop             |                                    |
| NavigationCommands.DecreaseZoom           |                                    |
| NavigationCommands.Favorites              |                                    |
| NavigationCommands.FirstPage              |                                    |
| NavigationCommands.GoToPage               |                                    |
| NavigationCommands.IncreaseZoom           |                                    |
| NavigationCommands.LastPage               |                                    |
| NavigationCommands.NavigateJournal        |                                    |
| NavigationCommands.NextPage               |                                    |
| NavigationCommands.PreviousPage           |                                    |
| NavigationCommands.Refresh                |                                    |
| NavigationCommands.Search                 |                                    |
| NavigationCommands.Zoom                   |                                    |
| Slider.DecreaseLarge                      |                                    |
| Slider.DecreaseSmall                      |                                    |
| Slider.IncreaseLarge                      |                                    |
| Slider.IncreaseSmall                      |                                    |
| Slider.MaximizeValue                      |                                    |
| Slider.MinimizeValue                      |                                    |
| SystemCommands.CloseWindowCommand         |                                    |
| SystemCommands.MaximizeWindowCommand      |                                    |
| SystemCommands.MinimizeWindowCommand      |                                    |
| SystemCommands.RestoreWindowCommand       |                                    |
| SystemCommands.ShowSystemMenuCommand      |                                    |

相關資料

- [ApplicationCommand](https://docs.microsoft.com/zh-tw/dotnet/api/system.windows.input.applicationcommands)
