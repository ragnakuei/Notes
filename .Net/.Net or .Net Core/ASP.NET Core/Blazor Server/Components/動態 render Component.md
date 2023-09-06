# 動態 render Component

```cs
<div class='alerts-container d-flex flex-column align-items-end'>
    @for (int i = 0; i < _components.Count; i++)
    {
        @if (_components[i].Enabled)
        {
            RenderFragment renderFragment = (builder) =>
                                            {
                                                // 等於是建立 Component Html Tag Open 的部份
                                                builder.OpenComponent(0, _components[i].ShowNotification.GetType());
                                                // builder.OpenComponent<ShowNotification>(0);
                                                
                                                // 給定 Parameter 的方式
                                                builder.AddAttribute(0, nameof(ShowNotification.Content), "Test");

                                                // 等於是建立 Component Html Tag Close 的部份
                                                builder.CloseComponent();
                                            };

            <div>
                @renderFragment
            </div>
        }
    }
</div>

@code
{
    public class EnabledComponent
    {
        public bool Enabled { get; set; }

        public ShowNotification ShowNotification { get; set; }
    }

    private readonly IList<EnabledComponent> _components
        = Enumerable.Range(1, 10)
                    .Select(i => new EnabledComponent
                                 {
                                     Enabled = false,
                                     ShowNotification = new ShowNotification()
                                 })
                    .ToList();

    private int _index = 0;

    public async Task PushAsync()
    {
        var handleIndex = _index++;
        
        if(_index >= _components.Count)
        {
            _index = 0;
        }

        _components[handleIndex].Enabled = true;

        StateHasChanged();

        Console.WriteLine($"Components _index: {_index}");

        await Task.Delay(2000);

        _components[handleIndex].Enabled = false;

        StateHasChanged();

        Console.WriteLine($"Components _index: {_index}");
    }
}
```