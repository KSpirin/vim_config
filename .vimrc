" ============================================================
" ~/.vimrc
" Plugin-free Vim configuration
" ============================================================

set nocompatible


" ============================================================
" Basic UI & Colors (256-color pink/purple accents)
" ============================================================
set background=dark
set t_Co=256
syntax on

set number
set cursorline
set scrolloff=3
set nowrap

set laststatus=2
set showcmd
set wildmenu
set wildmode=longest:full,full

" CursorLine & StatusLine
highlight CursorLine   cterm=underline ctermbg=NONE
highlight StatusLine   ctermfg=213 ctermbg=236 cterm=bold
highlight StatusLineNC ctermfg=244 ctermbg=235 cterm=NONE

set statusline=\ %f\ %m%r%=%#Comment#[Space\ ?:Help\ \|\ Space\ o:Only\ \|\ Space\ q:Close\ \|\ Space\ Q:Quit]%*\ \ %l:%c\ (%p%%)\ 

highlight Comment      ctermfg=146 cterm=italic
highlight String       ctermfg=213
highlight Constant     ctermfg=213
highlight Number       ctermfg=210 cterm=bold
highlight Identifier   ctermfg=141
highlight Function     ctermfg=141 cterm=bold
highlight Statement    ctermfg=211 cterm=bold
highlight PreProc      ctermfg=141
highlight Type         ctermfg=111
highlight Special      ctermfg=213

set matchtime=3
highlight MatchParen ctermbg=213 ctermfg=black cterm=bold


" ============================================================
" Rainbow braces & parentheses — () and {} nested 4-color highlight
" ============================================================
let g:c_no_curly_error = 1
let g:c_no_bracket_error = 1

function! RainbowBraces()
    silent! syn clear cParen cBlock cBracket cCppParen cCppBracket
    silent! syn clear javaParen javaParen1 javaParen2

    syn region rainbowB4 matchgroup=rainbowCol4 start="{" end="}" transparent contains=TOP
    syn region rainbowP4 matchgroup=rainbowCol4 start="(" end=")" transparent contains=TOP
    syn region rainbowB3 matchgroup=rainbowCol3 start="{" end="}" transparent contains=TOP,rainbowB1,rainbowB2,rainbowB3,rainbowP1,rainbowP2,rainbowP3
    syn region rainbowP3 matchgroup=rainbowCol3 start="(" end=")" transparent contains=TOP,rainbowB1,rainbowB2,rainbowB3,rainbowP1,rainbowP2,rainbowP3
    syn region rainbowB2 matchgroup=rainbowCol2 start="{" end="}" transparent contains=TOP,rainbowB1,rainbowB2,rainbowP1,rainbowP2
    syn region rainbowP2 matchgroup=rainbowCol2 start="(" end=")" transparent contains=TOP,rainbowB1,rainbowB2,rainbowP1,rainbowP2
    syn region rainbowB1 matchgroup=rainbowCol1 start="{" end="}" transparent contains=TOP,rainbowB1,rainbowP1
    syn region rainbowP1 matchgroup=rainbowCol1 start="(" end=")" transparent contains=TOP,rainbowB1,rainbowP1

    highlight rainbowCol1 ctermfg=213 cterm=bold
    highlight rainbowCol2 ctermfg=210 cterm=bold
    highlight rainbowCol3 ctermfg=141 cterm=bold
    highlight rainbowCol4 ctermfg=111 cterm=bold
endfunction

augroup rainbow_braces
    autocmd!
    autocmd FileType c,cpp,java,javascript,json,python call RainbowBraces()
augroup END


" ============================================================
" Splits
" ============================================================
set splitbelow
set splitright


" ============================================================
" Leader
" ============================================================
let mapleader = " "


" ============================================================
" Tabs / Indentation
" ============================================================
set tabstop=4
set shiftwidth=4
set softtabstop=4

set expandtab
set autoindent


" ============================================================
" Search
" ============================================================
set hlsearch
set incsearch

