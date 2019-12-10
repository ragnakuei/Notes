# npm

| 指令                            | 功能                        | 參考連結                                 |
| ------------------------------- | --------------------------- | ---------------------------------------- |
| npm outdated                    | 檢查已安裝的套件是否過期(?) | https://docs.npmjs.com/cli/outdated.html |
| npm install [package][@version] | 安裝 / Upgrade 套件         | https://docs.npmjs.com/cli/install.html  |

## package.json

npm 套件版號意思

> major.minor.patch

而 `"serialize-javascript": "^2.1.3"`

就是指該套件的

- major version 2
- minor version 1
- patch version 3

出處

> [Semantic Versioning](https://semver.org/)

版號開頭

- `~` tilde - 可升級到 相同 major version 以及 minor version 最新的版本
- `^` caret - 可升級到 相同 major version 、minor version 以及 patch version 最新的版本
