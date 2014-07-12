" ------------------------------------------------------------------------------
" Environment
" ------------------------------------------------------------------------------
silent function! OSX()
    return has('macunix')
endfunction

silent function! LINUX()
    return has('unix') && !has('macunix') && !has('win32unix')
endfunction

silent function! WINDOWS()
    return (has('win16') || has('win32') || has('win64'))
endfunction

" ------------------------------------------------------------------------------
" Basics
" ------------------------------------------------------------------------------
if &compatible                                      " Only if not set before"
    set nocompatible                                " Use VIM defaults instead
endif

" Shell according to system
if !WINDOWS()
    set shell=/bin/bash
endif

" Windows compatible
if WINDOWS()
    set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
endif

" Font according system
if LINUX()
    set guifont=Inconsolata\ 14
else
    set guifont=Consolas:h12
endif

" Use before config if available
if filereadable(expand("~/.vimrc.before"))
    source ~/.vimrc.before
endif

" Use bundles config
if filereadable(expand("~/.vimrc.bundles"))
    source ~/.vimrc.bundles
endif


" ------------------------------------------------------------------------------
" Display
" ------------------------------------------------------------------------------
filetype plugin indent on                           " Automatically detect file types

if &t_Co > 2 || has("gui_running")
    syntax on                                       " Syntax hightlighting
    set hlsearch                                    " Highlight search terms
    set incsearch                                   " Find as you type search
endif

set background=dark                                 " Assume a Dark background
set scrolljump=5                                    " Lines to scroll when cursor leaves screen
set scrolloff=3                                     " Minimum lines to keep above and below cursor

if exists("&colorcolumn")
    set colorcolumn=80
endif

set cursorline                                      " Hightlight cursor line
highlight clear SignColumn
highlight clear LineNr
let g:CSApprox_hook_post = ['hi clear SignColumn']


if has('cmdline_info')
    set ruler                                       " Show the ruler
    set rulerformat=%27(%{strftime('%a\ %e\ %b\ %I:%M\ %p')}\ %2l,%-2(%c%V%)\ %P%)
    set showcmd                                     " Show partial commands in status line
endif


