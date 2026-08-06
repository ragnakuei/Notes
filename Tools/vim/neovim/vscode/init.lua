-- =====================================================================
-- init.lua  ·  vscode-neovim  (由 .ideavimrc 轉換)
-- 位置: %LOCALAPPDATA%\nvim\init.lua
--
-- 說明:Alt / Ctrl+Shift / Shift+Tab 等「VSCode 預設不會送進 neovim」的
--       鍵,幾乎都在 keybindings.json。此檔只放:
--         (1) 設定
--         (2) leader(逗號) 系列 —— 會自動送進 neovim
--         (3) 少數預設就會送進 neovim 的 Ctrl 鍵 (u, m, t, i)
-- =====================================================================

vim.g.mapleader = ','

vim.opt.ignorecase = true
vim.opt.smartcase  = true
vim.opt.incsearch  = true
vim.opt.hlsearch   = true
vim.opt.clipboard  = 'unnamedplus'      -- 對應 set clipboard+=unnamed

-- 純終端 nvim 專用(VSCode 內這些由 VSCode 掌管,見 settings.json)
if not vim.g.vscode then
  vim.opt.scrolloff      = 10
  vim.opt.number         = true
  vim.opt.relativenumber = true
end

-- 清除搜尋高亮(兩邊都適用)
vim.keymap.set('n', '<leader>sc', '<Cmd>nohlsearch<CR>')
vim.keymap.set('n', '<Esc>',      '<Cmd>nohlsearch<CR><Esc>')

-- ---------- 外掛管理:lazy.nvim ----------
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    'git', 'clone', '--filter=blob:none', '--branch=stable',
    'https://github.com/folke/lazy.nvim.git', lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  {
    'kylechui/nvim-surround',
    version = '*',        -- 跟最新穩定 tag
    lazy = false,         -- vscode-neovim 下直接載入最穩,別用 VeryLazy 免得不觸發
    config = function()
      require('nvim-surround').setup({})
    end,
  },
  { import = 'plugins' },
})

-- 純終端 nvim 到此為止,以下全部只在 VSCode 內
if not vim.g.vscode then
  return
end

-- ===================== VSCode 專用 =====================
local vscode = require('vscode')
local function cmd(id) return function() vscode.action(id) end end
local map = vim.keymap.set

-- ---- 會自動送進 neovim 的 Ctrl 鍵 (u,m,t,i 在預設清單內) ----
map({ 'n', 'x', 'o' }, '<C-u>', '^')       -- 行首 (原 <Home>)
map({ 'n', 'x', 'o' }, '<C-m>', 'g_')      -- 行尾 (原 <End>);注意 <C-m> == Enter
map({ 'n', 'x' },      '<C-t>', cmd('workbench.action.quickOpen')) -- 近似 SearchEverywhere

-- ---- 選取 ----
map('n', '<leader>a', 'ggVG')
map('x', '<leader>a', '<Esc>ggVG')

-- ---- 補字尾 (leader 是逗號,故 <leader>, 為連按兩下逗號) ----
map('n', '<leader>;', 'A;<C-[>')
map('n', '<leader>,', 'A,<C-[>')

