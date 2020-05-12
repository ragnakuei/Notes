# WindowsInput

- [WindowsInput](#windowsinput)
  - [IMouseSimulator](#imousesimulator)
  - [IKeyboardSimulator](#ikeyboardsimulator)

---

相依套件

> InputSimulator

---

## IMouseSimulator

- MoveMouseTo(x,y)

  座標要轉換才會轉成螢幕上面的

  > InputX = ScreenX \* 65535 / ResolutionX

  > InputY = ScreenY \* 65535 / ResolutionY

  例：在 1920 \* 1080 的螢幕上，要將游標移至 (960,540) 的位置

  ```csharp
  var x = 960 * 65535 / 1920;
  var y = 540 * 65535 / 1080;

  _inputSimulator.Mouse.MoveMouseTo(x, y);
  ```

---

## IKeyboardSimulator
