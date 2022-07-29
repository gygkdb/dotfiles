set background=dark
colorscheme default

let mapleader = ','
let g:mapleader = ','
syntax on
set history=2000
filetype on
filetype plugin on
filetype indent on
set nocompatible
set autoread
set shortmess=atI
set magic
set title
set nobackup
set novisualbell
set noerrorbells
set visualbell t_vb=
set t_vb=
set tm=500
set cursorline
set scrolloff=7
set ruler
set number
set nowrap
set showcmd
set showmode
set showmatch
set matchtime=2
set hlsearch
set incsearch
set ignorecase
set smartcase
set expandtab
set smarttab
set shiftround
set autoindent smartindent shiftround
set shiftwidth=4
set tabstop=4
set softtabstop=4
set foldenable
set foldmethod=indent
set foldlevel=99
let g:FoldMethod = 0
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
set termencoding=utf-8
set ffs=unix,dos,mac
set formatoptions+=m
set formatoptions+=B
set selection=inclusive
set selectmode=mouse,key
set completeopt=longest,menu
set wildmenu
set wildmode=longest,list,full
set wildignore=*.o,*~,*.pyc,*.class
set backspace=indent,eol,start
set whichwrap+=<,>,h,l
hi! link SignColumn   LineNr
hi! link ShowMarksHLl DiffAdd
hi! link ShowMarksHLu DiffChange
set statusline=%<%f\ %h%m%r%=%k[%{(&fenc==\"\")?&enc:&fenc}%{(&bomb?\",BOM\":\"\")}]\ %-14.(%l,%c%V%)\ %P
set laststatus=2
set mouse=a

" fold
map <leader>zz :call ToggleFold()<cr>
fun! ToggleFold()
    if g:FoldMethod == 0
        exe "normal! zM"
        let g:FoldMethod = 1
    else
        exe "normal! zR"
        let g:FoldMethod = 0
    endif
endfun

" if this not work ,make sure .viminfo is writable for you
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" ============================ key map ============================
nnoremap k gk
nnoremap gk k
nnoremap j gj
nnoremap gj j
nnoremap <c-d> 7gj
nnoremap <c-u> 7gk

map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

nnoremap <F2> :set nu! nu?<CR>
nnoremap <F3> :set list! list?<CR>
nnoremap <F4> :set wrap! wrap?<CR>
set pastetoggle=<F5>            "    when in insert mode, press <F5> to go to
                                "    paste mode, where you can paste mass data
                                "    that won't be autoindented
au InsertLeave * set nopaste
nnoremap <F6> :exec exists('syntax_on') ? 'syn off' : 'syn on'<CR>

" map ctrl+q as Esc
inoremap <c-q> <Esc>

" Quickly close the current window
nnoremap <leader>q :q<CR>
" Quickly save the current file
nnoremap <leader>w :w<CR>

" select all
map <Leader>sa ggVG"

" remap U to <C-r> for easier redo
nnoremap U <C-r>

" Swap implementations of ` and ' jump to markers
" By default, ' jumps to the marked line, ` jumps to the marked line and
" column, so swap them
nnoremap ' `
nnoremap ` '

"Keep search pattern at the center of the screen."
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz

" remove highlight
noremap <silent><leader>/ :nohls<CR>

"Reselect visual block after indent/outdent.
vnoremap < <gv
vnoremap > >gv

" y$ -> Y Make Y behave like other capitals
map Y y$

"Map ; to : and save a million keystrokes
nnoremap ; :

" Shift+H goto head of the line, Shift+L goto end of the line
nnoremap H ^
nnoremap L $

" save
cmap w!! w !sudo tee >/dev/null %

" command mode, ctrl-a to head， ctrl-e to tail
cnoremap <C-j> <t_kd>
cnoremap <C-k> <t_ku>
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
