# 以 js 開啟 modal

情境：
1. HttpClientService 跟後端溝通時，如果發生錯誤後，將錯誤訊息傳至 MainLayout.razor 中的 Modal 中
1. Modal 以 Bootstrap 5 Modal 將錯訊息顯示出來 !

呼叫步驟：

1. Modal Component 訂閱 ModalService.Show() 以開啟 Modal
1. HttpClientService 發生錯誤時，呼叫 ErrorStore.ErrorOccurred()
1. ErrorStore 將錯誤訊息擷取出來後，呼叫 ModalService.Show()


##### ModalComponent.razor

```cs
@implements IAsyncDisposable
@inject IJSRuntime _jsRuntime
@inject ModalService _modalService
@inject ConsoleService _consoleService

<div class="modal fade"
     id="exampleModal"
     tabindex="-1"
     aria-labelledby="exampleModalLabel"
     aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title"
                    id="exampleModalLabel">
                    Modal title
                </h5>
                <button type="button"
                        class="btn-close"
                        data-bs-dismiss="modal"
                        aria-label="Close">
                </button>
            </div>
            <div class="modal-body">
                @_msg
            </div>
            <div class="modal-footer">
                <button type="button"
                        class="btn btn-secondary"
                        data-bs-dismiss="modal">
                    Close
                </button>
            </div>
        </div>
    </div>
</div>

@code {
    private IJSObjectReference _module;

    private string _msg;

    protected override async Task OnInitializedAsync()
    {
        await base.OnInitializedAsync();

        _module = await _jsRuntime.InvokeAsync<IJSObjectReference>("import", "/js/scripts.js");
        
        await _module.InvokeVoidAsync("initialize", "exampleModal");

        await _consoleService.LogAsync("Register ModalService.Show");

        _modalService.Show += OnModalServiceShow;
    }

    private async void OnModalServiceShow(string msg)
    {
        await _consoleService.LogAsync("OnModalServiceShow", msg);

        _msg = msg;
        StateHasChanged();
        await _module.InvokeVoidAsync("show");
    }

    public async ValueTask DisposeAsync()
    {
        _modalService.Show -= OnModalServiceShow;

        if (_module is not null)
        {
            await _module.DisposeAsync();
        }
    }

}
```

##### scripts.js

- 將要保留的狀態留在 windows object 內，需要讓外部呼叫的 function 才用 export function !

```js
window.Bootstrap5Modal = {
    
    initialize(id) {
        this.modal = new bootstrap.Modal(document.getElementById(id));
    },
    
    show( message ) {
        this.modal.show();
    }
};

export function initialize( id ) {
    return window.Bootstrap5Modal.initialize( id);
}

export function show( message ) {
    return window.Bootstrap5Modal.show( message);
}
```

##### ModalService.cs

```cs
namespace BlazorApp01.Client.Services;

public class ModalService
{
    public Action<string> Show { get; set; }
}
```

##### ErrorStore.cs

```cs
using System.Net.Http.Json;
using BlazorApp01.Client.Services;
using KueiPackages.Models;

namespace BlazorApp01.Client.Stores;

public class ErrorStore
{
    private readonly ModalService   _modalService;
    private readonly ConsoleService _consoleService;

    public ErrorStore(ModalService   modalService,
                      ConsoleService consoleService)
    {
        _modalService   = modalService;
        _consoleService = consoleService;

        this.ErrorOccurred += ShowErrorModal;
    }

    public Action<HttpResponseMessage>? ErrorOccurred { get; }

    private async void ShowErrorModal(HttpResponseMessage obj)
    {
        var responseBody = await obj.Content.ReadFromJsonAsync<ResponseDto>();

        await _consoleService.LogAsync("Trigger ModalService.Show()");

        _modalService.Show?.Invoke(responseBody?.Message);
    }
}
```

##### HttpClientService.cs


```cs
using System.Net.Http.Json;
using System.Text.Json;
using System.Text.Json.Serialization;
using BlazorApp01.Client.Shared;
using BlazorApp01.Client.Stores;
using BlazorApp01.Shared.Consts;
using KueiPackages.Models;
using KueiPackages.System.Text.Json;
using Microsoft.JSInterop;

namespace BlazorApp01.Client.Services;

public class HttpClientService
{
    private readonly IHttpClientFactory _clientFactory;
    private readonly IJSRuntime         _jsRuntime;
    private readonly ErrorStore         _errorStore;

    private JsonSerializerOptions _jsonOptions = new()
                                                 {
                                                     DefaultIgnoreCondition      = JsonIgnoreCondition.WhenWritingNull,
                                                     PropertyNamingPolicy        = null,
                                                     PropertyNameCaseInsensitive = false,
                                                 };

    public HttpClientService(IHttpClientFactory clientFactory,
                             IJSRuntime         jsRuntime,
                             ErrorStore         errorStore)
    {
        _clientFactory = clientFactory;
        _jsRuntime     = jsRuntime;
        _errorStore    = errorStore;
    }

    public async Task<ResponseDto<T>> GetAsync<T>(string url)
    {
        var response = await _clientFactory.CreateClient(HttpClientName.Default).GetAsync(url);
        
        if (response.IsSuccessStatusCode == false)
        {
            // 在發生錯誤時，希望透過 Modal 來顯示其錯誤訊息 !
            _errorStore.ErrorOccurred?.Invoke(response);
            throw new Exception(response.ReasonPhrase);
        }

        var json = await response.Content.ReadAsStringAsync();

        if (string.IsNullOrWhiteSpace(json))
        {
            return default;
        }

        var responseDto = json.ParseJson<ResponseDto<T>>();

        if (string.IsNullOrWhiteSpace(responseDto.AlertMessage) == false)
        {
            await _jsRuntime.InvokeVoidAsync("alert", responseDto.AlertMessage);
        }

        return responseDto;
    }

    public async Task<ResponseDto<T>> PostAsync<T>(string url, object requestBody = null)
    {
        var responseMessage = await _clientFactory.CreateClient(HttpClientName.Default).PostAsJsonAsync(url, requestBody, _jsonOptions);
        if (responseMessage.IsSuccessStatusCode == false)
        {
            await _jsRuntime.InvokeVoidAsync("alert", responseMessage.ReasonPhrase);
        }

        var responseDto = await responseMessage.Content.ReadFromJsonAsync<ResponseDto<T>>();
        if (string.IsNullOrWhiteSpace(responseDto.AlertMessage) == false)
        {
            await _jsRuntime.InvokeVoidAsync("alert", responseDto.AlertMessage);
        }

        return responseDto;
    }
}
```