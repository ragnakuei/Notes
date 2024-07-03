# ref

- binding template 內的 component 為 code 內的變數 !
- 要在 OnAfterRender() / OnAfterRenderAsync() 才會 binding 完成 !

```cs
@page "/reference-parent-1"

<button @onclick="@(() => childComponent?.ChildMethod(5))">
    Call <code>ReferenceChild.ChildMethod</code> with an argument of 5
</button>

<ReferenceChild @ref="childComponent" />

@code {
    private ReferenceChild? childComponent;
}
```