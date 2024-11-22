# 快速鍵 keybindings.json

## 常用設定值

原則

> 與 Rider 儘量一致

開啟

> Preferences: Open Keyboard Shortcuts (JSON)

輸入

```json
[
  {
    "key": "ctrl+shift+d",
    "command": "editor.action.addSelectionToNextFindMatch",
    "when": "editorFocus"
  },
  {
    "key": "shift+cmd+e",
    "command": "-workbench.view.explorer",
    "when": "viewContainer.workbench.view.explorer.enabled"
  },
  {
    "key": "shift+alt+l",
    "command": "workbench.view.explorer"
  },
  {
    "key": "shift+alt+o",
    "command": "revealFileInOS",
    "when": "!editorFocus"
  },
  {
    "key": "alt+cmd+r",
    "command": "-revealFileInOS",
    "when": "!editorFocus"
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
    "when": "editorTextFocus && vim.active && (vim.mode == 'Visual')"
  },
  {
    "key": "ctrl+d",
    "command": "editor.action.copyLinesDownAction",
    "when": "editorTextFocus && vim.active && ( vim.mode == 'Normal' || vim.mode == 'VisualLine')"
  },
  {
    "key": "shift+alt+j",
    "command": "editor.action.moveLinesDownAction",
    "when": "editorTextFocus && vim.active && (vim.mode == 'Normal' || vim.mode == 'Visual' || vim.mode == 'Insert' || vim.mode == 'VisualLine')"
  },
  {
    "key": "shift+alt+k",
    "command": "editor.action.moveLinesUpAction",
    "when": "editorTextFocus && vim.active && (vim.mode == 'Normal' || vim.mode == 'Visual' || vim.mode == 'Insert' || vim.mode == 'VisualLine')"
  },

  // navigation
  {
    "key": "alt+j",
    "command": "editor.action.insertCursorBelow",
    "when": "editorTextFocus && vim.active && (vim.mode == 'Normal' || vim.mode == 'Visual' || vim.mode == 'Insert' || vim.mode == 'VisualLine')"
  },
  {
    "key": "alt+k",
    "command": "editor.action.insertCursorAbove",
    "when": "editorTextFocus && vim.active && (vim.mode == 'Normal' || vim.mode == 'Visual' || vim.mode == 'Insert' || vim.mode == 'VisualLine')"
  },
  {
    "key": "alt+h",
    "command": "workbench.action.navigateBack",
    "when": "editorTextFocus && vim.active && (vim.mode == 'Normal' || vim.mode == 'Visual' || vim.mode == 'Insert' || vim.mode == 'VisualLine')"
  },
  {
    "key": "alt+l",
    "command": "workbench.action.navigateForward",
    "when": "editorTextFocus && vim.active && (vim.mode == 'Normal' || vim.mode == 'Visual' || vim.mode == 'Insert' || vim.mode == 'VisualLine')"
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
    "command": "editor.action.goToSuperMethod",
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
  }
]

```
