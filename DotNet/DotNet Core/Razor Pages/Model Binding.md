# Model Binding



有三個方式


--

## 透過引數

```csharp

```

## 透過 Attribute BindProperty

```csharp

```

## 透過 Request.Form

```csharp

```

## Validation

```csharp
public class Validation : PageModel
{
    [BindProperty]
    [Required]
    [MinLength( 6)]
    public string Name { get; set; }

    public void OnGet( )
    {
    }

    public IActionResult OnPost()
    {
        if (ModelState.IsValid)
        {
            // return Redirect("/Sample/Post/Validation");
            return Page();
        }
        else
        {
            return Page();
        }
    }
}
```