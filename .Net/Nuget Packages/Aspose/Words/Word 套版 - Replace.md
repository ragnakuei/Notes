# Word 套版 - Replace


```csharp
class Program
{
    static void Main(string[] args)
    {
        ReplaceSample();
    }

    private static void ReplaceSample()
    {
        // 副檔名一定要正確，否則會判斷失敗

        var templateFile = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "docx", "ReplaceSample.docx");
        var outputFile = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "docx", "AfterReplaceSample.docx");

        if (File.Exists(outputFile))
        {
            File.Delete(outputFile);
        }

        var mergeFields = new Dictionary<string, string>
                          {
                              ["_fullName_"] = "Test",
                              ["_age_"]      = "18",
                          };

        var doc = new Document(templateFile);

        foreach (var field in mergeFields)
        {
            // 新版語法才支援 FindReplaceOptions
            doc.Range.Replace(field.Key, field.Value, new FindReplaceOptions
                                                      {
                                                          Direction          = FindReplaceDirection.Forward,
                                                          FindWholeWordsOnly = false,
                                                          IgnoreDeleted      = false,
                                                          IgnoreFields       = false,
                                                          IgnoreInserted     = false,
                                                          LegacyMode         = false,
                                                          MatchCase          = true,
                                                          ReplacingCallback  = null,
                                                          UseLegacyOrder     = false,
                                                          UseSubstitutions   = false
                                                      });

            // 舊版語法
            // doc.Range.Replace(field.Key, field.Value, isMatchCase: true, isMatchWholeWord: true);
        }

        doc.Save(outputFile);
    }
}
```
