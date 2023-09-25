# 取得 slot 內的 controls

目前測試狀況來說，每個情境下做法會有些差異 !!

### 範例一

```js
this.shadowRoot = this.attachShadow({mode: "open"})

const slot = this.shadowRoot.querySelector('slot');
const slotNodes = slot
    .assignedNodes()
    .filter((node) => node.nodeType === Node.ELEMENT_NODE);
// 因為 slot tag 中，有效的 dom 只會有一個，所以直接取第一個

this._tabbableElements = this.findTabbableElements(slotNodes[0]);

findTabbableElements = (targetElement) => {

//-------------------------------------------------

function findChildrenTabbableElements(element) {
    
    const children = element.children;
    if(children?.length >= 0 === false) {
        return [];
    }

    const tabbableControls = [];
    
    for (let child of children) {
        
        const tabIndex = child.getAttribute('tabindex');
        if (tabIndex !== null || child.tabIndex >= 0) {
            // console.log('with tabIndex Control', child);
            tabbableControls.push(child);
        }
        
        const childTabbableControls = findChildrenTabbableElements(child);
        tabbableControls.push(...childTabbableControls);
    }
    
    return tabbableControls;
}

const result = findChildrenTabbableElements(targetElement);

return result;
}

```