-- ---- 括號 block 移動 (vim 動作;需 keybindings.json 把 Alt 鍵送進來) ----
map({ 'n', 'x', 'o' }, '<A-]>', ']}')      -- 移至所在 { } 的 }
map({ 'n', 'x', 'o' }, '<A-[>', '[{')      -- 移至所在 { } 的 {
map({ 'n', 'x', 'o' }, '<A-0>', '])')      -- 移至所在 ( ) 的 )
map({ 'n', 'x', 'o' }, '<A-9>', '[(')      -- 移至所在 ( ) 的 (

-- ---- 視窗 / 工具視窗 ----
map({ 'n', 'x' }, '<leader>gc', cmd('workbench.view.scm'))            -- Commit -> 原始碼控制
map({ 'n', 'x' }, '<leader>gs', cmd('outline.focus'))                -- Structure -> 大綱
map({ 'n', 'x' }, '<leader>gt', cmd('workbench.view.testing.focus')) -- 測試視窗
map({ 'n', 'x' }, '<leader>vs', cmd('outline.focus'))
map({ 'n', 'x' }, '<leader>vt', cmd('workbench.view.testing.focus'))

-- ---- 一般 ----
map({ 'n', 'x' }, '<leader>rf', cmd('editor.action.formatDocument')) -- ReformatCode
map('n',          '<leader>ne', cmd('editor.action.marker.next'))    -- GotoNextError

-- ---- 分頁 ----
map('n', '<leader>tw',  cmd('workbench.action.closeActiveEditor'))
map('n', '<leader>tcb', cmd('workbench.action.closeEditorsToTheRight'))
map('n', '<leader>tca', cmd('workbench.action.closeEditorsToTheLeft'))
map('n', '<leader>tt',  cmd('workbench.action.focusNextGroup'))
map('n', '<leader>tp',  cmd('workbench.action.pinEditor'))

-- ---- 檔案 ----
map('n', '<leader>cf', cmd('explorer.newFile'))                      -- NewFile

-- ---- 重構 (C# 重構統一由 Refactor 選單挑,見說明) ----
local refactor = cmd('editor.action.refactor')
map({ 'n', 'x' }, '<leader>il', refactor)  -- Inline
map({ 'n', 'x' }, '<leader>iv', refactor)  -- IntroduceVariable
map({ 'n', 'x' }, '<leader>if', refactor)  -- IntroduceField
map({ 'n', 'x' }, '<leader>ip', refactor)  -- IntroduceParameter
map({ 'n', 'x' }, '<leader>em', refactor)  -- ExtractMethod
map('n',          '<leader>ei', refactor)  -- ExtractInterface
map({ 'n', 'x' }, '<leader>sw', refactor)  -- SurroundWith 近似(文字環繞建議 nvim-surround)

-- ---- AI (預設對應 GitHub Copilot Chat 擴充;若用別的工具請自行改) ----
map({ 'n', 'x' }, '<leader>ca', cmd('workbench.action.chat.open'))   -- Copilot Chat
map({ 'n', 'x' }, '<leader>cs', cmd('workbench.action.chat.open'))
map('n',          '<leader>co', cmd('workbench.action.chat.open'))
map({ 'n', 'x' }, '<leader>ci', cmd('inlineChat.start'))            -- Inline Chat

-- ---- 版控 ----
map('n', '<leader>gr', cmd('git.clean'))       -- Revert(捨棄變更;破壞性)
map('n', '<leader>gf', cmd('git.openChange'))  -- Compare

-- ---- 單元測試 (需 C# 測試擴充支援 VSCode Testing API) ----
map('n', '<leader>ut',  cmd('testing.runAtCursor'))
map('n', '<leader>udt', cmd('testing.debugAtCursor'))
map('n', '<leader>uat', cmd('testing.runAll'))


-- HTML / Razor 類檔案:補上 matchit 的標籤配對規則,讓 % 能跳 <tag> ↔ </tag>
vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, {
  pattern = {
    '*.html', '*.htm', '*.xml', '*.xhtml',
    '*.cshtml', '*.razor', '*.vbhtml', '*.aspx', '*.ascx',
    '*.vue', '*.svelte', '*.jsx', '*.tsx',
  },
  callback = function()
    vim.b.match_ignorecase = 1
    vim.b.match_words = table.concat({
      '<:>',
      [[<\@<=[ou]l\>[^>]*\%(>\|$\):<\@<=li\>:<\@<=/[ou]l>]],
      [[<\@<=dl\>[^>]*\%(>\|$\):<\@<=d[td]\>:<\@<=/dl>]],
      [[<\@<=\([^/][^ \t>]*\)[^>]*\%(>\|$\):<\@<=/\1>]],
    }, ',')
  end,
})

-- =====================================================================
-- 尚未轉換 / 需你決定的項目(見對話說明):
--   AceJump (<space>, <leader>j*) -> 需 flash.nvim 外掛或 VSCode 跳躍擴充
--   MoveStatement / MethodUp/Down / GotoSuperMethod -> VSCode 無精準對應
-- =====================================================================
