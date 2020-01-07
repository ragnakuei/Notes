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

  > InputX = ScreenX * 65535 / ResolutionX
  
  > InputY = ScreenY * 65535 / ResolutionY

---

## IKeyboardSimulator
