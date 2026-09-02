" ============================================================
" ~/.vimrc
" Plugin-free Vim configuration
" ============================================================

set nocompatible


" ============================================================
" Basic UI
" ============================================================
syntax on

set number
set cursorline
set scrolloff=3
set nowrap

set laststatus=2
set showcmd
set wildmenu
set wildmode=longest:full,full
set signcolumn=yes

" CursorLine
highlight CursorLine cterm=underline ctermbg=NONE


" ============================================================
" Color — pink/purple accents + bracket matching (256-color)
" ============================================================
set background=dark
set t_Co=256

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
" Rainbow braces
" ============================================================
function! RainbowBraces()
    syn region rainbowLvl1 matchgroup=rainbowCol1 start="{" end="}" fold transparent contains=rainbowLvl2,@Spell
    syn region rainbowLvl2 matchgroup=rainbowCol2 start="{" end="}" fold transparent contains=rainbowLvl3,@Spell contained
    syn region rainbowLvl3 matchgroup=rainbowCol3 start="{" end="}" fold transparent contains=rainbowLvl4,@Spell contained
    syn region rainbowLvl4 matchgroup=rainbowCol4 start="{" end="}" fold transparent contains=rainbowLvl1,@Spell contained

    highlight rainbowCol1 ctermfg=213 cterm=bold
    highlight rainbowCol2 ctermfg=210 cterm=bold
    highlight rainbowCol3 ctermfg=141 cterm=bold
    highlight rainbowCol4 ctermfg=111 cterm=bold
endfunction

augroup rainbow_braces
    autocmd!
    autocmd FileType c,cpp,java,javascript,json call RainbowBraces()
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
set smartindent


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
set clipboard=unnamedplus
set hidden
set history=1000
set updatetime=300

set backspace=indent,eol,start

set autoread
autocmd FocusGained,BufEnter * checktime

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

    autocmd FileType java,cpp,c,python
        \ setlocal expandtab autoindent smartindent
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

nnoremap <leader>f :find 

if executable('rg')
    set grepprg=rg\ --vimgrep\ --smart-case
    set grepformat=%f:%l:%c:%m
endif

nnoremap <leader>/ :grep 


" ============================================================
" Search
" ============================================================
nnoremap <leader>h :nohlsearch<CR>


" ============================================================
" Window Navigation
" ============================================================
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l


" ============================================================
" Buffer Navigation
" ============================================================
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
nnoremap <leader>ga :!git add %<CR>


" ============================================================
" Save / Quit
" ============================================================
nnoremap <leader>w :write<CR>
nnoremap <leader>q :quit<CR>


" ============================================================
" Useful Editing
" ============================================================
vnoremap < <gv
vnoremap > >gv
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv


" ============================================================
" Terminal
" ============================================================
nnoremap <leader>t :botright 12split \| terminal<CR>


" ============================================================
" Compile / Run  (++shell = actually run via shell, so && works)
" ============================================================

augroup c_run
    autocmd!
    autocmd FileType c
        \ nnoremap <buffer> <leader>r :w<CR>:botright 12split \| terminal ++shell cc % -o /tmp/a.out && /tmp/a.out<CR>
augroup END

augroup cpp_run
    autocmd!
    autocmd FileType cpp
        \ nnoremap <buffer> <leader>r :w<CR>:botright 12split \| terminal ++shell c++ -std=c++20 % -o /tmp/a.out && /tmp/a.out<CR>
augroup END

augroup java_run
    autocmd!
    autocmd FileType java
        \ nnoremap <buffer> <leader>r :w<CR>:botright 12split \| terminal ++shell javac % && java %:r<CR>
augroup END

augroup python_run
    autocmd!
    autocmd FileType python
        \ nnoremap <buffer> <leader>r :w<CR>:botright 12split \| terminal ++shell python3 %<CR>
augroup END