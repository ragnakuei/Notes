# Custom Checkbox

```html
<h1>Custom Checkboxes</h1>
<div>
  <input id="box1" type="checkbox" />
  <label for="box1">Checkbox 1</label>
  <input id="box2" type="checkbox" />
  <label for="box2">Checkbox 2</label>
  <input id="box3" type="checkbox" />
  <label for="box3">Checkbox 3</label>
</div>
```

```css
@import url(//netdna.bootstrapcdn.com/font-awesome/3.2.1/css/font-awesome.css);

/*** basic styles ***/

body { margin: 30px; } 
h1 { font-size: 1.5em; }
label { font-size: 24px; }
div { 
  width: 175px; 
  margin-left: 20px;
}

/*** custom checkboxes ***/

input[type=checkbox] { display:none; } /* to hide the checkbox itself */
input[type=checkbox] + label:before {
  font-family: FontAwesome;
  display: inline-block;
}

input[type=checkbox] + label:before { content: "\f096"; } /* unchecked icon */
input[type=checkbox] + label:before { letter-spacing: 10px; } /* space between checkbox and label */

input[type=checkbox]:checked + label:before { content: "\f046"; } /* checked icon */
input[type=checkbox]:checked + label:before { letter-spacing: 6.5px; } /* allow space for check mark */
```