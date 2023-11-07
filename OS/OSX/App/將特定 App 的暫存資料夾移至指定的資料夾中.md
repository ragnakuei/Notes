# 將特定 App 的暫存資料夾移至指定的資料夾中

取消 symbolic link：
> unlink ~/Library/Caches/[target]

## script

```zsh
#!/bin/zsh

# key => source folder, value => destination folder
typeset -A folderMapping=(
"/Users/$USER/Library/Caches/com.microsoft.VSCode" "/Volumes/Transcend 1TB/Caches,com.microsoft.VSCode"
"/Users/$USER/Library/Caches/Microsoft Edge" "/Volumes/Transcend 1TB/Caches,Microsoft Edge"
"/Users/$USER/Library/Caches/BraveSoftware" "/Volumes/Transcend 1TB/Caches,BraveSoftware"
"/Users/$USER/Library/Caches/JetBrains" "/Volumes/Transcend 1TB/Caches,JetBrains"
"/Users/$USER/Library/Caches/Google" "/Volumes/Transcend 1TB/Caches,Google"
"/Users/$USER/Library/Application Support/Microsoft Edge" "/Volumes/Transcend 1TB/Application Support,Microsoft Edge"
"/Users/$USER/Library/Application Support/BraveSoftware" "/Volumes/Transcend 1TB/Application Support,BraveSoftware"
"/Users/$USER/Library/Application Support/JetBrains" "/Volumes/Transcend 1TB/Application Support,JetBrains"
"/Users/$USER/Library/Application Support/Google" "/Volumes/Transcend 1TB/Application Support,Google"
# Visual Studio Code
"/Users/$USER/Library/Application Support/Code" "/Volumes/Transcend 1TB/Application Support,Code"
)

for key val in "${(@kv)folderMapping}"; do
  # 以 , 拆開 val ( destination folder, folder name )
  destinationFolder=$(echo $val | cut -d ',' -f 1)
  folderName=$(echo $val | cut -d ',' -f 2)
  targetFolder="${destinationFolder}/${folderName}"

  echo "$key -> $targetFolder"
  
  # 如果 targetFolder 已經存在，則不執行
  if [[ ! -d "${targetFolder}" ]]; then
    echo "Creating ${targetFolder}"
    mkdir "${targetFolder}"

    echo "Moving ${key} to ${destinationFolder}"
    mv "$key" "$destinationFolder"
    if [[ $? -ne 0 ]]; then
      echo "移动失败" >&2
      exit 1
    fi

    echo "Creating symlink ${key} -> ${targetFolder}"
    ln -sf "${targetFolder}" "${key}"
  else
    echo "Directory ${targetFolder} already exists, skipping."
  fi

  echo " "
done

```

### 查出該 App 存取哪些檔案

1. 開啟 Active Monitor
1. 找到指定的 Process
1. 點選 Inspect selected process
1. 點選 Open Files and Ports

就可以看出該 Process 存取了哪些檔案 !

### Line

目前不支援
