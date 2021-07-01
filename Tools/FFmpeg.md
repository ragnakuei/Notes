# ffmpeg

## windows

至 https://github.com/BtbN/FFmpeg-Builds/releases

下載 ffmpeg-xxx-win64-lgpl.zip

### m3u8

準備好 m3u8 檔案

- 要先把各檔案路徑改成絕對路徑

```
ffmpeg.exe -protocol_whitelist crypto,file,http,https,tcp,tls -i index.m3u8 -c copy video.mp4
```

檔案可能會放在以下路徑，也可能會在同目錄下

```
C:\VTRoot\HarddiskVolume6\ffmpeg\bin\
```

### mp4 併檔

建立一個檔案 merge.txt

把影片順序給依序放上去，每個影片一列，每列以 file 開頭

檔名如有特殊符號，要額外處理 !

例：

```
file 1.mp4
file 2.mp4
file 3.mp4
```


```
ffmpeg -f concat -safe 0 -i merge.txt -c copy output.mp4
```
