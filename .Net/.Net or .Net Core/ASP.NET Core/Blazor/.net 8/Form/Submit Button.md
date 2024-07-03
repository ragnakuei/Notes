# Submit Button

button diabled binding 至 EditContext.Validate() 的好處

> 會促成每次 form 變更時，都進行 EditContext.Validate() 的動作 !
> 萬一有使用到一對多複雜資料結構時，就可以自動驗証 !

```cs
<button class="btn btn-primary"
        @* 下面這一樣 *@
        disabled="@(_isUploading || !_editContext.Validate())"
        type="submit" >
    Submit
</button>
```
