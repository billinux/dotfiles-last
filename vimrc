" Modelines and notes

set nocompatible                                    " Use VIM defaults instead
scriptencoding utf-8
set encoding=utf-8
set modeline
set modelines=5                                     " Default number of lines to read for modeline instructions




" Environment
silent function! OSX()
    return has('macunix')
endfunction

silent function! LINUX()
    return has('unix') && !has('macunix') && !has('win32unix')
endfunction

silent function! WINDOWS()
    return (has('win16') || has('win32') || has('win64'))
endfunction



" Basics
set background=dark
set mousehide
set mouse=a
set hidden                                          " Allow buffer switching without saving

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
if filereadable(expand("~/.vimrc.bundles.default"))
    source ~/.vimrc.bundles.default
endif

filetype plugin indent on                           " Automatically detect file types

if &t_Co > 2 || has("gui_running")
    syntax on                                       " Syntax hightlighting
    set hlsearch                                    " Highlight search terms
    set incsearch                                   " Find as you type search
endif


" Vim UI

if filereadable(expand("~/.vim/bundle/vim-colors-solarized/colors/solarized.vim"))
    let g:solarized_termcolors=256
    let g:solarized_termtrans=1
    let g:solarized_contrast="normal"
    let g:solarized_visibility="normal"
    color solarized
endif

set number
set numberwidth=3
set tabpagemax=15                                   " Only show 15 tabs
set showmode                                        " Display the current mode
set cursorline                                      " Highlight current line
set scrolljump=5                                    " Lines to scroll when cursor leaves screen
set scrolloff=3                                     " Minimum lines to keep above and below cursor
set showmatch                                       " Show matching brackets/parenthesis
set wildmenu                                        " Show list instead of just completing
set wildmode=list:longest,full                      " Command <Tab> completion
set wildignorecase
set wildignore+=*.swp,*.bak,*.pyc,*.class,*.o,*.obj,tags
set whichwrap=b,s,h,l,<,>,[,]                       " Backspace and cursor keys wrap too
set title                                           " Show file in tilebar
set backspace=indent,eol,start                      " Backspace for dummies
set encoding=utf-8                                  " Files are encoded into utf-8
set linespace=0                                     " No extra spaces between rows
set winminheight=0                                  " Windows can be 0 line high
set ignorecase                                      " Case insensitive search
set smartcase                                       " Case sensitive when uc present
set smartindent                                     " Smart auto indenting
set autowrite                                       " Automatically write a file when leaving a modified buffer
set shortmess+=filmnrxoOtT                          " Abbrev. of messages (avoids 'hit enter')
set virtualedit=onemore                             " Allow for cursor beyond last character

set viewoptions=folds,options,cursor,unix,slash     " Better Unix / Windows compatibility

" Setting up the directories
set backup                                          " Backups are nice ...
if has('persistent_undo')
    set undofile                                    " So is persistent undo ...
    set undolevels=1000                             " Maximum number of changes that can be undone
    set undoreload=10000                            " Maximum number lines to save for undo on a buffer reload
endif

set history=1000                                    " Store a ton of history (default is 20)
"
if exists("&foldenable")
    set foldenable                                  " Folding is authorized
    set foldlevel=100
    set foldlevelstart=0
endif

if !exists('g:Billinux_no_list')
    set list                                        " Listchars
endif

if (&termencoding ==# 'utf-8' || &encoding ==# 'utf-8') && version >= 700
    set listchars=nbsp:%
    set listchars+=tab:>-
    set listchars+=trail:~
    set listchars+=extends:>
    set listchars+=precedes:<
    set listchars+=eol:$

    set fillchars+=vert:\+ |
    set fillchars+=diff:-
endif

set showbreak=-

if has('balloon_eval') && has('unix')
    set ballooneval
endif

if !exists('g:Billinux_no_spell')
    set spell                                       " Spell checking on
    set spelllang=fr
    nnoremap <leader>s :set spell!<CR>
endif

if exists("&colorcolumn")
    set colorcolumn=80
endif

highlight clear SignColumn                          " SignColumn should match background
highlight clear LineNr                              " Current line number row will have same background color in relative mode
let g:CSApprox_hook_post = ['hi clear SignColumn']
"highlight clear CursorLineNr                       " Remove highlight color from current line number

if has('cmdline_info')
set ruler                                           " Show the ruler
set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%)  " A ruler on steroids
set showcmd                                         " Show partial commands in status line ande selected characters/lines in visual mode
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


