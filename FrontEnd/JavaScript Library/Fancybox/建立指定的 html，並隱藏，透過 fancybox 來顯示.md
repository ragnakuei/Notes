# 建立指定的 html，並隱藏，透過 fancybox 來顯示


透過 data-src 以 selector 來指定要顯示為 lightbox 的內容

hidden lightbox 的內容，不需要與 data-src 的位置有關聯

```html
<div class="card">
    <div class="card-body">
      <p>#2 - Custom open/close animation</p>

      <p class="mb-0">
        <a data-fancybox 
						data-animation-duration="700" 
						data-src="#animatedModal" 
						href="javascript:;" 
						class="btn btn-primary">Open demo</a>
      </p>

      <div style="display: none;" id="animatedModal" class="animated-modal">
        <h2>Hello!</h2>
        <p>This is animated content! Cool, right?</p>
      </div>
    </div>
</div>
```