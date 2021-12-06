# 傳入 function 的宣告

- 類似 C# 委派用法

```ts
interface IDto
{
    Id : Number ;

    Name : String;
}

class Service {
    public getValue<TSource, TKey>(dto : TSource,
                                     selector : (dto : TSource) => TKey ) : TKey {
        
        return selector(dto);
    }
}

const dto : IDto = {
    Id : 1,
    Name : 'A'
}

const result = new Service().getValue(dto, dto => dto.Id);
console.log(result);
```