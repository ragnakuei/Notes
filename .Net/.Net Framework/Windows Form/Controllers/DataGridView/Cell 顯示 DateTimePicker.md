# Cell 顯示 DateTimePicker

```cs
using System.Data;

namespace Demo01
{
    public partial class Form1 : Form
    {
        private readonly DataTable      _dt          = new DataTable();
        private readonly DateTimePicker _dgvDtPicker = new DateTimePicker();
        private readonly Column         _dgvColumn   = new Column();

        public Form1()
        {
            InitializeComponent();

            _dt.Columns.Add(_dgvColumn.Date, typeof(string));

            _dgvDtPicker.Visible      =  false;
            _dgvDtPicker.Format       =  DateTimePickerFormat.Custom;
            _dgvDtPicker.CustomFormat =  "yyyy/MM/dd";
            _dgvDtPicker.TextChanged  += new EventHandler(DateTimePickerChange);
            _dgvDtPicker.CloseUp      += new EventHandler(DateTimePickerClose);

            _dgv.Controls.Add(_dgvDtPicker);
        }

        private void btnGenerate_Click(object sender, EventArgs e)
        {
            _dt.Clear();

            var currentDate = dtPickerStart.Value;
            while (DateOnly.FromDateTime(currentDate) <= DateOnly.FromDateTime(dtPickerEnd.Value))
            {
                var row = _dt.NewRow();
                row[_dgvColumn.Date] = currentDate.ToString("yyyy/MM/dd");
                _dt.Rows.Add(row);
                currentDate = currentDate.AddDays(1);
            }

            _dgv.DataSource = _dt;

            foreach (DataGridViewColumn column in _dgv.Columns)
            {
                column.AutoSizeMode = DataGridViewAutoSizeColumnMode.AllCells;
            }
        }

        private void dgv_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            var dgv = sender as DataGridView;
            if (dgv == null)
            {
                return;
            }

            _dgvDtPicker.Visible = false;

            if (e.RowIndex != -1)
                if (e.ColumnIndex == 0)
                {
                    _dgvDtPicker.Visible = true;

                    var oRectangle = dgv.GetCellDisplayRectangle(e.ColumnIndex, e.RowIndex, true);
                    _dgvDtPicker.Size     = new Size(oRectangle.Width, oRectangle.Height);
                    _dgvDtPicker.Location = new Point(oRectangle.X, oRectangle.Y);

                    if (string.IsNullOrWhiteSpace(dgv.CurrentCell.Value.ToString()) == false)
                    {
                        _dgvDtPicker.Text = dgv.CurrentCell.Value.ToString();
                    }
                }
        }

        private void DateTimePickerChange(object sender, EventArgs e)
        {
            var dtPicker = sender as DateTimePicker;
            if (dtPicker == null)
            {
                return;
            }

            var dgv = dtPicker.Parent as DataGridView;
            if (dgv == null)
            {
                return;
            }

            dgv.CurrentCell.Value = dtPicker.Text;
        }

        private void DateTimePickerClose(object sender, EventArgs e)
        {
            var dtPicker = sender as DateTimePicker;
            if (dtPicker == null)
            {
                return;
            }

            dtPicker.Visible = false;
        }

        private class Column
        {
            public string Date { get; set; } = nameof(Date);
        }
    }
}
```