set ignorecase
set smartcase

set wildignorecase


" ============================================================
" Quality of Life
" ============================================================
set clipboard^=unnamed,unnamedplus
set hidden
set history=1000

set backspace=indent,eol,start

set autoread
augroup auto_checktime
    autocmd!
    autocmd FocusGained,BufEnter * checktime
augroup END

set backup
set swapfile
set undofile


" ============================================================
" Backup / Swap / Undo
" ============================================================
if !isdirectory(expand("~/.vim/backup"))
    call mkdir(expand("~/.vim/backup"), "p")
endif

if !isdirectory(expand("~/.vim/swap"))
    call mkdir(expand("~/.vim/swap"), "p")
endif

if !isdirectory(expand("~/.vim/undo"))
    call mkdir(expand("~/.vim/undo"), "p")
endif

set backupdir=~/.vim/backup//
set directory=~/.vim/swap//
set undodir=~/.vim/undo//


" ============================================================
" Filetype Support
" ============================================================
filetype plugin indent on

augroup filetype_settings
    autocmd!

    autocmd FileType yaml,json,html,css,javascript
        \ setlocal tabstop=2 shiftwidth=2 softtabstop=2

    autocmd FileType markdown,text
        \ setlocal wrap linebreak
augroup END


" ============================================================
" Remember Cursor Position
" ============================================================
augroup remember_cursor
    autocmd!
    autocmd BufReadPost *
        \ if line("'\"") > 1 && line("'\"") <= line("$") |
        \ execute "normal! g`\"" |
        \ endif
augroup END


" ============================================================
" Built-in File Explorer — netrw
" ============================================================
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_winsize = 25

nnoremap <leader>e :Lexplore<CR>


" ============================================================
" File Find / Grep
" ============================================================
set path+=**

