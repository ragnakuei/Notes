# 情境一：在 WSL Ubuntu 想要使用 Claude Code，但遇到 `SELF_SIGNED_CERT_IN_CHAIN` 問題

執行 Claude Code 後，出現以錯誤訊息

```
Unable to connect to Anthropic services

Failed to connect to console.anthropic.com: SELF_SIGNED_CERT_IN_CHAIN

Please check your internet connection and network settings.

Note: Claude Code might not be available in your country. Check supported countries at
https://anthropic.com/supported-countries
```

## 常見的不安全的解法：

-   在 Windows 的環境變數中，新增 `NODE_TLS_REJECT_UNAUTHORIZED` 並設定為 `0`
-   在 WSL Ubuntu 中，新增 `NODE_TLS_REJECT_UNAUTHORIZED` 並設定為 `0`

    ```bash
    export NODE_TLS_REJECT_UNAUTHORIZED=0
    ```

    執行後，雖然看似可以執行，但會出現以下警告訊息：

    ```
    (node:389) Warning: Setting the NODE_TLS_REJECT_UNAUTHORIZED environment variable to '0' makes TLS connections and HTTPS requests insecure by disabling certificate verification.
    (Use `node --trace-warnings ...` to show where the warning was created)
    ```

    如果擔心封包內容被竊聽，還要尋找其他方法來解決。

---

## 安全的解法：

先參考 [ChatGPT 的建議](#chatgpt-的建議

### ChatGPT 的建議

在 WSL Ubuntu 中解決 `SELF_SIGNED_CERT_IN_CHAIN` 問題的穩妥方式，是從 **Windows** 端導出內部的自簽或公司內網 CA 證書，並將其新增到 Ubuntu 的憑證信任庫中，而不是關閉驗證。以下是推薦流程：

#### 🧩 步驟一：從 Windows 導出公司 CA 證書

1. 使用 `certmgr.msc` 或瀏覽器，找到對應的根 CA 證書（MITM proxy 如 Blue Coat、Zscaler…等）。
2. 導出為 `.cer` 或 `.crt`（Base‑64 編碼格式）。

_這個流程在 Chrome 或 Edge 都可以做到_ ([stackoverflow.com][1], [kontext.tech][2])。

#### 🧱 步驟二：將證書傳到 WSL 並轉成 PEM

假設你將 `company-ca.crt` 放到 Windows 路徑 `C:\Users\You\company-ca.crt`，在 Ubuntu 執行：

```bash
sudo apt update && sudo apt install -y ca-certificates
sudo cp /mnt/c/Users/You/company-ca.crt /usr/local/share/ca-certificates/
```

若是 DER 格式，可轉為 PEM：

```bash
sudo openssl x509 -inform der -in /mnt/c/Users/You/company-ca.cer -out /usr/local/share/ca-certificates/company-ca.crt
```

#### 🔐 步驟三：更新信任庫

在 Ubuntu 執行：

```bash
sudo update-ca-certificates
```

這會將 `.crt` 合併進 `/etc/ssl/certs/ca-certificates.crt`，使系統信任這些憑證 。

測試：

```bash
curl https://api.anthropic.com
```

這應該不再出現報錯。

#### 🌐 步驟四：Node.js／npm 的額外信任（如需）

有時候 Node.js 或 npm 還會拒絕連線，但可以透過以下方式指定額外憑證：

```bash
export NODE_EXTRA_CA_CERTS=/usr/local/share/ca-certificates/company-ca.crt
```

或者設定 npm：

```bash
npm config set cafile "/usr/local/share/ca-certificates/company-ca.crt"
```

這會讓它們使用這份證書檔來驗證憑證簽發鏈 ([stackoverflow.com][4])。

##### ✅ 最佳化整體安全架構比較：

| 方法                             | 限制作用              | 風險                           |
| -------------------------------- | --------------------- | ------------------------------ |
| `NODE_TLS_REJECT_UNAUTHORIZED=0` | 全部忽略 TLS 驗證     | TLS 完全關閉，可能被 MITM 攻擊 |
| 導入公司 CA 到 Ubuntu            | 正確信任內部憑證      | 無，安全方式                   |
| 結合 VPN 使用                    | 保護本地到 VPN 的流量 | 仍需正確 TLS 驗證遠端服務      |

#### 📋 最終建議（WSL Ubuntu 特殊流程）

1. 在 Windows 上導出公司根 CA 證書。
2. copy 至 WSL Ubuntu，放在 `/usr/local/share/ca-certificates/`。
3. 執行 `sudo update-ca-certificates`。
4. 若跑 Node.js/nmp 還有錯，額外設 `NODE_EXTRA_CA_CERTS` 或 `npm config set cafile`。
5. *不要*全局關閉 TLS 驗證（`NODE_TLS_REJECT_UNAUTHORIZED=0`），這是最不安全的方式。

透過上述流程，即可讓 WSL Ubuntu 正確接受內網的 MITM 憑證，且保持整體連線的安全性。不只 Curl、apt，可套用於整個 Node.js 生態系。

[1]: https://stackoverflow.com/questions/34498736/npm-self-signed-cert-in-chain?utm_source=chatgpt.com 'NPM self_signed_cert_in_chain - node.js - Stack Overflow'
[2]: https://kontext.tech/article/1065/docker-with-wsl-2-ssl-proxy-and-ssl-certificate-problem?utm_source=chatgpt.com 'Docker with WSL 2, SSL Proxy and SSL Certificate Problem - Kontext'
[3]: https://documentation.ubuntu.com/server/how-to/security/install-a-root-ca-certificate-in-the-trust-store/?utm_source=chatgpt.com 'Install a root CA certificate in the trust store - Ubuntu documentation'
[4]: https://stackoverflow.com/questions/29283040/how-to-add-custom-certificate-authority-ca-to-nodejs?utm_source=chatgpt.com 'How to add custom certificate authority (CA) to nodejs - Stack Overflow'

---

詳細的安全解法如下：

1. windows 系統內，執行 `certmgr.msc`
    1. 移至 憑證 - 目前的使用者 > 受信任的根憑證授權單位 > 憑證
    1. 找出屬於公司內網限制的 CA 根憑證
        1. 滑鼠右鍵 > 所有工作 > 匯出
        1. 選擇「Base‑64 編碼 X.509 (.CER)」格式
        1. 儲存為 `company-ca.cer`
    1. 將 `company-ca.cer` 檔案複製到 WSL Ubuntu 的 `/usr/local/share/ca-certificates/` 目錄下
        ```bash
        sudo cp /mnt/c/Users/[You]/Desktop/company-ca.cer /usr/local/share/ca-certificates/company-ca.crt
        ```
1. 在 WSL Ubuntu 中，執行以下指令：
    ```bash
    sudo apt update && sudo apt install -y ca-certificates
    sudo update-ca-certificates
    ```

    要看到這個訊息，才代表有新增憑證：
    ```
    Updating certificates in /etc/ssl/certs...
    1 added, 0 removed; done.
    Running hooks in /etc/ca-certificates/update.d...
    done.
    ```