if has('statusline')
    set laststatus=2

    set statusline=%<%f\                                                    " Filename
    set statusline+=%w%h%m%r                                                " Options
    set statusline+=%{exists('g:loaded_fugitive')?fugitive#statusline():''} " Git Hotness
    set statusline+=\ [%{&ff}/%Y]                                           " Filetype
    set statusline+=\ [%{getcwd()}]                                         " Current dir
    set statusline+=%=%-14.(%l,%c%V%)\ %p%%                                 " Right aligned file nav info
endif

set showmatch                                       " Show matching brackets/parenthesis
set wildmenu                                        " Show list instead of just completing
set wildmode=list:longest,full                      " Command <Tab> completion
set whichwrap=b,s,h,l,<,>,[,]                       " Backspace and cursor keys wrap too
set title                                           " Show file in tilebar

" ------------------------------------------------------------------------------
" GUI & Term
" ------------------------------------------------------------------------------


" GVIM- (here instead of .gvimrc)
if has('gui_running')
    set guioptions-=T           " Remove the toolbar
    set lines=40                " 40 lines of text instead of 24
    if !exists("g:spf13_no_big_font")
        if LINUX() && has("gui_running")
            set guifont=Andale\ Mono\ Regular\ 12,Menlo\ Regular\ 11,Consolas\ Regular\ 12,Courier\ New\ Regular\ 14
        elseif OSX() && has("gui_running")
            set guifont=Andale\ Mono\ Regular:h12,Menlo\ Regular:h11,Consolas\ Regular:h12,Courier\ New\ Regular:h14
        elseif WINDOWS() && has("gui_running")
            set guifont=Andale_Mono:h10,Menlo:h10,Consolas:h10,Courier_New:h10
        endif
    endif
else
    if &term == 'xterm-256color' || &term == 'screen'
        set t_Co=256            " Enable 256 colors to stop the CSApprox warning and make xterm vim shine
    endif
    "set term=builtin_ansi       " Make arrow and other keys work
endif

" ------------------------------------------------------------------------------
" Colors
" ------------------------------------------------------------------------------

" Test if the default colorscheme existe
if has("gui_running") || &t_Co >= 256
    try
        colorscheme molokai
        let g:molokai_original = 1
    catch
        colorscheme torte
    endtry
elseif &t_Co >=88
    try
        colorscheme zenburn
    catch
        colorscheme torte
    endtry
elseif &t_Co >=8
    try
        colorscheme rastafari
    catch
        colorscheme torte
    endtry
endif


" ------------------------------------------------------------------------------
" Editor
" ------------------------------------------------------------------------------

set backspace=indent,eol,start                      " Backspace for dummies
set encoding=utf-8                                  " Files are encoded into utf-8
set linespace=0                                     " No extra spaces between rows
set nu                                              " Line numbers on
set winminheight=0                                  " Windows can be 0 line high
set ignorecase                                      " Case insensitive search
set smartcase                                       " Case sensitive when uc present
set smartindent                                     " Smart auto indenting

if exists("&foldenable")
    set foldenable                                  " Folding is authorized
endif

if !exists('g:Billinux_no_list')
    set list                                        " Listchars
endif
set listchars=nbsp:%,tab:>-,trail:.,extends:>,precedes:<,eol:$

set autowrite                                       " Automatically write a file when leaving a modified buffer
set shortmess+=filmnrxoOtT                          " Abbrev. of messages (avoids 'hit enter')
set viewoptions=folds,options,cursor,unix,slash     " Better Unix / Windows compatibility
set virtualedit=onemore                             " Allow for cursor beyond last character

if !exists('g:Billinux_no_spell')
    set spell                                       " Spell checking on
    set spelllang=fr
    nnoremap <leader>s :set spell!<CR>
endif

" ------------------------------------------------------------------------------
" Formatting
" ------------------------------------------------------------------------------

set shiftwidth=4                                    " Use indents of 4 spaces
set expandtab                                       " Tabs are spaces, not tab
set tabstop=4                                       " An indentation every 4 columns
set softtabstop=4                                   " Let backspace delete indent
set smarttab                                        " Smarttab handling for indenting

autocmd FileType c,cpp,java,go,php,javascript,python,twig,xml,yml,perl autocmd BufWritePre <buffer> if !exists('g:Billinux_keep_trailing_whitespace') | call StripTrailingWhitespace() | endif

" ------------------------------------------------------------------------------
" System
" ------------------------------------------------------------------------------

set hidden                                          " Allow buffer switching without saving
set mouse=a                                         " Automatically enable mouse usage
set history=1000                                    " Store a ton of history (default is 20)

" Setting up the directories
set backup                                          " Backups are nice ...
if has('persistent_undo')
    set undofile                                    " So is persistent undo ...
    set undolevels=1000                             " Maximum number of changes that can be undone
    set undoreload=10000                            " Maximum number lines to save for undo on a buffer reload
endif

" ------------------------------------------------------------------------------
" Key Mappings
" ------------------------------------------------------------------------------

nnoremap <leader>s :write<cr>
nnoremap <leader>S :saveas<space>

" Save when losing focus
au FocusLost * :wa

nnoremap q :q!<cr>
nnoremap <leader>q :qa!<cr>

" Keep hands on the keyboard
inoremap jj <ESC>
inoremap kk <ESC>
inoremap jk <ESC>

" Wrapped lines goes down/up to next row, rather than next line in file
nnoremap <silent> k :<C-U>execute 'normal!' (v:count>1 ? "m'".v:count.'k' : 'gk')<Enter>
nnoremap <silent> j :<C-U>execute 'normal!' (v:count>1 ? "m'".v:count.'j' : 'gj')<Enter>

set pastetoggle=<F10>

" Switch different kind line number
nnoremap <leader>, :set invnumber<cr>
nnoremap <leader>; :set relativenumber<cr>

" Yank from the cursor to the end of the line, to be consistent with C and D
nnoremap Y y$

" Allow using the repeat operator with a visual selection
vnoremap . :normal .<CR>

"For when you forget to sudo.. Really Write the file.
cmap w!! w !sudo tee % >/dev/nul

" Change case
nnoremap <c-u> gUiw
inoremap <c-u> <esc>gUiwea

"Indent all lines
noremap ia mzggVG='z

" Folding options
nmap <leader>f0 :set foldlevel=0<CR>
nmap <leader>f1 :set foldlevel=1<CR>
nmap <leader>f2 :set foldlevel=2<CR>
nmap <leader>f3 :set foldlevel=3<CR>
nmap <leader>f4 :set foldlevel=4<CR>
nmap <leader>f5 :set foldlevel=5<CR>
nmap <leader>f6 :set foldlevel=6<CR>
nmap <leader>f7 :set foldlevel=7<CR>
nmap <leader>f8 :set foldlevel=8<CR>
nmap <leader>f9 :set foldlevel=9<CR>

noremap <leader><space> :noh<cr>
" To clear search highlighting rather than toggle it and off
""if !exists('g:Billinux_clear_search_highlight')
    ""nmap <silent> <leader><space> :nohlsearch<CR>
    ""noremap <leader><space> :noh<cr>:call clearmatches()<cr>
""    noremap <leader><space> :noh<cr>
""else
""    nmap <silent> <leader><space> :invhlsearch<CR>
""endif

" ------------------------------------------------------------------------------
" Plugins
" ------------------------------------------------------------------------------
"
if filereadable(expand("~/.vimrc.plugins.config"))
    source ~/.vimrc.plugins.config
endif

" ------------------------------------------------------------------------------
" Functions
" ------------------------------------------------------------------------------

" Initialize directories
function! InitializeDirectories()
    let parent = $HOME
    let prefix = 'vim'
    let dir_list = {
        \ 'backup': 'backupdir',
        \ 'views': 'viewdir',
        \ 'swap': 'directory' }

    if has('persistent_undo')
        let dir_list['undo'] = 'undodir'
    endif

    " To specify a different directory in which to place the vimbackup,
    " vimviews, vimundo, and vimswap files/directories, add the following to
    " your .vimrc.before.local file:
    "   let g:Billinux_consolidated_directory = <full path to desired directory>
    "   eg: let g:Billinux_consolidated_directory = $HOME . '/.vim/'
    if exists('g:Billinux_consolidated_directory')
        let common_dir = g:Billinux_consolidated_directory . prefix
    else
        let common_dir = parent . '/.' . prefix
    endif

    for [dirname, settingname] in items(dir_list)
        let directory = common_dir . dirname . '/'
        if exists("*mkdir")
            if !isdirectory(directory)
                call mkdir(directory)
            endif
        endif
        if !isdirectory(directory)
            echo "Warning: Unable to create backup directory: " . directory
            echo "Try: mkdir -p " . directory
        else
            let directory = substitute(directory, " ", "\\\\ ", "g")
            exec "set " . settingname . "=" . directory
        endif
    endfor
endfunction

call InitializeDirectories()

" Initialize NERDTree as needed {
function! NERDTreeInitAsNeeded()
    redir => bufoutput
    buffers!
    redir END
    let idx = stridx(bufoutput, "NERD_tree")
    if idx > -1
        NERDTreeMirror
        NERDTreeFind
        wincmd l
    endif
endfunction

" Strip whitespace
function! StripTrailingWhitespace()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " do the business:
    %s/\s\+$//e
    " clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction

" ------------------------------------------------------------------------------
" Custom .vimrc
" ------------------------------------------------------------------------------

" Use fork vimrc if available
if filereadable(expand("~/.vimrc.fork"))
    source ~/.vimrc.fork
endif

" Use local vimrc if available {
if filereadable(expand("~/.vimrc.local"))
    source ~/.vimrc.local
endif

" Use local gvimrc if available and gui is running {
if has('gui_running')
    if filereadable(expand("~/.gvimrc.local"))
        source ~/.gvimrc.local
    endif
endif
