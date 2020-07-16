# 直接把 configuration 轉成指定的 DTO

[範例](https://github.com/ragnakuei/IConfigurationRootDtoLibrary)

因為 configuration 套件，本身具有文件改變就重新讀取的功能

如果套用這個功能時，有些東西要有所取捨

-   因為 config DTO 不會太常變動，可以搭配 DI Container 設定成 singleton，來減少讀取動作
-   如果讓 DI 指定為 singleton，每次取得相同的資料，即使更新了 config file ，`也不會更新到 DTO` !
-   如果讓 DI 指定為 非 singleton，更新了 config file 後，就會更新到 DTO，但是在`轉 DTO 的過程中，會比較費時` !
-   提供額外手動更新 DTO 的方式來更新 DTO，例：內部可執行的 api

```csharp
using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Reflection.PortableExecutable;
using Microsoft.Extensions.Configuration;

namespace IConfigurationRootDtoLibrary
{
    public static class IConfigurationRootDtoHelper
    {
        public static T Get<T>(this IConfigurationRoot configuration) where T : class
        {
            var contextDTO = new ConfigContextDTO<T>
                             {
                                 Configuration        = configuration,
                                 objectInstance       = Activator.CreateInstance(typeof(T)) as T,
                                 CurrentPropertyNames = new List<string>(),
                             };

            var type       = typeof(T);
            var properties = type.GetProperties();
            foreach (var property in properties)
            {
                Object propertyValue = configuration.GetSection(property.Name).Value;

                contextDTO.CurrentPropertyNames.Add(property.Name);

                propertyValue = ConvertPropertyValueType(contextDTO, property, propertyValue);

                contextDTO.CurrentPropertyNames.RemoveAt(contextDTO.CurrentPropertyNames.Count - 1);

                property.SetValue(contextDTO.objectInstance, propertyValue);
            }

            return contextDTO.objectInstance;
        }

        private class ConfigContextDTO<T>
        {
            public IConfigurationRoot Configuration { get; set; }

            public T objectInstance { get; set; }

            public IList<string> CurrentPropertyNames { get; set; }
        }

        private static Object ConvertPropertyValueType<T>(ConfigContextDTO<T> contextDTO, PropertyInfo property, object propertyValue)
        {
            if (property.PropertyType == typeof(string))
            {
                return propertyValue;
            }

            if (property.PropertyType == typeof(Int32))
            {
                return Convert.ToInt32(propertyValue);
            }

            if (IsNullable<Int32>(property.PropertyType))
            {
                if (string.IsNullOrWhiteSpace(propertyValue?.ToString()) == false)
                {
                    return Convert.ToInt32(propertyValue);
                }

                return null;
            }

            if (IsJsonObject(property))
            {
                return ToObject(contextDTO, property.PropertyType);
            }

            if (IsJsonArray(property))
            {
                return ToArray(contextDTO, property.PropertyType);
            }

            return null;
        }

        private static bool IsNullable<T>(Type propertyPropertyType)
        {
            var type = Nullable.GetUnderlyingType(propertyPropertyType);

            return type == typeof(T);
        }

        private static bool IsJsonObject(PropertyInfo property)
        {
            return property.PropertyType.BaseType == typeof(Object);
        }

        private static bool IsJsonArray(PropertyInfo property)
        {
            return property.PropertyType.BaseType == typeof(Array);
        }

        private static dynamic ToObject<T>(ConfigContextDTO<T> contextDTO, Type propertyPropertyType)
        {
            dynamic result = Activator.CreateInstance(propertyPropertyType);

            var properties = propertyPropertyType.GetProperties();
            foreach (var property in properties)
            {
                contextDTO.CurrentPropertyNames.Add(property.Name);

                var    propertyName  = string.Join(":", contextDTO.CurrentPropertyNames);
                object propertyValue = contextDTO.Configuration.GetSection(propertyName).Value;
                propertyValue = ConvertPropertyValueType(contextDTO, property, propertyValue);

                property.SetValue(result, propertyValue);

                contextDTO.CurrentPropertyNames.RemoveAt(contextDTO.CurrentPropertyNames.Count - 1);
            }

            return result;
        }

        private static dynamic ToArray<T>(ConfigContextDTO<T> contextDTO, Type propertyPropertyType)
        {
            var     arrayCount  = GetArrayCount(contextDTO);
            dynamic resultArray = Activator.CreateInstance(propertyPropertyType, arrayCount);

            var elementType = propertyPropertyType.GetElementType();
            for (int i = 0; i < arrayCount; i++)
            {
                contextDTO.CurrentPropertyNames.Add(i.ToString());

                resultArray[i] = ToObject(contextDTO, elementType);

                contextDTO.CurrentPropertyNames.RemoveAt(contextDTO.CurrentPropertyNames.Count - 1);
            }

            return resultArray;
        }

        private static int GetArrayCount<T>(ConfigContextDTO<T> contextDTO)
        {
            var sectionKey = string.Join(":", contextDTO.CurrentPropertyNames);

            return contextDTO.Configuration.GetSection(sectionKey)
                             .AsEnumerable()
                             .Select(kv => kv.Key.Replace(sectionKey, string.Empty).TrimStart(':'))
                             .Select(key => key.Split(":")[0])
                             .Where(key => string.IsNullOrWhiteSpace(key) == false)
                             .Select(key => Convert.ToInt32(key))
                             .Max()
                 + 1;
        }
    }
}
```
