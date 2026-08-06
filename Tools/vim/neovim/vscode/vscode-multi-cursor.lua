return {
  {
    'vscode-neovim/vscode-multi-cursor.nvim',
    cond = not not vim.g.vscode,
    lazy = false,
    opts = {
      default_mappings = true,
      no_selection = false,
    },
    keys = {
    },
  },
}