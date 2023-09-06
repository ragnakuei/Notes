# 指定的 Column 套用指定的資料

欄位結構如下：

```cs
public class Member
{
    public string Name { get; set; }

    public Address Address { get; set; }
}

public class Address
{
    public string City { get; set; }
}
```

要在 DataGridView 中顯示姓名與地址城市，可以透過下面的方式：

### 方式一：

缺點是等於跑了二次迴圈
- 第一圈是將資料 Binding 至 DataGridView 中
- 第二圈是 BindingComplete 事件中，將 Address.City 的值填入

```cs
private void Form1_Load(object sender, EventArgs e)
{
    var members = new List<Member>
    {
        new Member
        {
            Name = "A",
            Address = new Address
            {
                City = "CityA",
            }
        }
    };

    dgv.AutoGenerateColumns = false;

    // 定義姓名欄位
    DataGridViewTextBoxColumn nameColumn = new DataGridViewTextBoxColumn();
    nameColumn.DataPropertyName = "Name";
    nameColumn.HeaderText = "姓名";
    nameColumn.Name = "Name";
    dgv.Columns.Add(nameColumn);

    // 定義地址城市欄位
    DataGridViewTextBoxColumn cityColumn = new DataGridViewTextBoxColumn();
    // cityColumn.DataPropertyName = "Address.City"; 
    cityColumn.HeaderText = "城市";
    cityColumn.Name = "Address.City";
    dgv.Columns.Add(cityColumn);

    dgv.DataBindingComplete += Dgv_DataBindingComplete;

    dgv.DataSource = members;
}

private void Dgv_DataBindingComplete(object sender, DataGridViewBindingCompleteEventArgs e)
{
    var target = sender as DataGridView;
    foreach (DataGridViewRow row in target.Rows)
    {
        Member member = row.DataBoundItem as Member;
        if (member != null)
        {
            row.Cells["Address.City"].Value = member.Address.City;
        }
    }
}
```

### 方式二：

較方式一簡化一些，在 RowAdded 事件中，將 Address.City 的值填入

```cs
private void Form1_Load(object sender, EventArgs e)
{
    // ...

    // 定義地址城市欄位
    DataGridViewTextBoxColumn cityColumn = new DataGridViewTextBoxColumn();
    // cityColumn.DataPropertyName = "Address.City"; 
    cityColumn.HeaderText = "城市";
    cityColumn.Name = "Address.City";
    dgv.Columns.Add(cityColumn);

    dgv.RowsAdded += Dgv_RowsAdded;
    dgv.DataSource = members;
}

private void Dgv_RowsAdded(object sender, DataGridViewRowsAddedEventArgs e)
{
    var target = sender as DataGridView;
    var rowIndex = e.RowIndex;

    var member = (target.DataSource as List<Member>)[rowIndex];

    var row = target.Rows[rowIndex];
    row.Cells["Address.City"].Value = member.Address.City;
}
```