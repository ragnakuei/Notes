# factory

### 範例 1

```js
class Animal {
    constructor(name) {
        this.name = name;
    }
    speak() {}
}

class Dog extends Animal {
    speak() {
        return 'Woof!';
    }
}

class Cat extends Animal {
    speak() {
        return 'Meow!';
    }
}

class AnimalFactory {
    createAnimal(type, name) {
        switch (type) {
            case 'Dog':
                return new Dog(name);
            case 'Cat':
                return new Cat(name);
            default:
                return null;
        }
    }
}

// 使用 AnimalFactory 來創建動物
const animalFactory = new AnimalFactory();
const dog = animalFactory.createAnimal('Dog', 'Rex');
const cat = animalFactory.createAnimal('Cat', 'Tom');

console.log(dog.speak()); // Outputs: Woof!
console.log(cat.speak()); // Outputs: Meow!
```