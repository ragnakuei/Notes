# Dictionary

```ts
class Dictionary {
    [index: string]: string;
}

class Test {

    public run(dict : Dictionary) {
        for (var key in dict) {
            console.log(
                "key=" + key + "\n" +
                "value=" + dict[key] + "\n"
                );
        }
    }
}

var dict = new Dictionary();
dict["A"] = "A01";
dict["B"] = "B01";
dict["C"] = "C01";

new Test().run(dict);
```