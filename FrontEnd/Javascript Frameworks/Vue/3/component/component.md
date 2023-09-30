# component

前置說明：特殊情境

> 在 vue instance 宣告時，以 html 來給定 template，而不是以 template property 來給定

-   通常在輕前端 vue 的 vue instance 宣告時，都是預先以 html 來給定 template
-   原因：因為先寫在 html 內，會優先經過 browser 的處理

注意事項

-   假設 component 名稱為 test，在 `特殊情境` 下，最好以 \<test>\</test> 來呼叫，而不要以 \<test /> 來呼叫

    -   非 `特殊情境` 下，則沒有此限制
    -   這種語法在加入第二個相同 component 時，就只會 render 第一個 component !

-   命名

    -   `特殊情境` 下，就只能以 kebab-case 來呼叫 component
    -   非 `特殊情境` 下，其他地方都可以用以下的 case 來呼叫 component

        -   kebab-case

            -   例：\<test-component>\</test-component>

        -   camelCase

            -   例：\<testComponent>\</testComponent>

        -   PascalCase
            -   例：\<TestComponent>\</TestComponent>

    -   註冊 component 時，不受限制，可以用任何 case
        -   例：Vue.component('testComponent', { ... })

    - 透過 props 在 vue componentn 間傳遞資料時，也適用 `特殊情境` 下的規則
