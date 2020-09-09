# TreeView

### 在 TreeView 的 TreeNode 上，加上 ContextMenuStrip 後，要抓 MouseClick 的 TreeNode 方式

不能透過 `TreeView.MouseDown` 的方式，因為會跳回 SelectedNode

要使用 `NodeMouseClick` 的參數 `TreeNodeMouseClickEventArgs.Node` 才會