" Formatting
set shiftwidth=4                                    " Use indents of 4 spaces
set expandtab                                       " Tabs are spaces, not tab
set tabstop=4                                       " An indentation every 4 columns
set softtabstop=4                                   " Let backspace delete indent
set smarttab                                        " Smarttab handling for indenting
set splitright                                      " Puts new vsplit windows to the right of the
set splitbelow                                      " Puts new split windows to the bottom of the
set pastetoggle=<F12>                               " Paste toggle

autocmd FileType c,cpp,java,go,php,javascript,python,twig,xml,yml,perl autocmd BufWritePre <buffer> if !exists('g:Billinux_keep_trailing_whitespace') | call StripTrailingWhitespace() | endif


" Mappings
nmap <leader>v :vsp $MYVIMRC<CR>

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


" Switch different kind line number
nnoremap <leader>: :set invnumber<cr>
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

" Save file (ctrl-s)
nmap <c-s> :w<cr>

" Save when you are in the 'INSERT MODE' (ctrl-s)
imap <c-s> <esc>:w<cr>a

" Copy selected text (ctrl-c)
vmap <c-c> y

"Paste clipboard contents (ctrl-p) (à modifier)
imap <c-p> <esc>P

"Cut selected text (ctrl-x)
vmap <c-x> x

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

nnoremap <space> za
vnoremap <space> zf

""noremap <leader><space> :noh<cr>
" To clear search highlighting rather than toggle it and off
if !exists('g:Billinux_clear_search_highlight')
    noremap <silent> <leader><space> :nohlsearch<CR>
else
    noremap <silent> <leader><space> :invhlsearch<CR>
endif

" Window navigation
map <C-J> <C-W>j<C-W>_
map <C-k> <C-W>k<C-W>_
map <C-h> <C-W>h<C-W>_
map <C-l> <C-W>l<C-W>_



" Filetype setting
augroup myvimrc
    au!
    au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
augroup END



" Plugins settings
" Use bundles config
if filereadable(expand("~/.vimrc.plugins.configs"))
    source ~/.vimrc.plugins.config
endif


" GUI

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
    if &term =~ 'xterm' || &term =~ 'screen' || &term =~ 'cywin'
        set t_Co=256            " Enable 256 colors to stop the CSApprox warning and make xterm vim shine
    endif
    "set term=builtin_ansi       " Make arrow and other keys work
endif



" Functions
function! NeatFoldText() 
  let line = ' ' . substitute(getline(v:foldstart), '^\s*"\?\s*\|\s*"\?\s*{{' . '{\d*\s*', '', 'g') . ' '
  let lines_count = v:foldend - v:foldstart + 1
  let lines_count_text = '| ' . printf("%10s", lines_count . ' lines') . ' |'
  let foldchar = matchstr(&fillchars, 'fold:\zs.')
  let foldtextstart = strpart('+' . repeat(foldchar, v:foldlevel*2) . line, 0, (winwidth(0)*2)/3)
  let foldtextend = lines_count_text . repeat(foldchar, 8)
  let foldtextlength = strlen(substitute(foldtextstart . foldtextend, '.', 'x', 'g')) + &foldcolumn
  return foldtextstart . repeat(foldchar, winwidth(0)-foldtextlength) . foldtextend
endfunction
set foldtext=NeatFoldText()

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


" Custom .vimrc

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


