# [Github copilot](https://copilot.github.com/)

[Documentation](https://github.com/github/copilot-docs)

-   有各 IDE / Editor 的啟用教學

## Rider

| Action Name      | 作用             |
| ---------------- | ---------------- |
| Show Completions | 顯示 inline 建議 |

## Visual Studio Code

| Action Name               | 作用             |
| ------------------------- | ---------------- |
| Trigger inline Suggestion | 顯示 inline 建議 |

## Visual Studio

| Action Name                          | 作用             |
| ------------------------------------ | ---------------- |
| Edit.Copilot.TriggerinlineSuggestion | 顯示 inline 建議 |

## 疑難雜症

### 受限於區網 https 環境

錯誤訊息為

2023-12-22 08:24:09,281 [ 32688] WARN - #copilot - [ERROR] [Copilot Chat] [2023-12-22T00:24:09.279Z] Error on conversation request: (FetchError) self-signed certificate in certificate chain

相關討論

-   [self signed certificate in certificate chain on github copilot - Stack Overflow](https://stackoverflow.com/questions/71367058/self-signed-certificate-in-certificate-chain-on-github-copilot/75239728#75239728)
-   [GitHub CoPilot self-signed certificate error in Intellij | Siddharth Goel](https://sidd.io/2023/01/github-copilot-self-signed-cert-issue/)
-   [Troubleshooting network errors for GitHub Copilot - GitHub Docs](https://docs.github.com/en/copilot/troubleshooting-github-copilot/troubleshooting-network-errors-for-github-copilot#troubleshooting-certificate-related-errors)
-   https://docs.github.com/en/copilot/configuring-github-copilot/configuring-network-settings-for-github-copilot#configuring-proxy-settings-for-github-copilot

---

Visual Studio Code

-   安裝 extension win-ca
-   Settings > win-ca > Inject > 從 replace 改成 append
-   重新開啟 Visual Studio Code 就可以了 !

Rider

- 某次更新後，就正常了 !