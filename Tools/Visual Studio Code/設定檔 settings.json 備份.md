# 設定檔 settings.json 備份

這個設定檔中，vim 的部份，只給定 <leader> 相關的部份，其餘目前暫訂都用 keybindings.json 設定。

```md
{
  "[aspnetcorerazor]": {
    "editor.defaultFormatter": "ms-dotnettools.csharp"
  },
  "[css]": {
    "editor.defaultFormatter": "esbenp.prettier-vscode"
  },
  "[html]": {
    "editor.defaultFormatter": "esbenp.prettier-vscode"
  },
  "[javascript]": {
    "editor.defaultFormatter": "esbenp.prettier-vscode"
  },
  "[typescript]": {
    "editor.defaultFormatter": "esbenp.prettier-vscode"
  },
  "[json]": {
    "editor.defaultFormatter": "esbenp.prettier-vscode"
  },
  "[markdown]": {
    "editor.defaultFormatter": "esbenp.prettier-vscode"
  },
  "[jsonc]": {
    "editor.defaultFormatter": "esbenp.prettier-vscode"
  },
  "[vue]": {
    "editor.defaultFormatter": "esbenp.prettier-vscode"
  },
  "[csharp]": {
    "editor.defaultFormatter": "ms-dotnettools.csharp"
  },
  "[sql]": {
    "editor.defaultFormatter": "adpyke.vscode-sql-formatter"
  },
  "blockman.n01LineHeight": 0,

  "diffEditor.wordWrap": "off",
  "diffEditor.ignoreTrimWhitespace": false,

  "editor.cursorStyle": "line",
  "editor.fontFamily": "'JetBrains Mono',Consolas, 'Courier New', monospace",
  "editor.wordWrap": "off",
  "editor.guides.indentation": false,
  "editor.guides.bracketPairs": false,
  "editor.inlayHints.enabled": "off",
  "editor.renderLineHighlight": "gutter",
  "editor.lineNumbers": "relative",
  "editor.fontSize": 16,
  "editor.formatOnSave": false,
  "editor.accessibilitySupport": "off",
  "editor.stickyScroll.enabled": true,
  "editor.inlineSuggest.enabled": true,
  "editor.minimap.renderCharacters": false,

  "files.defaultLanguage": "${activeEditorLanguage}",

  "git.autofetch": false,
  "git.openRepositoryInParentFolders": "always",

  "gitlens.defaultDateStyle": "absolute",
  "gitlens.defaultDateFormat": "YYYY/MM/DD HH:mm:",
  "gitlens.defaultTimeFormat": "HH:mm:ss",
  "gitlens.defaultDateShortFormat": "YYYY/MM/DD HH:mm:ss",
  "gitlens.hovers.currentLine.over": "line",

  "github.copilot.enable": {
    "*": true,
    "plaintext": true,
    "markdown": true,
    "scminput": false,
    "yaml": false
  },

  "html.format.wrapAttributes": "force-aligned",
  "http.proxyStrictSSL": false,

  "markdown.extension.orderedList.marker": "one",

  "prettier.printWidth": 130,
  "prettier.singleAttributePerLine": true,

  "settingsSync.ignoredExtensions": [],

  "terminal.integrated.rightClickBehavior": "default",
  "terminal.integrated.defaultProfile.windows": "Git Bash",
  "terminal.integrated.fontSize": 14,
  "terminal.integrated.cursorStyle": "line",
  "terminal.integrated.copyOnSelection": true,

  "typescript.updateImportsOnFileMove.enabled": "never",

  "vim.vimrc.enable": false,
  "editor.cursorSurroundingLines": 10,
  "vim.leader": ",",
  "vim.useSystemClipboard": true,
  "vim.incsearch": false,
  "vim.joinspaces": false,
  "vim.smartRelativeLine": true,
  "vim.showMarksInGutter": true,

  "vim.easymotion": true,
  "vim.easymotionMarkerBackgroundColor": "#FBD87F",
  "vim.easymotionMarkerFontWeight": "bold",
  "vim.easymotionMarkerForegroundColorOneChar": "#DE0079",
  "vim.easymotionKeys": "hklyuiopnmqwertzxcvbasdgjf",

  "vim.mouseSelectionGoesIntoVisualMode": true,
  "vim.surround": true,
  "vim.useCtrlKeys": true,
  "vim.ignorecase": false,
  "vim.autoindent": true,
  // 會加在這邊清單的就是不會被 vim 處理的 keybinding，換句話說就是要給 VSCode 處理的
  "vim.handleKeys": {
    // 保留搜尋
    "<C-f>": false,
    // 保留複製
    "<C-c>": false,
    // 保留貼上
    "<C-v>": false,
    // 保留新增空白頁籤
    "<C-n>": false,
    // 保留儲存
    "<C-s>": false,
    // 保留重做
    "<C-y>": false,
    // 保留復原
    "<C-z>": false,
    // github copilot trigger inline suggest
    "<A-\\>": false
  },
  "vim.normalModeKeyBindingsNonRecursive": [
    // Editor
    {
      "before": ["<leader>", "a"],
      "after": ["g", "g", "V", "G"]
    },
    {
      "before": ["<tab>"],
      "commands": ["editor.action.indentLines"]
    },
    {
      "before": ["<S-tab>"],
      "commands": ["editor.action.outdentLines"]
    },
    {
      // " <C-h> 游標 ←
      "before": ["<C-h>"],
      "commands": ["cursorLeft"]
    },
    {
      // " <C-j> 游標 ↓
      "before": ["<C-j>"],
      "commands": ["cursorDown"]
    },
    {
      // " <C-k> 游標 ↑
      "before": ["<C-k>"],
      "commands": ["cursorUp"]
    },
    {
      // " <C-l> 游標  →
      "before": ["<C-l>"],
      "commands": ["cursorRight"]
    },
    // " <Leader>; 補上字尾的 ;
    {
      "before": ["<leader>", ";"],
      "after": ["A", ";", "<c-[>"]
    },
    // " <Leader>, 補上字尾的 ,
    {
      "before": ["<leader>", ","],
      "after": ["A", ",", "<c-[>"]
    },

    // " <Home> 移至同一行最前方
    {
      "before": ["<Home>"],
      "commands": ["cursorHome"]
    },
    {
      // " <End> 移至同一行最後方
      "before": ["<End>"],
      "commands": ["cursorEnd"]
    },
    {
      // 新增空白頁籤
      "before": ["<leader>", "t", "n"],
      "commands": ["workbench.action.files.newUntitledFile"]
    },
    {
      // 關閉目前頁籤
      "before": ["<leader>", "t", "w"],
      "commands": ["workbench.action.closeActiveEditor"]
    },
    {
      // 切換至 terminal
      "before": ["<leader>", "t", "t"],
      "commands": ["workbench.action.terminal.focus"]
    },

    // " 移至外層 { }
    // """ ]} 為同一鍵，因為 } 使用頻率極高，所以只針對 } 做設定
    // """ <A-]> 移至所在 { } block 的 }
    // nnoremap <A-]> ]}
    // " <A-[> 移至所在 { } block 的 {
    // nnoremap <A-[> [{
    // " <A-0> 移至所在 ( ) block 的 )
    // nnoremap <A-0> ])
    // " <A-9> 移至所在 ( ) block 的 (
    // nnoremap <A-9> [(
    {
      // " <Leader>f <PageDown>
      "before": ["<leader>", "f"],
      "commands": ["cursorPageDown"]
    },
    {
      // " <leader>b <PageUp>
      "befere": ["<leader>", "b"],
      "commands": ["cursorPageUp"]
    },

    // " <Leader>ne 移至同檔案內下一個錯誤
    // nnoremap <Leader>ne :action GotoNextError<CR>

    // github copilot 相關
    {
      "before": ["<leader>", "c", "a"],
      "commands": ["workbench.panel.chat.view.copilot.focus"]
    },
    {
      "before": ["<leader>", "c", "i"],
      "commands": ["inlineChat.start"]
    },

    // mapping 至 easy-motion
    {
      "before": [" "],
      // 跳躍點為後續輸入的第一個字元
      "after": ["leader", "leader", "s"]
      // 跳躍點為 word 的開頭
      // "after": ["leader", "leader", "leader", "b", "d", "w"]
      // 跳躍點為單字的開頭
      // "after": ["leader", "leader", "leader", "j"]
    },
  ],
  "vim.insertModeKeyBindingsNonRecursive": [],
  "vim.visualModeKeyBindingsNonRecursive": [
    // Editor
    {
      "before": ["<leader>", "a"],
      "commands": ["editor.action.selectAll"]
    },
    {
      "before": ["<tab>"],
      "commands": ["editor.action.indentLines"]
    },
    {
      "before": ["<S-tab>"],
      "commands": ["editor.action.outdentLines"]
    },

    // github copilot 相關
    {
      "before": ["<leader>", "c", "a"],
      "commands": ["workbench.panel.chat.view.copilot.focus"]
    },
    {
      "before": ["<leader>", "c", "i"],
      "commands": ["inlineChat.start"]
    }
  ],

  "workbench.colorTheme": "Default Dark+",
  "workbench.tree.indent": 32,
  "workbench.startupEditor": "none",
  "workbench.colorCustomizations": {
    "editor.lineHighlightBackground": "#1073cf2d",
    "editor.lineHighlightBorder": "#9fced11f"
  },
  "github.copilot.editor.enableAutoCompletions": true
}

```