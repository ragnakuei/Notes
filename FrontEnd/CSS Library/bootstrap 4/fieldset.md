# fieldset

## 範例一

```html
<style>
    fieldset.scheduler-border {
        border: 1px solid #ddd !important;
        padding: 0 1.4em 1.4em 1.4em !important;
        margin: 0 0 1.5em 0 !important;
        -webkit-box-shadow:  0px 0px 0px 0px #000;
                box-shadow:  0px 0px 0px 0px #000;

        border-radius: .25rem;
    }

    legend.scheduler-border {
        font-size: 1.2em !important;
        font-weight: bold !important;
        text-align: left !important;
        width:auto;
        padding:0 10px;
        border-bottom:none;
    }
</style>

<fieldset class="scheduler-border">
    <legend class="scheduler-border">搜尋</legend>
    <form class="form-inline control-group">

        <div class="form-group mx-3">
            <label for="searchTitle">標題</label>
            <input id="searchTitle"
                    class="form-control mx-sm-3"
                    aria-describedby="passwordHelpInline">
        </div>

        <div class="form-group mx-3">
            <button type="submit"
                    class="btn btn-primary">
                Submit
            </button>
        </div>
    </form>
</fieldset>
```