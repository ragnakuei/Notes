# 動態 Column 轉成 Master-Salve 結構

給定 啟始日 (_dtPickerStart) 和 結束日 (_dtPickerEnd)
建立 Table (_dgv)，欄位為 
- Name
- 所指定的日期區間的每一天
- Total

轉換
- Master - 主表資料
- Slave - 子表資料


```cs
using System.Data;

namespace Demo01
{
    public partial class Form1 : Form
    {
        // controls
        // _dtPickerStart = DateTimePicker
        // _dtPickerEnd   = DateTimePicker
        // _dgv       = DataGridView
        // _dgvMaster = DataGridView
        // _dgvSlave  = DataGridView

        private          DataTable _dt;
        private readonly Column    _dgvColumn = new Column();

        private DataTable _dtMaster;
        private DataTable _dtSlave;

        public Form1()
        {
            InitializeComponent();
        }

        private void btnGenerate_Click(object sender, EventArgs e)
        {
            _dt = new DataTable();
            _dt.Columns.Clear();
            _dt.Columns.Add(_dgvColumn.Name, typeof(string));

            _dgvColumn.Date = new List<string>();

            var currentDate = _dtPickerStart.Value;
            while (DateOnly.FromDateTime(currentDate) <= DateOnly.FromDateTime(_dtPickerEnd.Value))
            {
                var columnName = currentDate.ToString("yyyy/MM/dd");
                _dt.Columns.Add(columnName, typeof(int));
                _dgvColumn.Date.Add(columnName);

                currentDate = currentDate.AddDays(1);
            }
            _dt.Columns.Add(_dgvColumn.Total, typeof(int));

            _dgv.DataSource = _dt;
            _dgv.Columns[_dgvColumn.Total].ReadOnly = true;
            _dgv.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.Fill;
            _dgv.AllowUserToAddRows  = true;
        }


        private void _dgv_CellEndEdit(object sender, DataGridViewCellEventArgs e)
        {
            var row = _dgv.Rows[e.RowIndex];

            var total = 0;
            foreach (var dateColumn in _dgvColumn.Date)
            {
                var value = row.Cells[dateColumn].Value;
                if (value != DBNull.Value)
                {
                    total += Convert.ToInt32(value);
                }
            }
            
            row.Cells[_dgvColumn.Total].Value = total;
        }

        private void btnConvert_Click(object sender, EventArgs e)
        {
            if (_dgv.Rows.Count == 0)
            {
                return;
            }

            _dtMaster = new DataTable();
            _dtMaster.Columns.Add("Id",    typeof(int));
            _dtMaster.Columns.Add("Name",  typeof(string));
            _dtMaster.Columns.Add("Total", typeof(int));

            _dtSlave = new DataTable();
            _dtSlave.Columns.Add("MasterId", typeof(int));
            _dtSlave.Columns.Add("Date",     typeof(string));
            _dtSlave.Columns.Add("Count",    typeof(int));

            for (int i = 0; i < _dgv.Rows.Count; i++)
            {
                var row  = _dgv.Rows[i];
                var name = row.Cells["Name"].Value;
                if(name == null)
                {
                    continue;
                }

                var masterRow = _dtMaster.NewRow();
                var masterId  = i + 1;
                masterRow["Id"]    = masterId;
                masterRow["Name"]  = name;
                masterRow["Total"] = row.Cells["Total"].Value;
                
                _dtMaster.Rows.Add(masterRow);

                foreach (var dateColumn in _dgvColumn.Date)
                {
                    var slaveRow = _dtSlave.NewRow();
                    slaveRow["MasterId"] = masterId;
                    slaveRow["Date"]     = dateColumn;
                    slaveRow["Count"]    = row.Cells[dateColumn].Value;
                    
                    _dtSlave.Rows.Add(slaveRow);
                }
            }
            
            _dgvMaster.DataSource          = _dtMaster;
            _dgvMaster.AutoSizeColumnsMode = DataGridViewAutoSizeColumnsMode.Fill;
            
            _dgvSlave.DataSource           = _dtSlave;
            _dgvSlave.AutoSizeColumnsMode  = DataGridViewAutoSizeColumnsMode.Fill;
        }

        private class Column
        {
            public string Name { get; set; } = nameof(Name);

            public IList<string> Date { get; set; }

            public string Total { get; set; } = nameof(Total);
        }
    }
}
```