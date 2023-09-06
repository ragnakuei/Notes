# modal

## components

-   modal.razor

    ```cs
    @*
        目前無法做到點擊 class="modal-dialog" 以外的地方，來關閉 modal !
        可能解法：自制 Modal 內容，裡面放 Modal 相同外觀的東西，但不要讓 modal 視窗長滿整個畫面 !
    *@
    <div class="modal fade @_modalClass"
        tabindex="-1"
        id="@Id"
        aria-hidden="true"
        @attributes=_modalAttributes>
        <div class="modal-dialog @ModalCss">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title"
                        id="exampleModalLabel">
                        @Title
                    </h5>
                    <button type="button"
                            class="btn-close"
                            @onclick="Close"
                            aria-label="Close">
                    </button>
                </div>
                <div class="modal-body">
                    @Body
                </div>
                <div class="modal-footer">
                    @Footer
                </div>
            </div>
        </div>
    </div>
    @if (_isOpen)
    {
        <div class="modal-backdrop fade show"
            @onclick="Close">
        </div>
    }


    @code {
        [Parameter]
        public string Id { get; set; }

        [Parameter]
        public string Title { get; set; }

        /// <summary>
        /// modal size
        /// <para>
        /// modal-sm / 不給定 / modal-lg / modal-xl
        /// </para>
        /// <para>
        /// modal-fullscreen / modal-fullscreen-sm-down / modal-fullscreen-md-down / modal-fullscreen-lg-down / modal-fullscreen-xl-down / modal-fullscreen-xxl-down
        /// </para>
        /// </summary>
        [Parameter]
        public string ModalCss { get; set; }

        [Parameter]
        public RenderFragment? Body { get; set; }

        [Parameter]
        public RenderFragment? Footer { get; set; }

        public void Open()
        {
            _isOpen = true;
            _modalClass = "show";
            _modalAttributes = new Dictionary<string, object>
                            {
                                ["style"] = "display: block;",
                                ["aria-modal"] = "true",
                                ["role"] = "dialog",
                            };

            StateHasChanged();

        }

        public void Close()
        {
            _isOpen = false;
            _modalClass = string.Empty;
            _modalAttributes = new Dictionary<string, object>
                            {
                                ["style"] = "display: none;",
                                ["aria-hidden"] = "true",
                            };

            StateHasChanged();
        }

        private bool _isOpen = false;

        private string _modalClass = string.Empty;

        private Dictionary<string, object> _modalAttributes = new();
    }
    ```

-   ModalDialog.razor
    使用上述 component 來限縮使用的範圍，同時也可以減少呼叫 component 的給定引數 !

    ```cs
    <Modal @ref="_modal"
        ModalCss="@ModalCss"
        Title="@Title">
        <Body>
            @Body
        </Body>

        <Footer>
            @if (string.IsNullOrWhiteSpace(CloseLabel) == false)
            {
                <button type="button"
                        class="btn btn-secondary"
                        @onclick="Close">
                    @CloseLabel
                </button>
            }
            @if (string.IsNullOrWhiteSpace(ConfirmLabel) == false)
            {
                <button type="button"
                        @onclick="OnClickConfirm"
                        class="btn btn-danger">
                    @ConfirmLabel
                </button>
            }
        </Footer>
    </Modal>

    @code {

        [Parameter]
        public string Id { get; set; } = "ModalDialog";

        [Parameter]
        public string Title { get; set; } = string.Empty;

        /// <summary>
        /// modal size
        /// <para>
        /// modal-sm / 不給定 / modal-lg / modal-xl
        /// </para>
        /// <para>
        /// modal-fullscreen / modal-fullscreen-sm-down / modal-fullscreen-md-down / modal-fullscreen-lg-down / modal-fullscreen-xl-down / modal-fullscreen-xxl-down
        /// </para>
        /// </summary>
        [Parameter]
        public string ModalCss { get; set; }

        [Parameter]
        public RenderFragment? Body { get; set; }

        [Parameter]
        public Action OnClickConfirm { get; set; }

        [Parameter]
        public string CloseLabel { get; set; }

        [Parameter]
        public string ConfirmLabel { get; set; }

        private Modal _modal { get; set; }

        public void Open()
        {
            _modal.Open();
        }

        public void Close()
        {
            _modal.Close();
        }
    }
    ```

