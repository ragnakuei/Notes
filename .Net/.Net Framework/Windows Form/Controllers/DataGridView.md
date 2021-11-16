# DataGridView


#### DataSource 不搭配 BindingSource，重新給定 DataSource 後，可以更新資料

```cs
// 初始化呼叫
_dtos = new List<Dto>();
_dgvBindingSource = new BindingSource
                    {
                        DataSource = _dtos,
                    };
dgv.DataSource         = _dgvBindingSource;
dgv.AllowUserToAddRows = false;

// 重新給定 DataSource 後，可以更新資料
dgv.DataSource = null;
dgv.DataSource = _dtos;
```

#### DataSource 搭配 BindingSource

```cs
public partial class Form1 : Form
{
    public Form1()
    {
        InitializeComponent();

        dgv.Columns.Clear();
        dgv.Columns.AddRange(new DataGridViewTextBoxColumn { HeaderText = "編號", DataPropertyName = nameof(Dto.Id), },
                             new DataGridViewTextBoxColumn { HeaderText = "姓名", DataPropertyName = nameof(Dto.Name), },
                             new DataGridViewTextBoxColumn { HeaderText = "年齡", DataPropertyName = nameof(Dto.Age), });

        _dtos = new List<Dto>();

        _dgvBindingSource = new BindingSource
                            {
                                DataSource = _dtos,
                            };
        dgv.DataSource         = _dgvBindingSource;
        dgv.AllowUserToAddRows = false;
    }

    private          BindingSource _dgvBindingSource;
    private readonly List<Dto>     _dtos;

    private void btnUpdate_Click(object sender, EventArgs e)
    {
        dgv.Rows.Clear();

        _dtos.Add(new Dto
                    {
                        Id   = 1,
                        Name = "A",
                        Age  = 18
                    });

        _dgvBindingSource.ResetBindings(false);
    }
}
```