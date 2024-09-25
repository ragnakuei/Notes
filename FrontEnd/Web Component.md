# [Web Component](https://developer.mozilla.org/en-US/docs/Web/Web_Components/Using_custom_elements)

### 前置知識

#### constructor

可以用來初始化元素，但是不要在這裡做 DOM 操作。

#### connectedCallback

[這邊](https://developer.mozilla.org/en-US/docs/Web/API/Web_components/Using_custom_elements#custom_element_lifecycle_callbacks)提到，建議在 connectedCallback 中做初始化設定，包含 DOM 操作。

#### 初始化的極端情況比對
1. 先引用 web component js 
   \> 在 html 中 render web component tag

   這種情況下，只能在 connectedCallback 中進行初始化，因為 constructor 會先執行，但是此時還沒有 render 到 html 中，所以無法進行 DOM 操作。

1. 先在 html render web component tag ( 因該 web component js 還沒引用，所以不會有任何效果 )
   \> 再引用 web component js

    這種情況下，可以在 constructor 或 connectedCallback 中進行初始化，因為此時已經 render 到 html 中。 (但是不建議)

總而言之，為了統一做法，在 connectedCallback 中進行初始化是比較好的選擇，也符合官方建議。


### 注意事項

1. 使用 custom event 時，不要使用原生的 event name，例如 `submit`，會造成額外的問題，例： dispatchEvent 一次，但是會觸發兩次。