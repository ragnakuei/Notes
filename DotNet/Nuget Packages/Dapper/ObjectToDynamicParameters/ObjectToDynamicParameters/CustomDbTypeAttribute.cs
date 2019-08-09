using System;
using System.Data;

namespace ObjectToDynamicParameters
{
    public class CustomDbTypeAttribute : Attribute
    {
        public CustomDbTypeAttribute(DbType dbType)
        {
            DbType = dbType;
        }

        public CustomDbTypeAttribute(DbType dbType, int length)
        {
            DbType = dbType;
            Length = length;
        }

        public DbType DbType { get; }
        public int    Length { get; }
    }
}