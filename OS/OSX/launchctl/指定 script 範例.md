# 指定 script 範例

launchctl 有以下二種 legacy subcommands：
- load
- unload

用來指定 script，範例如下：

```zsh
# 指定 script
launchctl load ~/Library/LaunchAgents/com.user.startup.plist
```

```zsh
# 移除 script
launchctl unload ~/Library/LaunchAgents/com.user.shutdown.plist
```

注意事項：
- StandardErrorPath
  - 不可使用 $HOME
- StandardOutPath
  - 不可使用 $HOME


startup.plist 範例：

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple Computer//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
  <dict>
    <key>Label</key>
    <string>com.user.startup</string>
    <key>ProgramArguments</key>
    <array>
      <string>sh</string>
      <string>-c</string>
      <string>"$HOME/.config/startup.sh"</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
  </dict>
</plist>
```


### 相關範例s

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
	<dict>
		<key>EnvironmentVariables</key>
		<dict>
			<key>PATH</key>
			<string>/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/bin/zsh</string>
		</dict>
		<key>Label</key>
		<string>com.test</string>
		<key>ProgramArguments</key>
		<array>
			<string>sh</string>
			<string>-c</string>
			<string>"$HOME/mkdir.sh"</string>
		</array>
		<key>RunAtLoad</key>
		<true/>
		<key>StandardErrorPath</key>
		<string>/Users/kuei/logs/test.err</string>
		<key>StandardOutPath</key>
		<string>/Users/kuei/logs/test.out</string>
	</dict>
</plist>
```
