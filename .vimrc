syntax on
set background=dark
set shell=/bin/bash
set number relativenumber
set scrolloff=10
set history=200
set colorcolumn=80


" Indentation
set autoindent
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab


" Search
set ignorecase
set smartcase
set hlsearch
set incsearch


" Status line
set laststatus=2
set statusline=%#StatusLineWindowNumber#\ %{tabpagewinnr(tabpagenr())}\ %*
set statusline+=%#StatusLineFilename#\ %.50F%(\ %M%)\ %*
set statusline+=%#StatusLineReadOnly#%r%*%<%=
set statusline+=%#StatusLineCursorPosition#\ %3p%%\ [%3c:%-4l]%*
set statusline+=%#StatusLineFileType#\ %Y\ %*


" Tab line
function GetTabLine()
    let s = ''
    for i in range(tabpagenr('$'))
        if i + 1 == tabpagenr()
            let s ..= '%#TabLineSel#'
        else
            let s ..= '%#TabLine#'
        endif

        let s ..= '%' .. (i + 1) .. 'T ' .. (i + 1) .. ' %{GetTabLabel(' .. (i + 1) .. ')} '
    endfor

    let s ..= '%T%#TabLineFill#'

    return s
endfunction

function GetTabLabel(n)
    let buflist = tabpagebuflist(a:n)
    let winnr = tabpagewinnr(a:n)
    let label = bufname(buflist[winnr - 1])
    return label == '' ? '[No Name]' : label
endfunction

set tabline=%!GetTabLine()


" File-specific options
autocmd FileType go,gitconfig setlocal noexpandtab  "autocmd BufEnter *.go


" Key bindings
nnoremap <C-h> <C-6>  " Ctrl+h jumps to alternate file
nnoremap <C-n> <C-PageDown>  " Ctrl+n switches to next tab
nnoremap <C-p> <C-PageUp>  " Ctrl+p switches to previous tab
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"  " If popup is visible in insert mode, treat Ctrl+j as next
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"  " If popup is visible in insert mode, treat Ctrl+k as previous

noremap <Up> :echo "Use k!"<Enter>
noremap <Down> :echo "Use j!"<Enter>
noremap <Left> :echo "Use h!"<Enter>
noremap <Right> :echo "Use l!"<Enter>
noremap <PageUp> :echo "Use Ctrl+b!"<Enter>
noremap <PageDown> :echo "Use Ctrl+f!"<Enter>
noremap <C-Up> :echo "Use k!"<Enter>
noremap <C-Down> :echo "Use j!"<Enter>
noremap <C-Left> :echo "Use b!"<Enter>
noremap <C-Right> :echo "Use w!"<Enter>


" Highlight groups
" Search
highlight Search cterm=none ctermfg=Black ctermbg=3
highlight CurSearch cterm=bold ctermfg=Black ctermbg=Yellow
highlight IncSearch cterm=none ctermfg=Black ctermbg=Yellow

" Status line
highlight StatusLine cterm=none ctermfg=White ctermbg=Red
highlight StatusLineNC cterm=none ctermfg=White ctermbg=Black
highlight StatusLineWindowNumber cterm=bold ctermfg=Black ctermbg=Yellow
highlight StatusLineFilename cterm=bold ctermfg=White ctermbg=6
highlight StatusLineReadOnly cterm=none ctermfg=White ctermbg=Red
highlight StatusLineCursorPosition cterm=none ctermfg=Black ctermbg=Yellow
highlight StatusLineFileType cterm=bold ctermfg=White ctermbg=6

" Tab line
