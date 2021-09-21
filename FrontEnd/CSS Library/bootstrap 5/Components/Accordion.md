# [Accordion](https://getbootstrap.com/docs/5.0/components/accordion/)

| class 差異   | 展開 | 收合      |
| ------------ | ---- | --------- |
| button class | 無   | collapsed |
| body class   | show | 無        |

```html
<div class="accordion" id="accordionPanelsStayOpenExample">
    <!-- 展開 -->
    <div class="accordion-item">
        <h2 class="accordion-header" id="panelsStayOpen-headingOne">
            <button
                class="accordion-button"
                type="button"
                data-bs-toggle="collapse"
                data-bs-target="#panelsStayOpen-collapseOne"
                aria-expanded="true"
                aria-controls="panelsStayOpen-collapseOne"
            >
                Title 1
            </button>
        </h2>
        <div
            id="panelsStayOpen-collapseOne"
            class="accordion-collapse collapse show"
            aria-labelledby="panelsStayOpen-headingOne"
        >
            <div class="accordion-body">Content 1</div>
        </div>
    </div>

    <!-- 收合 -->
    <div class="accordion-item">
        <h2 class="accordion-header" id="panelsStayOpen-headingTwo">
            <button
                class="accordion-button collapsed"
                type="button"
                data-bs-toggle="collapse"
                data-bs-target="#panelsStayOpen-collapseTwo"
                aria-expanded="true"
                aria-controls="panelsStayOpen-collapseTwo"
            >
                Title 2
            </button>
        </h2>
        <div
            id="panelsStayOpen-collapseTwo"
            class="accordion-collapse collapse"
            aria-labelledby="panelsStayOpen-headingTwo"
        >
            <div class="accordion-body">Content 2</div>
        </div>
    </div>
</div>
```
