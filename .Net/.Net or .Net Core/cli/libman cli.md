# libman cli

參考資料

-   [libman cli](https://learn.microsoft.com/zh-tw/aspnet/core/client-side/libman/libman-cli)

```bash
dotnet tool install -g Microsoft.Web.LibraryManager.Cli
```

安裝完畢後還要執行

```bash
sudo ln -s ~/.dotnet/tools/libman /usr/local/bin/libman
```

### 在 osx arm64 安裝

```bash
dotnet tool install -g Microsoft.Web.LibraryManager.Cli -a arm64
```

如果不指定 -a arm64，會以 x64 的 arch 來安裝，而導致 libman cli 無法被執行

而 libman 會讀取 env DOTNET_ROOT
必要時，可以在 ~/.zshrc 加上

```bash
export DOTNET_ROOT='/usr/local/share/dotnet'
```

上述的路徑可以在安裝完 dotnet sdk / dotnet cli 後，透過 which dotnet 得知 !
