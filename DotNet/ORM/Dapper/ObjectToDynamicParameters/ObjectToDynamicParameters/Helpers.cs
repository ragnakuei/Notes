using System;
using System.Linq;
using Dapper;

namespace ObjectToDynamicParameters
{
    public static class Helpers
    {
        public static DynamicParameters ToDynamicParameters<T>(this T obj)
        {
            return obj.GetType()
                      .GetProperties()
                      .Aggregate(new DynamicParameters()
                               , (seed, item) =>
                                 {
                                     var customDbTypes = item?.GetCustomAttributes(typeof(CustomDbTypeAttribute), false);
                                     if (customDbTypes?.Length > 1)
                                     {
                                         throw new NotSupportedException();
                                     }

                                     var customDbType = customDbTypes?.FirstOrDefault() as CustomDbTypeAttribute;
                                     if (customDbType == null)
                                     {
                                         return seed;
                                     }

                                     var propertyValue = item.GetValue(obj);

                                     if (customDbType.Length != 0)
                                     {
                                         seed.Add(item.Name
                                                , propertyValue
                                                , customDbType.DbType
                                                , size : customDbType.Length);
                                     }
                                     else
                                     {
                                         seed.Add(item.Name
                                                , propertyValue
                                                , customDbType.DbType);
                                     }

                                     return seed;
                                 });
        }
    }
}