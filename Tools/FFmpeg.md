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

### ts 併檔

用下載軟體，把 m3u8 內的檔案清單下載下來後，就可以用這個方式來併檔

但不要用來併 mp4 檔案 !

#### 避免 reencode

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

#### concat protocol

```
ffmpeg -i "concat:01.mp4|02.mp4|03.mp4|04.mp4" -c copy output.mp4
```

#### concat video filter

```
ffmpeg -i 01.mp4 -i 02.mp4 -i 03.mp4 -filter_complex "[0:v] [0:a] [1:v] [1:a] [2:v] [2:a] concat=n=3:v=1:a=1 [v] [a]" -map "[v]" -map "[a]" output.mp4
```