# Merge 範例

```cs
public static class DataTableExtensions
{
    /// <summary>
    /// 左邊扣掉右邊，再加上，右邊扣掉左邊
    /// </summary>
    public static DataTable MergeByExcept(this DataTable leftDt, DataTable rightDt, IEqualityComparer<DataRow> comparer = null)
    {
        var leftExceptRight = leftDt.Except(rightDt, comparer);
        var rightExceptLeft = rightDt.Except(leftDt, comparer);

        leftExceptRight.Merge(rightExceptLeft);

        return leftExceptRight;
    }

    /// <summary>
    /// 用 Merge + Distinct 的方式
    /// </summary>
    public static DataTable MergeByDistinct(this DataTable leftDt, DataTable rightDt, IEqualityComparer<DataRow> comparer = null)
    {
        var leftDtCloned = leftDt.DefaultView.ToTable();

        leftDtCloned.Merge(rightDt);

        var result = leftDtCloned.AsEnumerable()
                                 .Distinct(comparer)
                                 .CopyToDataTable();

        return result;
    }
}
```