-   ModalPromptDialog.razor

    ```cs
    <form @onsubmit="Submit">
        <Modal @ref="_modal"
            ModalCss="@ModalCss"
            Title="@Title">
            <Body>
            <div class="mb-3">
                <label for="promptInput"
                    class="form-label">
                    @InputLabel
                </label>
                <input id='promptInput'
                    class="form-control"
                    @bind="Reason"
                    @attributes="_inputCss"
                    @bind:event="onchange" />
            </div>
            </Body>

            <Footer>
                @if (string.IsNullOrWhiteSpace(CloseLabel) == false)
                {
                    <button type="button"
                            class="btn btn-secondary"
                            @onclick="Close">
                        @CloseLabel
                    </button>
                }
                <button type="submit"
                        class="btn btn-danger">
                    @SubmitLabel
                </button>
            </Footer>
        </Modal>
    </form>

    @code {

        [Parameter]
        public string Id { get; set; } = "ModalDialog";

        [Parameter]
        public string Title { get; set; } = string.Empty;

        /// <summary>
        /// modal size
        /// <para>
        /// modal-sm / 不給定 / modal-lg / modal-xl
        /// </para>
        /// <para>
        /// modal-fullscreen / modal-fullscreen-sm-down / modal-fullscreen-md-down / modal-fullscreen-lg-down / modal-fullscreen-xl-down / modal-fullscreen-xxl-down
        /// </para> 
        /// </summary>
        [Parameter]
        public string ModalCss { get; set; }

        [Parameter]
        public string InputLabel { get; set; }

        [Parameter]
        public Action OnClickConfirm { get; set; }

        [Parameter]
        public string CloseLabel { get; set; }

        [Parameter]
        public string SubmitLabel { get; set; }

        [Parameter]
        public bool InputRequired { get; set; }

        public string Reason { get; set; }

        private Modal _modal { get; set; }

        private Dictionary<string, object> _inputCss { get; set; } = new();

        protected override void OnInitialized()
        {
            if (InputRequired)
            {
                _inputCss.Add("required", true);
            }
        }

        public void Open()
        {
            _modal.Open();
        }

        public void Close()
        {
            Reason = string.Empty;
            _modal.Close();
        }

        private void Submit()
        {
            OnClickConfirm.Invoke();
        }

    }
    ```


##### ModalDialog 呼叫端

- 以最少的程式碼來呼叫

    ```cs
    @page "/ModalTest"

    <p>ModalTest</p>

    <div class="d-flex gap-3">
        <button class="btn btn-primary"
                @onclick="() => _modalDialog.Open()">
            Open Dialog Modal
        </button>
    </div>

    <ModalDialog @ref="_modalDialog"
                 Title="測試 Dialog Title"
                 ModalCss='modal-sm'
                 CloseLabel="關閉"
                 ConfirmLabel="確認"
                 OnClickConfirm="OnClickConfirm">
        <Body>
            <div>是否顯示 Dialog ?</div>
        </Body>
    </ModalDialog>

    @code {
        private ModalDialog _modalDialog { get; set; }

        private void OnClickConfirm()
        {
            _modalDialog.Close();
        }

    }
    ```

##### ModalPromptDialog 呼叫端

- 以最少的程式碼來呼叫

    ```cs
    @page "/ModalTest"

    <p>ModalTest</p>

    <div class="d-flex gap-3">
        <button class="btn btn-primary"
                @onclick="() => _modalPromptDialog.Open()">
            Open Prompt Modal
        </button>
    </div>
    <div>
        <label>Reason：@_inputReason</label>
    </div>

    <ModalPromptDialog @ref="_modalPromptDialog"
                    Title="刪除"
                    InputLabel='請輸入刪除原因：'
                    ModalCss='modal-sm'
                    CloseLabel="關閉"
                    SubmitLabel="確認"
                    InputRequired="true"
                    OnClickConfirm="OnClickConfirm">
    </ModalPromptDialog>

    @code {
        private ModalPromptDialog _modalPromptDialog { get; set; }

        private string _inputReason = string.Empty;
        
        private void OnClickConfirm()
        {
            _inputReason = _modalPromptDialog.Reason;
            _modalPromptDialog.Close();
            StateHasChanged();
        }

    }
    ```
