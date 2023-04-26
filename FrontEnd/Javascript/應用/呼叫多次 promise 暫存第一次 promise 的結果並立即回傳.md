# 呼叫多次 promise 暫存第一次 promise 的結果並立即回傳

- 按下 click_button ，可以觸發多次 get_user_info() ，但只會執行一次 mock_api() ，並且立即回傳第一次執行的結果

```js
async function click_button() {
    const user_info = await get_user_info();
    console.log('user_info', user_info);
}

window.user_info = null;
let userInfoPromise = null;
async function get_user_info() {
    if (window.user_info) {
        console.log('window.user_info is not null');
        return new Promise((resolve) => {
            resolve(window.user_info);
        });        
    } else {
        if (!userInfoPromise) {
            console.log('userInfoPromise is null');
            userInfoPromise = mock_api()
                .then((data) => {
                    console.log('data', data);
                    window.user_info = data;
                    userInfoPromise = null;
                    return data;
                });
        }

        return userInfoPromise;
    }
}

function mock_api() {
    return new Promise((resolve) => {
        setTimeout(() => {
            console.log('mock_api()');
            resolve({
                name: 'John',
                age: 18,
            });
        }, 3000);
    });
}
```
