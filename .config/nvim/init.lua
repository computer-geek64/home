-- Source standard vimrc
--vim.cmd.source(vim.fn.stdpath('config') .. '/vimrc.vim')
vim.cmd.source('~/.vimrc')


-- Color scheme
vim.cmd.colorscheme('kanagawa')

-- Highlight groups
local teal = '#008080'
local blue = '#223249'
local purple = '#43436c'
local tan = '#c8c093'
local orange = '#e98a00'
--vim.cmd.highlight('Normal guibg=NONE')  -- Transparent background
vim.cmd.highlight('StatusLine gui=NONE guifg=White guibg=' .. purple)
vim.cmd.highlight('StatusLineNC gui=NONE guifg=White guibg=Black')
vim.cmd.highlight('StatusLineWindowNumber gui=bold guifg=Black guibg=' .. tan)
vim.cmd.highlight('StatusLineFilename gui=bold guifg=White guibg=' .. teal)
vim.cmd.highlight('StatusLineReadOnly gui=NONE guifg=White guibg=Red')
vim.cmd.highlight('StatusLineCursorPosition gui=NONE guifg=Black guibg=' .. tan)
vim.cmd.highlight('StatusLineFileType gui=bold guifg=White guibg=' .. blue)
vim.cmd.highlight('QuickFixLine gui=NONE guifg=Black guibg=' .. orange)
vim.cmd.highlight('NonText gui=underdashed guifg=#727169')


-- Mappings
vim.keymap.set('n', '<C-/>', 'gcc', {remap = true})
vim.keymap.set('n', '<C-_>', '<C-/>', {remap = true})
vim.keymap.set('v', '<C-/>', 'gc', {remap = true})
vim.keymap.set('v', '<C-_>', '<C-/>', {remap = true})
vim.keymap.set('i', '<C-Space>', '<C-x><C-o>')  -- Ctrl+Space activates omni complete in insert mode
vim.keymap.set('n', '<A-LeftMouse>', '<C-]>')  -- Command+LMB jumps to tag definition (macOS does not natively support <C-LeftMouse>)
vim.keymap.set('n', 'K', function ()
    vim.lsp.buf.hover{border = 'rounded'}
end)  -- Use rounded borders for LSP hover window
vim.keymap.set('n', '<C-h>', function ()
    vim.lsp.buf.references({
        includeDeclaration = true
    }, {
        loclist = true
    })
end)  -- Ctrl+k opens quickfix window of references
vim.keymap.set('n', '<C-Space>', function ()  -- Ctrl+Space opens diagnostic window in normal mode
    vim.diagnostic.open_float({
        scope = 'line'
    })
end)


-- Treesitter
require('nvim-treesitter.configs').setup{
    ensure_installed = {'lua', 'vim', 'vimdoc', 'markdown', 'markdown_inline', 'json', 'yaml', 'python', 'bash'},
    sync_install = false,
    auto_install = true,
    highlight = {
        enable = true,
    },
    textobjects = {
        select = {
            enable = true,
            lookahead = true,
            keymaps = {
                ['if'] = '@function.inner',
                ['af'] = '@function.outer',
                ['ic'] = '@class.inner',
                ['ac'] = '@class.outer',
                ['ib'] = '@block.inner',
                ['ab'] = '@block.outer',
                ['ia'] = '@assignment.inner',
                ['aa'] = '@assignment.outer',
                ['<a'] = '@assignment.lhs',
                ['>a'] = '@assignment.rhs',
                ['ip'] = '@parameter.inner',
                ['ap'] = '@parameter.outer'
            }
        },
        move = {
            enable = true,
            goto_next_start = {
                [']p'] = { query = '@parameter.inner', desc = 'Next parameter start' }
            },
            goto_previous_start = {
                ['[p'] = '@parameter.inner'
            }
        }
    }
}
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.opt.foldlevel = 99


-- LSP
-- Define vim.fs.root for older Neovim versions
if vim.fn.has('nvim-0.10') == 0 then
    vim.fs.root = function (source, marker)
        return vim.fs.dirname(
            vim.fs.find(
                marker,
                {upward = true}
            )[1]
        )
    end
end

-- Python
vim.lsp.config('pyright', {
    root_dir = vim.fs.root(0, {
        '.git',
        'pyrightconfig.json',
        'pyproject.toml',
        'requirements.txt'
    })
})

-- Golang
vim.lsp.config('gopls', {
    root_dir = vim.fs.root(0, {
        '.git',
        'go.mod',
        'go.work'
    })
})

-- Java
vim.lsp.config('jdtls', {
    root_dir = vim.fs.root(0, {
        '.git'
    })
})

vim.lsp.enable{'pyright', 'gopls', 'jdtls'}

-- Git blame (inline and expandable) and hunk signs via gitsigns.nvim; see lua/git_blame.lua.
require('git_blame').setup()
