# async Action

- 如果 Action 內，需要以 async / await 執行，直接以 await Func\<Task> 呼叫即可 !

### 範例

```cs
/// <summary>
/// 攔截 Exception
/// </summary>
/// <param name="funcAsync"></param>
/// <param name="successResultFunc"></param>
/// <param name="exceptionResultFunc">如果驗証失敗不做額外處理，可不給定，就會直接回傳 Page()</param>
/// <returns></returns>
protected async Task<IActionResult?> InterceptExceptionAsync(Func<Task>           funcAsync,
                                                             Func<RedirectResult> successResultFunc,
                                                             Func<PageResult>?    exceptionResultFunc = null)
{
    try
    {
        exceptionResultFunc ??= () => Page();

        await funcAsync.Invoke();
    }
    catch (ValidateFormFailedException e)
    {
        Errors.Set(e.ValidateResult);
        return exceptionResultFunc?.Invoke();
    }
    catch (ApiResponseException e)
    {
        Errors.SetError(e.ExceptionDTO?.AlertMessage);
        return exceptionResultFunc?.Invoke();
    }
    catch (Exception e)
    {
        return exceptionResultFunc?.Invoke();
    }

    return successResultFunc.Invoke();
}
```

呼叫端語法

```cs
public async Task<IActionResult?> OnPost([FromServices]LoginFormDtoValidator validator)
{
    return await InterceptExceptionAsync(async () =>
                                         {
                                             validator.Validate(ModelState, Dto);

                                             var userInfoDto = _accountService.Login(Dto);

                                             await LoginAsync(userInfoDto);
                                         },
                                         () => Redirect("/"));
}
```
