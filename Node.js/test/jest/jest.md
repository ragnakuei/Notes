# jest


1. `npm install jest @types/jest ts-jest vue-jest@next @vue/test-utils@next --save-dev`
1. jest.config.js

    ```js
    module.exports = {
    moduleFileExtensions: [
        'js',
        'ts',
        'json',
        'vue'
    ],
    transform: {
        '^.+\\.ts$': 'ts-jest',
        '^.+\\.vue$': 'vue-jest'
    }
    }
    ```

1. package.json

    ```js
    {
    ...
    "scripts": {
        ...
        "test": "jest src"
    },
    ...
    }
    ```