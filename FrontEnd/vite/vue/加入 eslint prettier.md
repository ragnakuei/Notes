# 加入 eslint prettier.md

> npm install --save-dev eslint prettier eslint-plugin-vue eslint-config-prettier

.eslintrc.js

```js
module.exports = {
    extends: [
        'plugin:vue/vue3-essential',
        'prettier'
    ],
    rules: {
        'vue/no-unused0vars' : 'error'
    }
}
```

.prettierrc.js

```js
module.exports = {
    semi: false,
    tabWidth: 4,
    useTabs: false,
    printWidth: 80,
    endOfLine: "auto",
    singleQuote: true,
    trailingComma: "es5",
    bracketSpacing: true,
    arrowParens: "always"
}
```