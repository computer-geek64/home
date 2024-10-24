-- Source standard vimrc
--vim.cmd.source(vim.fn.stdpath('config') .. '/vimrc.vim')
vim.cmd.source('~/.vimrc')


-- Color scheme
vim.cmd.colorscheme('kanagawa')

-- Status line colors
local teal = '#008080'
local blue = '#223249'
local purple = '#43436c'
local tan = '#c8c093'
local orange = '#e98a00'
vim.cmd.highlight('Normal guibg=NONE')
vim.cmd.highlight('StatusLine gui=NONE guifg=White guibg=' .. purple)
vim.cmd.highlight('StatusLineNC gui=NONE guifg=White guibg=Black')
vim.cmd.highlight('StatusLineWindowNumber gui=bold guifg=Black guibg=' .. tan)
vim.cmd.highlight('StatusLineFilename gui=bold guifg=White guibg=' .. teal)
vim.cmd.highlight('StatusLineReadOnly gui=NONE guifg=White guibg=Red')
vim.cmd.highlight('StatusLineCursorPosition gui=NONE guifg=Black guibg=' .. tan)
vim.cmd.highlight('StatusLineFileType gui=bold guifg=White guibg=' .. blue)


-- Mappings
vim.keymap.set('n', '<C-j>', '<C-]>')  -- Ctrl+j jumps to tag definition
vim.keymap.set('n', '<C-k>', '<C-w>}<C-w>k')  -- Ctrl+k opens tag definition in preview window
vim.keymap.set('i', '<C-Space>', '<C-x><C-o>')  -- Ctrl+Space activates omni complete


-- LSP
-- Python
require 'lspconfig'.pyright.setup{
    root_dir = vim.fs.root(0, {
        '.git',
        'pyrightconfig.json',
        'pyproject.toml',
        'requirements.txt'
    })
}

-- Golang
require 'lspconfig'.gopls.setup{
    root_dir = vim.fs.root(0, {
        '.git',
        'go.mod',
        'go.work'
    })
}
