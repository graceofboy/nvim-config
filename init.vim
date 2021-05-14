set autochdir
set mouse=a
set nocompatible
syntax on
set t_Co=256
set autoindent
set scrolloff=5
set showmatch
set hlsearch
set incsearch
set smartcase
set nobackup
set undofile
set directory=~/.vim/.swp//
set undodir=~/.vim/.undo//
set noerrorbells
set history=1000
set autoread
set ts=2 sw=2
set backspace=2
set showtabline=0
set laststatus=0
set background=dark

set encoding=utf-8                                  
set termencoding=utf-8
set fileencoding=utf-8
let mapleader=","
set langmenu=zh_CN.UTF-8

nmap <silent> <Leader>f :e%:h<CR>
vmap <silent> <Leader>f :e%:h<CR>

map <silent> <A-h> <C-w><
map <silent> <A-j> <C-W>-
map <silent> <A-k> <C-W>+
map <silent> <A-l> <C-w>>


" 中文测试
" copy some with system
set clipboard+=unnamedplus
""let g:clipboard = {
""      \   'name': 'myClipboard',
""      \   'copy': {
""      \      '+': 'pbcopy',
""      \      '*': 'pbcopy',
""      \    },
""      \   'paste': {
""      \      '+': 'pbpaste',
""      \      '*': 'pbpaste',
""      \   },
""      \   'cache_enabled': 1,
""      \ }
""

call plug#begin('~/.config/nvim/plugged')
Plug 'fatih/vim-go', { 'tag': '*' }
Plug 'drewtempelmeyer/palenight.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'airblade/vim-rooter'
Plug 'easymotion/vim-easymotion'
Plug 'Raimondi/delimitMate'
Plug 'voldikss/vim-translator'
Plug 'diepm/vim-rest-console'
call plug#end()

colorscheme palenight
let g:lightline = { 'colorscheme': 'palenight' }
let g:airline_theme = "palenight"
if (has("nvim"))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
if (has("termguicolors"))
  set termguicolors
endif
" Italics for my favorite color scheme
let g:palenight_terminal_italics=1
let g:palenight_color_overrides = {
\    'black': { 'gui': '#000000', "cterm": "0", "cterm16": "0" },
\}

" fzf % vimroot
function! s:find_git_root()
  return system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
endfunction
command! ProjectFiles execute 'Files' s:find_git_root()
function! s:change_to_project(project)
exec 'tabedit '.a:project
exec 'lcd '.a:project
endfunction
command! Project call fzf#run(fzf#wrap({'sink': function('s:change_to_project'), 'source': "find ~/WorkSpace -type d -exec test -e '{}/.git' ';' -print -prune"}))
map <C-f> :ProjectFiles<CR>
map <C-p> :Project<CR>
map <C-h> :History<CR>
map <C-s> :BLines<CR>
map <C-b> :Buffers<CR>
" TOOD: 解决fzf快速切换窗口报E315的错误？
let g:fzf_prefer_tmux = 1

" coc
" Formatting selected code.
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" vim-go
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_term_enabled = 1
nmap <silent> <Leader>t :GoTestFunc<CR>
vmap <silent> <Leader>t :GoTestFunc<CR>

"" easymotion
nmap s <Plug>(easymotion-overwin-f2)
" Move to line
nmap <C-l> <Plug>(easymotion-overwin-line)

" nvim terminal exit insert mode
" 会影响fzf按esc退出问题
" tnoremap <Esc> <C-\><C-n>

""" Translate Configuration example
" Echo translation in the cmdline
" nmap <silent> <Leader>t <Plug>Translate
" vmap <silent> <Leader>t <Plug>TranslateV
" Display translation in a window
nmap <silent> <Leader>w <Plug>Translate
vmap <silent> <Leader>w <Plug>TranslateV
" Replace the text with translation
nmap <silent> <Leader>r <Plug>TranslateR
vmap <silent> <Leader>r <Plug>TranslateRV
" Translate the text in clipboard
nmap <silent> <Leader>x <Plug>TranslateX

" http client
let g:vrc_split_request_body = 1
