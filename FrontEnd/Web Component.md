# [Web Component](https://developer.mozilla.org/en-US/docs/Web/Web_Components/Using_custom_elements)

### 注意事項

1. 使用 custom event 時，不要使用原生的 event name，例如 `submit`，會造成額外的問題，例： dispatchEvent 一次，但是會觸發兩次。