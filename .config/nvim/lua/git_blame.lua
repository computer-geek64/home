-- Git blame and hunk tooling on top of gitsigns.nvim (pack/github/start/gitsigns.nvim).
--
-- Blame shows in two layers:
--   * inline: author, relative date and commit subject as virtual text after the cursor line;
--   * expanded: <leader>gb opens a float with the full commit message (GOAT ticket, Change-Id)
--     and the diff hunk from that commit for the current file, <leader>gB opens a scroll-locked
--     blame column for the whole file (`s` shows the commit, `r` re-blames at its parent, `q` quits).
-- Hunk signs, preview and navigation come with the same plugin and share the gutter.
--
-- Mappings are buffer-local and only exist on buffers inside a git work tree.

local M = {}

M.opts = {
    current_line_blame = true,
    current_line_blame_opts = {
        delay = 300,              -- ms the cursor must rest before the inline text appears
        virt_text_pos = 'right_align',
        ignore_whitespace = true  -- `git blame -w`: skip Spotless reformatting commits
    },
    current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
    preview_config = {
        border = 'rounded',
    },
    on_attach = function (bufnr)
        local gs = require('gitsigns')
        local function map(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, {buffer = bufnr, desc = desc})
        end

        -- Blame
        map('n', '<leader>gb', function () gs.blame_line{full = true} end, 'Blame line (full commit and diff)')
        map('n', '<leader>gB', gs.blame, 'Blame whole file')
        -- map('n', '<leader>gt', gs.toggle_current_line_blame, 'Toggle inline blame')

        -- Hunks (uncommitted changes against the index)
        map('n', '<leader>gp', gs.preview_hunk, 'Preview hunk')
        -- ]c / [c are Vim's diff-mode motions; keep them when the window is in diff mode
        map('n', ']c', function ()
            if vim.wo.diff then
                vim.cmd.normal{']c', bang = true}
            else
                gs.nav_hunk('next')
            end
        end, 'Next hunk')
        map('n', '[c', function ()
            if vim.wo.diff then
                vim.cmd.normal{'[c', bang = true}
            else
                gs.nav_hunk('prev')
            end
        end, 'Previous hunk')
    end
}

function M.setup(opts)
    require('gitsigns').setup(vim.tbl_deep_extend('force', M.opts, opts or {}))
end

return M