set wildignore+=**/node_modules/**
set wildignore+=**/.git/**
set wildignore+=**/target/**
set wildignore+=**/build/**
set wildignore+=**/__pycache__/**
set wildignore+=*.class
set wildignore+=*.pyc

nnoremap <leader>f :find<Space>

if executable('rg')
    set grepprg=rg\ --vimgrep\ --smart-case
    set grepformat=%f:%l:%c:%m
endif

nnoremap <leader>/ :grep<Space>

augroup quickfix_auto
    autocmd!
    autocmd QuickFixCmdPost [^l]* cwindow
augroup END


" ============================================================
" Search
" ============================================================
nnoremap <leader>h :nohlsearch<CR>


" ============================================================
" Window Navigation & Management
" ============================================================
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

nnoremap <leader>v :vsplit<CR>
nnoremap <leader>s :split<CR>

" Panic button: always find a code window and close all other panels/splits (including running terminals)
function! KeepOnlyCodeWindow()
    for wnr in range(winnr('$'), 1, -1)
        let bnr = winbufnr(wnr)
        if getbufvar(bnr, '&buftype') ==# 'terminal' && winnr('$') > 1
            execute wnr . 'wincmd c'
        endif
    endfor
    if &buftype ==# 'quickfix' || &buftype ==# 'terminal' || &filetype ==# 'netrw'
        for wnr in range(1, winnr('$'))
            let bnr = winbufnr(wnr)
            if getbufvar(bnr, '&buftype') ==# '' && getbufvar(bnr, '&filetype') !=# 'netrw'
                execute wnr . 'wincmd w'
                break
            endif
        endfor
    endif
    cclose
    lclose
    silent! only
endfunction

nnoremap <leader>o :call KeepOnlyCodeWindow()<CR>


" ============================================================
" Buffer Navigation
" ============================================================
nnoremap <leader><leader> <C-^>
nnoremap <leader>bn :bnext<CR>
nnoremap <leader>bp :bprevious<CR>
nnoremap <leader>bd :bdelete<CR>


" ============================================================
" Quickfix Navigation
" ============================================================
nnoremap <leader>co :copen<CR>
nnoremap <leader>cc :cclose<CR>
nnoremap <leader>cn :cnext<CR>
nnoremap <leader>cp :cprevious<CR>


" ============================================================
" Git
" ============================================================
nnoremap <leader>gs :!git status<CR>
nnoremap <leader>gd :!git diff<CR>
nnoremap <leader>gl :!git log --oneline --decorate --graph -20<CR>
nnoremap <leader>ga :!git add -- %:S<CR>


" ============================================================
" Save / Quit
" ============================================================
nnoremap <leader>w :write<CR>
nnoremap <leader>q :quit<CR>
nnoremap <leader>Q :qa<CR>


" ============================================================
" Useful Editing
" ============================================================
vnoremap < <gv
vnoremap > >gv
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv


" ============================================================
" Terminal (Seamless navigation + no stacked splits)
" ============================================================
tnoremap <Esc><Esc> <C-\><C-n>
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l

function! OpenBottomTerminal(cmd)
    " Close any existing terminal window in this tab so splits never stack up
    for wnr in range(winnr('$'), 1, -1)
        let bnr = winbufnr(wnr)
        if getbufvar(bnr, '&buftype') ==# 'terminal'
            execute wnr . 'wincmd c'
            if !empty(a:cmd) || term_getstatus(bnr) =~# 'finished'
                silent! execute 'bwipeout! ' . bnr
            endif
        endif
    endfor

    if empty(a:cmd)
        botright 12split | terminal
    else
        execute 'botright 12split | terminal ++shell ' . a:cmd
    endif
endfunction

nnoremap <leader>t :call OpenBottomTerminal('')<CR>


" ============================================================
" Compile / Run (Auto-replaces old runner split)
" ============================================================
augroup code_runner
    autocmd!
    autocmd FileType c
        \ nnoremap <buffer> <leader>r :w<CR>:call OpenBottomTerminal('cc ' . shellescape(expand('%')) . ' -o /tmp/vim_run_' . getpid() . ' && /tmp/vim_run_' . getpid())<CR>
    autocmd FileType cpp
        \ nnoremap <buffer> <leader>r :w<CR>:call OpenBottomTerminal('c++ -std=c++20 ' . shellescape(expand('%')) . ' -o /tmp/vim_run_' . getpid() . ' && /tmp/vim_run_' . getpid())<CR>
    autocmd FileType java
        \ nnoremap <buffer> <leader>r :w<CR>:call OpenBottomTerminal('javac ' . shellescape(expand('%')) . ' && java -cp ' . shellescape(expand('%:p:h')) . ' ' . shellescape(expand('%:t:r')))<CR>
    autocmd FileType python
        \ nnoremap <buffer> <leader>r :w<CR>:call OpenBottomTerminal('python3 ' . shellescape(expand('%')))<CR>
augroup END


" ============================================================
" Built-in Cheat Sheet (Space ?)
" ============================================================
function! ShowCheatSheet()
    echohl Statement | echo "=== Space (Leader) Quick Reference ===" | echohl None
    echohl Constant  | echon "\n [Panic / Close]  " | echohl None
    echon "Space o: Keep ONLY code  |  Space q: Close window  |  Space Q: Quit Vim  |  Esc Esc: Exit terminal"
    echohl Constant  | echon "\n [Windows]        " | echohl None
    echon "Ctrl+h/j/k/l: Move window       |  Space v: V-Split       |  Space s: H-Split"
    echohl Constant  | echon "\n [Files & Search] " | echohl None
    echon "Space w: Save  |  Space e: Explorer  |  Space f: Find file  |  Space /: Grep  |  Space h: Clear highlight"
    echohl Constant  | echon "\n [Buffers]        " | echohl None
    echon "Space Space: Last file          |  Space bn/bp: Next/Prev |  Space bd: Close buffer"
    echohl Constant  | echon "\n [Run & Tools]    " | echohl None
    echon "Space r: Run code               |  Space t: Terminal      |  Space cn/cp: Next/Prev search result"
endfunction

nnoremap <leader>? :call ShowCheatSheet()<CR>