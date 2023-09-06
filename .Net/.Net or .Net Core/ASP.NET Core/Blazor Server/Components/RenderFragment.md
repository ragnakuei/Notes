# RenderFragment

取代 vue 的 [Named Slots](https://vuejs.org/guide/components/slots.html#named-slots)

https://blazor-university.com/templating-components-with-renderfragements/

### 範例01

- Parent Component

    ```cs
    @page "/pets1"

    <h1>Pets</h1>

    <!-- Child Component -->
    <!-- 因為 Child Component 的 typeparam 指定為 TItem，這邊就可以指定 TItem 的型別，也可以省略，透過型別推斷處理 ! -->
    <!-- Context 是 Child Component 透過呼叫 RenderFragment() 將值傳回 Parent Component ! -->
    <!-- 如果有多個 RenderFragment 時，可以在該 Block 指定 Context 會更為明確 ! -->
    <TableTemplate TItem="Pet" Items="pets" Context="pet">
        <TableHeader>
            <th>ID</th>
            <th>Name</th>
        </TableHeader>
        <RowTemplate>
            <td>@pet.PetId</td>
            <td>@pet.Name</td>
        </RowTemplate>
    </TableTemplate>

    @code {
        private List<Pet> pets = new()
        {
            new Pet { PetId = 2, Name = "Mr. Bigglesworth" },
            new Pet { PetId = 4, Name = "Salem Saberhagen" },
            new Pet { PetId = 7, Name = "K-9" }
        };

        private class Pet
        {
            public int PetId { get; set; }
            public string? Name { get; set; }
        }
    }
    ```

- Child Component

    ```cs
    @typeparam TItem
    @using System.Diagnostics.CodeAnalysis

    <table class="table">
        <thead>
            <tr>@TableHeader</tr>
        </thead>
        <tbody>
            @foreach (var item in Items)
            {
                if (RowTemplate is not null)
                {
                    <tr>@RowTemplate(item)</tr>
                }
            }
        </tbody>
    </table>

    @code {
        [Parameter]
        public RenderFragment? TableHeader { get; set; }

        [Parameter]
        public RenderFragment<TItem>? RowTemplate { get; set; }

        [Parameter, AllowNull]
        public IReadOnlyList<TItem> Items { get; set; }
    }
    ````
同意語法

- Parent Component
  - 省去 TItem
  - 將 Context 移至 RowTemplate 
  
  ```cs
  <!-- 其餘相同 ... -->
  
  <!-- Child Component -->
  <TableTemplate Items="pets" >
      <TableHeader>
          <th>ID</th>
          <th>Name</th>
      </TableHeader>
      <RowTemplate Context="pet">
          <td>@pet.PetId</td>
          <td>@pet.Name</td>
      </RowTemplate>
  </TableTemplate>
  
  <!-- 其餘相同 ... -->
  ```
同意語法

- Parent Component
  - RowTemplate 不指定 Context，就以 context 變數代替

  ```cs
  <TableTemplate Items="pets" TItem="Pet">
      <TableHeader>
          <th>ID</th>
          <th>Name</th>
      </TableHeader>
      <RowTemplate>
          <td>@context.PetId</td>
          <td>@context.Name</td>
      </RowTemplate>
  </TableTemplate>
  ```