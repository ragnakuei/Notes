# [Prettier - Code formatter](https://marketplace.visualstudio.com/items?itemName=esbenp.prettier-vscode)

- 目前用過最強大的 format 套件，可支援各式各樣的語法，包含 markdown

- 安裝完套件後，記得把 vscode 預設的 formatter 指向至此套件

## [設定檔案教學](https://glebbahmutov.com/blog/configure-prettier-in-vscode/)

1. 在該專案安裝套件

   > npm install --save-dev --save-exact prettier

1. 在該專案根目錄下建立檔案 `.prettierrc.json`

   範例

   ```json
   {
     "trailingComma": "all",
     "tabWidth": 4,
     "semi": true,
     "singleQuote": true
   }
   ```
