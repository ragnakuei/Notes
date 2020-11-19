# valdate

## 給定 custom validate error message

```html
<input type="text" id="username" 
        required 
        placeholder="Enter Name"
        oninvalid="this.setCustomValidity('Enter User Name Here')"
        oninput="this.setCustomValidity('')"  />
```