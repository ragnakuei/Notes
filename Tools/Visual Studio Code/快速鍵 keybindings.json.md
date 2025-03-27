# 快速鍵 keybindings.json

## 常用設定值

原則

> 與 Rider 儘量一致

注意事項

> command / when 區分大小寫
> 有時不知道為何，會變成全部小寫，這會導致 binding 失敗 !

開啟

> Preferences: Open Keyboard Shortcuts (JSON)

輸入

```json
[
  {
    "key": "shift+alt+l",
    "command": "workbench.view.explorer",
    "when": "editorFocus"
  },
  {
    "key": "shift+alt+o",
    "command": "revealFileInOS",
    // "when": "editorFocus"
  },
  {
    "key": "alt+cmd+r",
    "command": "-revealfileinos",
    "when": "editorFocus"
  },
  // ------------------------------
  // 以下是 vim 設定
  // ------------------------------
  {
    "key": "ctrl+w",
    "command": "editor.action.smartSelect.expand",
    "when": "editorTextFocus && vim.active && ( vim.mode == 'Normal' || vim.mode == 'Visual')"
  },
  {
    "key": "ctrl+d",
    "command": "editor.action.duplicateSelection",
    "when": "editorTextFocus && vim.active && vim.mode == 'Visual'"
  },
  {
    "key": "ctrl+d",
    "command": "editor.action.copyLinesDownAction",
    "when": "editorTextFocus && vim.active && ( vim.mode == 'Normal' || vim.mode == VisualLine' )"
  },
  {
    "key": "shift+alt+j",
    "command": "editor.action.moveLinesDownAction",
    "when": "editorTextFocus && vim.active && (vim.mode == 'Normal' || vim.mode == 'Visual' || vim.mode == 'Insert' || vim.mode == VisualLine')"
  },
  {
    "key": "shift+alt+k",
    "command": "editor.action.moveLinesUpAction",
    "when": "editorTextFocus && vim.active && (vim.mode == 'Normal' || vim.mode == 'Visual' || vim.mode == 'Insert' || vim.mode == VisualLine')"
  },
  // navigation
  {
    "key": "alt+j",
    "command": "editor.action.insertCursorBelow",
    "when": "editorTextFocus && vim.active && (vim.mode == 'Normal' || vim.mode == 'Visual' || vim.mode == 'Insert' || vim.mode == VisualLine')"
  },
  {
    "key": "alt+k",
    "command": "editor.action.insertCursorAbove",
    "when": "editorTextFocus && vim.active && (vim.mode == 'Normal' || vim.mode == 'Visual' || vim.mode == 'Insert' || vim.mode == VisualLine')"
  },
  {
    "key": "alt+h",
    "command": "workbench.action.navigateBack",
    "when": "editorTextFocus && vim.active && (vim.mode == 'Normal' || vim.mode == 'Visual' || vim.mode == 'Insert' || vim.mode == VisualLine')"
  },
  {
    "key": "alt+l",
    "command": "workbench.action.navigateForward",
    "when": "editorTextFocus && vim.active && (vim.mode == 'Normal' || vim.mode == 'Visual' || vim.mode == 'Insert' || vim.mode == VisualLine')"
  },
  {
    "key": "alt+u",
    "command": "references-view.findReferences",
    "when": "editorTextFocus && vim.active && vim.mode == 'Normal'"
  },
  {
    "key": "alt+m",
    "command": "editor.action.referenceSearch.trigger",
    "when": "editorTextFocus && vim.active && vim.mode == 'Normal'"
  },
  {
    "key": "alt+j",
    "command": "editor.action.goToImplementation",
    "when": "editorTextFocus && vim.active && vim.mode == 'Normal'"
  },
  {
    "key": "alt+k",
    // "command": "editor.action.gotosupermethod",
    "command": "references-view.showSupertypes",
    "when": "editorTextFocus && vim.active && vim.mode == 'Normal'"
  },
  {
    "key": "alt+i",
    "command": "gotoNextPreviousMember.previousMember",
    "when": "editorTextFocus && vim.active && vim.mode == 'Normal'"
  },
  {
    "key": "alt+,",
    "command": "gotoNextPreviousMember.nextMember",
    "when": "editorTextFocus && vim.active && vim.mode == 'Normal'"
  },
  {
    "key": "alt+=",
    "command": "workbench.action.gotoSymbol",
    "when": "editorTextFocus && vim.active"
  },
  {
    "key": "shift+5",
    "command": "extension.matchitJumpItems",
    "when": "editorTextFocus && vim.active && vim.mode != 'insert'"
  },
  {
    "key": "ctrl+shift+d",
    "command": "editor.action.addSelectionToNextFindMatch",
    "when": "editorfocus"
  },
  // ------------------------------
  // 以上是 vim 設定
  // ------------------------------
  {
    "key": "ctrl+t",
    "command": "-extension.vim_ctrl+t",
    "when": "editorTextFocus && vim.active && vim.use<c-t> && !indebugrepl"
  },
  {
    "key": "ctrl+t",
    "command": "-extension.vim_ctrl+t",
    "when": "editorTextFocus && vim.active && vim.use<C-t> && !inDebugRepl"
  },
  {
    "key": "ctrl+j",
    "command": "-workbench.action.togglepanel"
  },
  {
    "key": "ctrl+j",
    "command": "-extension.vim_ctrl+j",
    "when": "editorTextFocus && vim.active && vim.use<c-j> && !indebugrepl"
  },
  {
    "key": "ctrl+k",
    "command": "-extension.vim_ctrl+k",
    "when": "editorTextFocus && vim.active && vim.use<c-k> && !indebugrepl"
  },
  {
    "key": "ctrl+-",
    "command": "editor.fold",
    "when": "editorTextFocus && foldingEnabled"
  },
  {
    "key": "ctrl+=",
    "command": "editor.unfold",
    "when": "editorTextFocus && foldingEnabled"
  },
  {
    "key": "shift+alt+o",
    "command": "-editor.action.organizeimports",
    "when": "textinputfocus && !editorreadonly && supportedcodeaction =~ /(\\s|^)source\\.organizeimports\\b/"
  },
  {
    "key": "ctrl+d",
    "command": "-editor.action.addSelectionToNextFindMatch",
    "when": "editorfocus"
  },
  {
    "key": "ctrl+d",
    "command": "-notebook.addFindMatchToSelection",
    "when": "config.notebook.multiCursor.enabled && notebookCellEditorfocused && activeEditor == 'workbench.editor.notebook'"
  },
  {
    "key": "ctrl+0",
    "command": "workbench.action.zoomReset"
  },
  {
    "key": "ctrl+0",
    "command": "-workbench.action.focusSideBar"
  },
]
```
