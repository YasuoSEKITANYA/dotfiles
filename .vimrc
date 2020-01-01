" auto reload .vimrc
"
augroup source-vimrc
    autocmd!
    autocmd BufwritePost *vimrc source $MYVIMRC | set foldmethod=marker
augroup END

let s:is_windows=has('win32')||has('win64')
let s:is_mac=has('mac')
let s:vimfiles_dir=expand($HOME.'/.vim')

let s:backup_dir=s:vimfiles_dir.'/.vim/backup'
let s:undo_dir=s:vimfiles_dir.'/.vim/undo'

"========== dein scripts ============
"
"
let s:dein_dir=s:vimfiles_dir . '/.cache/dein'
let s:dein_repo_dir=s:dein_dir . '/repos/github.com/Shougo/dein.vim'
let s:dein_toml_dir=s:vimfiles_dir . '/.config/dein'

if match(&runtimepath, '/dein.vim') == -1
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
    execute 'set runtimepath+=' . fnamemodify(s:dein_repo_dir, ':p')
endif

if dein#load_state(s:dein_dir)
    call dein#begin(s:dein_dir)

    call dein#add(s:dein_repo_dir)
    call dein#add('Shougo/neosnippet.vim')
    call dein#add('Shougo/neosnippet-snippets')
    call dein#add('altercation/vim-colors-solarized')
    call dein#add('scrooloose/nerdtree')
    call dein#add('thinca/vim-quickrun')
    call dein#add('vim-airline/vim-airline')
    call dein#add('szw/vim-tags')
    call dein#add('majutsushi/tagbar')
    call dein#load_toml(s:dein_toml_dir . '/plugins_lazy.toml', {'lazy': 1})

    call dein#end()
    call dein#save_state()
endif

filetype plugin indent on

if dein#check_install()
  call dein#install()
endif

"===== display und etw ======
set wrap
set title
set number
set ruler
set cursorline
set showmatch
set matchtime=3
set visualbell
set showcmd
"set textwidth=80
"set lines=50
"set columns=180
set display=lastline
set pumheight=10
let &t_ti.="\e[5 q" "なにこれ
set cmdheight=1
set list
set listchars=tab:^_,trail:-,extends:>,precedes:<,nbsp:%
set laststatus=2
set linespace=0
set guioptions-=T
set guioptions-=m
set guioptions+=R

set helplang=en,ja


"======== search =====
set ignorecase
set smartcase
set wrapscan
set hlsearch
set incsearch
nnoremap noh :noh<CR>


"============= edit ==========
let mapleader=','
set virtualedit=block
set autoindent
"set cindent
set smartindent
set whichwrap=b,s,h,l,<,>,[,],~
set backspace=indent,eol,start
set clipboard=unnamed
set pastetoggle=<F12>

set history=1000
set wildmode=full
set wildmenu
set undofile
execute 'set undodir='. s:undo_dir


"======== encode =========
set fileencodings=utf-8,cp932,sjis,euc-jp
set encoding=utf-8
set fenc=utf-8

"============ tab ==========
set smarttab
set expandtab
set tabstop=4
set shiftwidth=4
set shiftround

"====== backup ======
set backup
execute 'set backupdir='.s:backup_dir
"set nobackup
set noswapfile

"======== color ========
colorscheme solarized
set background=dark
"set background=light
syntax enable
highlight StatusLine ctermfg=black ctermbg=10

let g:solarized_termcolors=16
let g:solarized_termtrans=1
let g:solarized_degrade=0
let g:solarized_bold=1
let g:solarized_underline=1
let g:solarized_italic=1
let g:solarized_contrast='normal'
let g:solarized_visibility='normal'


"========== commandmap ===========

vnoremap <BS> d
nnoremap <CR> A<CR><Esc>

