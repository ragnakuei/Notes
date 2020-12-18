# valdate

## 給定 custom validate error message

```html
<input type="text" id="username" 
        required 
        placeholder="Enter Name"
        oninvalid="this.setCustomValidity('Enter User Name Here')"
        oninput="this.setCustomValidity('')"  />
```

## 手動指定

```html
<form>
  <p>
    <label>單價</label>
    <input id="UnitPrice" type="number" required min="0" />
  </p>
  <p>
    <input type="submit" value="Submit" />
  </p>
</form>
```

```js
const unitPrice = document.getElementById("UnitPrice");

unitPrice.addEventListener("input", function (event) {
  if (unitPrice.validity.rangeUnderflow) 
  {
    unitPrice.setCustomValidity("輸入單價太低");
  }
  else if (unitPrice.validity.rangeOverflow) 
  {
    unitPrice.setCustomValidity("輸入單價太高");
  } 
  else if (unitPrice.validity.valueMissing) 
  {
    unitPrice.setCustomValidity("請輸入單價");
  } 
  else 
  {
    unitPrice.setCustomValidity("");
  }
});
```
