using System;
using System.Collections.Generic;
using System.Data;
using System.Reflection;

namespace Tests
{
    public class DataTableWithSerialGenerator<T>
    {
        private readonly (string name, Type type) _serialProperty = ("Serial", typeof(long));
        private readonly PropertyInfo[]           _propertyInfos;
        private readonly DataTable                _result;
        public           DataTable                Result => _result;

        private int _serialNo = 1;

        public DataTableWithSerialGenerator()
        {
            _propertyInfos = typeof(T).GetProperties();
            _result        = new DataTable();
            foreach (var propertyInfo in _propertyInfos)
            {
                var column = new DataColumn();
                column.ColumnName = propertyInfo.Name;

                var isNullableType = propertyInfo.PropertyType.IsGenericType
                                     && propertyInfo.PropertyType.GetGenericTypeDefinition() == typeof(Nullable<>);

                column.AllowDBNull = isNullableType;
                column.DataType = isNullableType
                                      ? Nullable.GetUnderlyingType(propertyInfo.PropertyType)
                                      : propertyInfo.PropertyType;

                _result.Columns.Add(column);
            }

            _result.Columns.Add(_serialProperty.name, _serialProperty.type);
        }

        public void Add(T rowData)
        {
            var row = _result.NewRow();
            for (int i = 0 ; i < _propertyInfos.Length ; i++)
            {
                row[i] = _propertyInfos[i].GetValue(rowData) ?? DBNull.Value;
            }

            row[_propertyInfos.Length] = _serialNo++;
            _result.Rows.Add(row);
        }

        public void AddRange(IEnumerable<T> rowData)
        {
            foreach (var row in rowData)
            {
                Add(row);
            }
        }
    }
}