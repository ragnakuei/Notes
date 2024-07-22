# Loading Spinner

## 只在特定的 DOM 上顯示

```html
<!DOCTYPE html>
<html lang="zh-TW">
    <head>
        <meta charset="UTF-8" />
        <title>Loading Spinner 示例</title>
        <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
            rel="stylesheet"
            integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
            crossorigin="anonymous"
        />
        <style>
            .loading-spinner-overlay {
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                display: flex;
                justify-content: center;
                align-items: center;
                background: rgba(255, 255, 255, 0.8);
                z-index: 10;
            }

            .relative-container {
                position: relative;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <p>這裡是不會被覆蓋的 HTML 元素內容</p>
            <div id="targetElement" class="relative-container">
                <p>這裡是要被覆蓋的 HTML 元素內容</p>
                <p>被 Loading Spinner 覆蓋後，按 tab 也無法進入該區域 !</p>
                <form>
                    <div class="mb-3">
                        <label for="exampleInputEmail1" class="form-label"
                            >Email address</label
                        >
                        <input
                            type="email"
                            class="form-control"
                            id="exampleInputEmail1"
                            aria-describedby="emailHelp"
                        />
                        <div id="emailHelp" class="form-text">
                            We'll never share your email with anyone else.
                        </div>
                    </div>
                    <div class="mb-3">
                        <label for="exampleInputPassword1" class="form-label"
                            >Password</label
                        >
                        <input
                            type="password"
                            class="form-control"
                            id="exampleInputPassword1"
                        />
                    </div>
                    <div class="mb-3 form-check">
                        <input
                            type="checkbox"
                            class="form-check-input"
                            id="exampleCheck1"
                        />
                        <label class="form-check-label" for="exampleCheck1"
                            >Check me out</label
                        >
                    </div>
                    <button type="submit" class="btn btn-primary">
                        Submit
                    </button>
                </form>
            </div>
            <button id="loadingButton" class="btn btn-primary mt-3">
                顯示 Loading Spinner
            </button>
            <button id="removeButton" class="btn btn-danger mt-3">
                移除 Loading Spinner
            </button>
        </div>

        <script>
            window.onload = function () {
                const targetElement = document.getElementById('targetElement');

                document
                    .getElementById('loadingButton')
                    .addEventListener('click', function () {
                        const spinner = `<div class="loading-spinner-overlay">
                                            <div class="spinner-border" role="status">
                                                <span class="visually-hidden">Loading...</span>
                                            </div>
                                        </div>`;

                        targetElement.insertAdjacentHTML('beforeend', spinner);

                        // 停用 tabindex 屬性，把 input / button 的 tabindex 放到 prev-tabindex 屬性中
                        targetElement
                            .querySelectorAll('input')
                            .forEach((input) =>
                                moveTabIndexToPrevTabIndex(input),
                            );
                        targetElement
                            .querySelectorAll('button')
                            .forEach((button) =>
                                moveTabIndexToPrevTabIndex(button),
                            );
                    });

                function moveTabIndexToPrevTabIndex(element) {
                    const tabIndex = element.getAttribute('tabindex');
                    element.setAttribute('prev-tabindex', tabIndex);
                    element.removeAttribute('tabindex');

                    // 停用 tabindex 屬性
                    element.setAttribute('tabindex', '-1');
                }

                function movePrevTabIndexToTabIndex(element) {
                    const prevTabIndex = element.getAttribute('prev-tabindex');
                    element.setAttribute('tabindex', prevTabIndex);
                    element.removeAttribute('prev-tabindex');
                }

                document
                    .getElementById('removeButton')
                    .addEventListener('click', function () {
                        const loadingSpinnerOverlay =
                            targetElement.querySelector(
                                '.loading-spinner-overlay',
                            );

                        if (loadingSpinnerOverlay) {
                            // 把原先的 tabindex 放回 tabindex 屬性中
                            targetElement
                                .querySelectorAll('input')
                                .forEach((input) =>
                                    movePrevTabIndexToTabIndex(input),
                                );
                            targetElement
                                .querySelectorAll('button')
                                .forEach((button) =>
                                    movePrevTabIndexToTabIndex(button),
                                );

                            loadingSpinnerOverlay.remove();
                        }
                    });
            };
        </script>
    </body>
</html>
```
