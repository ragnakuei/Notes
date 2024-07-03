# InputSelect

#### 套用 ValueChanged 事件

```cs
<div class="col-12 col-sm-8 col-md-6 col-lg-4">
    <InputSelect class="form-select"
                    id="MeetingRoomGuid"
                    required
                    TValue="Guid?"
                    ValueChanged="ChangeMeetingRoomGuidAsync"
                    Value="@_dto.MeetingRoomGuid"
                    ValueExpression="() => _dto.MeetingRoomGuid"
                    >
        <option selected
                disabled>
            請選擇
        </option>
        @foreach (var meetingRoom in _meetingRooms)
        {
            <option value="@meetingRoom.Value">@meetingRoom.Text</option>
        }
    </InputSelect>
</div>

@code 
{
    private async Task ChangeMeetingRoomGuidAsync(Guid? newValue)
    {
        // TODO
    }
}
```