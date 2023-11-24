# Ramdisk

### Startup.sh

```zsh
#!/bin/zsh

# ramdisk 容量，單位 GB
ramdisk_size=32

# ramdisk 名稱
ramdisk_name="Ramdisk"

# 如果 ramdisk 已經存在，則不執行
if [[ ! -d "/Volumes/${ramdisk_name}" ]]; then
  echo "Creating ramdisk ${ramdisk_name}"
  diskutil erasevolume APFS "${ramdisk_name}" `hdiutil attach -nomount ram://$((ramdisk_size * 1024 * 1024 * 1024 / 512))`
else
  echo "Directory /Volumes/${ramdisk_name} already exists, skipping."
fi

# 需要複製至 ramdisk 的資料夾清單
typeset -A folderList=(
    "/Users/$USER/Documents/Parallels Desktop/Ubuntu Linux 22.04.pvm" "Parallels Desktop"
    "/Users/$USER/Documents/Parallels Desktop/test.rtf" "Parallels Desktop"
)

# 複製資料夾
for key val in "${(@kv)folderList}"; do
  echo "Change current directory to /Volumns/${ramdisk_name}"
  cd "/Volumes/${ramdisk_name}"

  echo "Creating ${val}"
  mkdir -p "${val}"

  echo "Copying ${key} to ${val}"
  cp -R "${key}" "${val}"
done
```

### Shutdown.sh

```zsh
#!/bin/zsh

# ramdisk 名稱
ramdisk_name="Ramdisk"

# 需要複製至原本資料夾清單
typeset -A folderList=(
    "/Volumes/${ramdisk_name}/Parallels Desktop/Ubuntu Linux 22.04.pvm" "/Users/$USER/Documents/Parallels Desktop"
    "/Volumes/${ramdisk_name}/Parallels Desktop/test.rtf" "/Users/$USER/Documents/Parallels Desktop"
)

# 複製資料夾
for key val in "${(@kv)folderList}"; do
  echo "Copying ${key} to ${val}"
  cp -R "${key}" "${val}"
done

# 移除 ramdisk
diskutil unmount force "/Volumes/${ramdisk_name}"
```

### LaunchAgent.plist

路徑： $HOME/Library/LaunchAgents/com.ramdisk.scripts.plist

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
  <dict>
    <key>Label</key>
    <string>com.ramdisk.scripts</string>

    <key>ProgramArguments</key>
    <array>
      <string>sh</string>
      <string>-c</string>
      <string>"$HOME/Library/Ramdisk/Startup.sh"</string>
    </array>

    <key>RunAtLoad</key>
    <true/>
    <key>StandardErrorPath</key>
    <string>$HOME/logs/com.ramdisk.error.log</string>
    <key>StandardOutPath</key>
    <string>$HOME/logs/com.ramdisk.output.log</string>

    <key>KeepAlive</key>
    <dict>
      <key>SuccessfulExit</key>
      <false/>
    </dict>

    <key>ExitTimeOut</key>
    <integer>3</integer>

    <key>ProgramArguments</key>
    <array>
      <string>sh</string>
      <string>-c</string>
      <string>"$HOME/Library/Ramdisk/Shutdown.sh"</string>
    </array>

  </dict>
</plist>
```


```sh
launchctl load com.ramdisk.scripts.plist
launchctl list | grep com.ramdisk.scripts
launchctl unload com.ramdisk.scripts.plist
```