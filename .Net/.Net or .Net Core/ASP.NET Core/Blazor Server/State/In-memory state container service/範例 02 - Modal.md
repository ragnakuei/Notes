# 範例 02

注意：**這個範例是 Demo 用，不適合用在實際應用程式中。**

Modal

操控 Modal 狀態的頁面 => ModalModel => Modal html 頁面

| 頁面功能 | 操控 Modal 狀態的頁面 | ModalModel    | Modal html 頁面 |
| -------- | --------------------- | ------------- | --------------- |
| 頁面檔案 | ModalTest.razor       | ModalModel.cs | Modal.razor     |

- ModalTest.razor


    ```cs
    @page "/ModalTest"

    <p>ModalTest</p>

    <div class="d-flex gap-3">
        <button class="btn btn-primary"
                @onclick="() => ModalModel.IsOpen = true">
            Open Modal
        </button>
    </div>

    @code {
        [Inject]
        public ModalModel ModalModel{ get; set; }

        protected override void OnInitialized()
        {
            ModalModel.OnClickConfirm = OnClickConfirm;
        }

        public void OnClickConfirm()
        {
            // Click Confirm


            ModalModel.IsOpen = false;
        }
    }

    ```

- ModalModel.cs

    ```cs
    public class ModalModel
    {
        private bool _isOpen;

        public bool IsOpen
        {
            get => _isOpen;
            set
            {
                _isOpen = value;
                IsOpenOnChange?.Invoke(_isOpen);
            }
        }

        public event Action<bool>? IsOpenOnChange;

        public Action OnClickConfirm { get; set; }
    }

    ```


- Modal.razor


    ```cs
    @implements IDisposable
    @*
        目前無法做到點擊 class="modal-dialog" 以外的地方，來關閉 modal !
        可能解法：自制 Modal 內容，裡面放 Modal 相同外觀的東西，但不要讓 modal 視窗長滿整個畫面 !
    *@
    <div class="modal fade @_modalClass"
        tabindex="-1"
        id="@Id"
        aria-hidden="true"
        @attributes=_modalAttributes>
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title"
                        id="exampleModalLabel">
                        @Title
                    </h5>
                    <button type="button"
                            class="btn-close"
                            @onclick="() => ModalModel.IsOpen = false"
                            aria-label="Close">
                    </button>
                </div>
                <div class="modal-body">
                    是否執行作業 ?
                </div>
                <div class="modal-footer">
                    <button type="button"
                            class="btn btn-secondary"
                            @onclick="() => ModalModel.IsOpen = false">
                        取消
                    </button>
                    <button type="button"
                            @onclick="ModalModel.OnClickConfirm"
                            class="btn btn-danger">
                        確認
                    </button>
                </div>
            </div>
        </div>
    </div>
    @if (ModalModel.IsOpen)
    {
        <div class="modal-backdrop fade show"
            @onclick="() => ModalModel.IsOpen = false">
        </div>
    }


    @code {
        [Inject]
        public ModalModel ModalModel { get; set; }

        protected override void OnInitialized()
        {
            ModalModel.IsOpenOnChange += IsOpenChange;
        }

        public void Dispose()
        {
            ModalModel.IsOpenOnChange -= IsOpenChange;
        }

        public void IsOpenChange(bool isOpen)
        {
            if (isOpen)
            {
                _modalClass = "show";
                _modalAttributes = new Dictionary<string, object>
                                    {
                                        ["style"] = "display: block;",
                                        ["aria-modal"] = "true",
                                        ["role"] = "dialog",
                                    };
            }
            else
            {
                _modalClass = string.Empty;
                _modalAttributes = new Dictionary<string, object>
                                    {
                                        ["style"] = "display: none;",
                                        ["aria-hidden"] = "true",
                                    };
            }

            StateHasChanged();
        }

        private string _modalClass = string.Empty;
        
        private Dictionary<string, object> _modalAttributes = new();

        [Parameter]
        public string Id { get; set; } = "StaticModal";

        [Parameter]
        public string Title { get; set; } = "作業確認";
    }
    ```