inoremap [ []<Left>
inoremap [<Enter> []<Left><CR><Esc><S-o>
inoremap { {}<Left>
inoremap {<Enter> {}<Left><CR><Esc><S-o>
inoremap ( ()<Left>
inoremap (<Enter> ()<Left><CR><Esc><S-o>

"英字キーボードの時のみ有効にしましょう
nnoremap ; :

nnoremap s <Nop>
nnoremap s<Space> g*<C-o>
nnoremap sg g*

inoremap <C-k> <Up>
inoremap <C-j> <Down>
inoremap <C-h> <Left>
inoremap <C-l> <Right>

inoremap <C-f> <Esc>
vnoremap <C-f> <Esc>

nnoremap <silent> st :tabnew<CR>
nnoremap <silent> sv :vsplit<CR>
nnoremap <silent> ss :split<CR>
nnoremap <Up> <C-w>3-
nnoremap <Down> <C-w>3+
nnoremap <Right> <C-w>3>
nnoremap <Left> <C-w>3<
inoremap <Up> <C-w>3-
inoremap <Down> <C-w>3+
inoremap <Right> <C-w>3>
inoremap <Left> <C-w>3<

nnoremap <silent> sh ^
vnoremap <silent> sh ^
nnoremap <silent> sl $
vnoremap <silent> sl $

"======== plugins ============
"

" NerdTree
let g:NERDTreeWinSize=20
let g:NERDTreeShowHidden=1
let g:NERDTreeIgnore=['\.git$', '\.swp$', '\~$']
let g:NERDTreeQuitOnOpen=1
nnoremap <C-o> :NERDTreeToggle<CR>
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q |
let g:NERDTreeDirArrowExpandable='+'
let g:NERDTreeDirArrowCollapsible='^'

" airline
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#show_buffers=0
let g:airline#extensions#tabline#tab_nr_type=1
let g:airline#extensions#ale#enabled=1
let g:airline#extensions#tagbar#enabled=1
let g:airline#extensions#virtualenv#enabled=1
let g:airline_inactive_collapse=0
let g:airline_powrline_fonts=1


" quickrun
let g:quickrun_config={}
let g:quickrun_config={
            \'_':{
            \'outputter/buffer/split':':botright',
            \'outputter':'error',
            \'outputter/error/success':'quickfix',
            \'outputter/error/error':'quickfix',
            \'outputter/buffer/close_on_empty':1,
            \},
            \'cpp':{
            \'outputter/buffer/split':'botright 8sp',
            \'command':'g++',
            \'cmdopt':'-std=c++17 -Wall -pedantic',
            \},
            \'tex':{
            \'command':'latexmk',
            \'cmdopt':'-pdfdvi',
            \'outputter/error/success':'null',
            \'hook/cd/directory':'%S:h',
            \'hook/sweep/files':[
            \                    '%S:p:r.aux',
            \                    '%S:p:r.bbl',
            \                    '%S:p:r.blg',
            \                    '%S:p:r.dvi',
            \                    '%S:p:r.fdb_latexmk',
            \                    '%S:p:r.fls',
            \                    '%S:p:r.out',
            \                    '%S:p:r.log'
            \                   ],
            \'exec':'%c %o %a %s',
            \},
\}

let g:quickrun_config.tmptex={}
let g:quickrun_config.tmptex={
            \'exec':[
            \       'mv %s %a/tmptex.tex',
            \       'latexmk -pdfdvi -pv -output-directory=%a %a/tmptex.tex',
            \],
            \'args':expand("%:p:h:gs?\\\\?/?"),
            \'outputter':'error',
            \'outputter/error/error':'quickfix',
            \'hook/eval/enable':1,
            \'hook/eval/cd':"%s:r",
            \'hook/eval/template':'\documentclass{jsarticle}'
            \                       .'\usepackage[dvipdfmx]{graphicx}'
            \                       .'\usepackage{amsmath,amssymb,amsthm,ascmac}'
            \                       .'\usepackage{multicol}'
            \                       .'\usepackage{enumerate}'
            \                       .'\allowdisplaybreaks[1]'
            \                       .'\newcommand{\E}{\mathbb{E}}'
            \                       .'\newcommand{\V}{\mathbb{V}ar}'
            \                       .'\renewcommand{\P}{\mathbb{P}}'
            \                       .'\newcommand{\iid}{\overset{\small{iid}}{\sim}}'
            \                       .'\newcommand{\1}{\mbox{1} \hspace{-0.25em} \mbox{l}}'
            \                       .'\begin{document}'
            \                       .'%s'
            \                       .'\end{document}',
            \'hook/sweep/files':[
            \                       '%a/tmptex.tex',
            \                       '%a/tmptex.out',
            \                       '%a/tmptex.fdb_latexmk',
            \                       '%a/tmptex.log',
            \                       '%a/tmptex.aux',
            \                       '%a/tmptex.dvi'
            \],
\}
"======= file type ==========

augroup vimrc_loading
  autocmd!
  autocmd BufNewFile,BufRead *.{vimrc,toml,vim} set filetype=vim
  autocmd BufNewFile,BufRead *.{c,cpp,h,hpp} set filetype=cpp
  autocmd BufNewFile,BufRead *.{tex} set filetype=tex
  autocmd BufNewFile,BufRead *.{f90,f95} set filetype=fortran
augroup END

function! s:cpp()
    setlocal tabstop=2
    setlocal shiftwidth=2
    nnoremap <buffer><C-t> :QuickRun cpp<CR>
endfunction


function! s:tex()
    nnoremap <buffer><C-t> :QuickRun tex<CR>
    vnoremap <buffer><C-t> :QuickRun -mode v -type tmptex<CR>
    vnoremap <silent><buffer><C-t> :QuickRun -mode v -type tmptex<CR>
    inoremap <buffer>$ $$<Left>
    inoremap <buffer>\[<Enter> \[\]<Left><Left><CR><Esc><S-o>
endfunction

function! s:fortran()
    setlocal tabstop=4
    setlocal shiftwidth=4
    setlocal noexpandtab
endfunction


augroup vimrc_ft
  autocmd!
  autocmd FileType cpp call s:cpp()
  autocmd FileType tex call s:tex()
  autocmd FileType fortran call s:fortran()
augroup END
