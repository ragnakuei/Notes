# GetValueDefaultOrNull

目的
- 只是為了支援 enum?.GetValueOrDefault() 可以回傳 null，而不是回傳 0 的那個值 !
- 改用 GetValueDefaultOrNull
- 同時支援 Dictionary

```csharp
public static class CommonExtensions
{
    // 取出 struct 值
    public static T? GetValueDefaultOrNull<T>(this T? t) where T : struct
    {
        if (t == null)
        {
            return null;
        }

        if (t is Enum)
        {
            if (IsSetFlag(t))
            {
                return t;
            }
            if (Enum.IsDefined(t.GetType(), t))
            {
                return t;
            }
            else
            {
                return null;
            }
        }

        return t;
    }

    private static bool IsSetFlag<T>(this T? t) where T : struct
    {
        long lValue = Convert.ToInt64(t);

        foreach (var v in Enum.GetValues(t.GetType()))
        {
            long lFlag = Convert.ToInt64(v);

            if ((lValue & lFlag) != 0)
            {
                return true;
            }
        }

        return false;
    }

    // 取出 class 值
    public static T GetValueDefaultOrNull<T>(this T t) where T : class
    {
        if (t == null)
        {
            return null;
        }

        return t;
    }

    // 以下是針對 TKey、TValue 的分別為 struct / class 的四種組合

    public static TValue? GetValueDefaultOrNull<TKey, TValue>(this Dictionary<TKey?, TValue?> dict, TKey? key)
        where TKey : struct
        where TValue : struct
    {
        if (key == null)
        {
            return null;
        }

        return dict.GetValueOrDefault(key);
    }

    public static TValue GetValueDefaultOrNull<TKey, TValue>(this Dictionary<TKey?, TValue> dict, TKey? key)
            where TKey : struct
            where TValue : class
    {
        if (key == null)
        {
            return null;
        }

        return dict.GetValueOrDefault(key);
    }

    public static TValue GetValueDefaultOrNull<TKey, TValue>(this Dictionary<TKey, TValue> dict, TKey key)
        where TKey : class
        where TValue : class
    {
        if (key == null)
        {
            return null;
        }

        return dict.GetValueOrDefault(key);
    }

    public static TValue? GetValueDefaultOrNull<TKey, TValue>(this Dictionary<TKey, TValue?> dict, TKey key)
        where TKey : class
        where TValue : struct
    {
        if (key == null)
        {
            return null;
        }

        return dict.GetValueOrDefault(key);
    }
}
```