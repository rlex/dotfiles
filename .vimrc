" Generic params
set encoding=utf8                   " normal encoding
set termencoding=utf-8              " terminal encoding
set nocompatible                    " no vi manner
set ruler                           " cursor position always enabled
set showcmd                         " show commands
set nu                              " line numbers
set title                           " enable title
set titlestring=VIM:\ %F            " Make the window title reflect the file being edited
set incsearch                       " Incremental search
set scrolljump=7                    " Jump with scroll
set scrolloff=7                     " Scroll when near screen edge
set novisualbell                    " Disable bell
set t_vb=                           " Really disable
set backupdir=~/.rc/.vim/swap/      " Backup dir
set directory=~/.rc/.vim/swap/      " Another backup dir
set hidden                          " Enable unsaved buffer
set ch=1                            " Command line - one line high
set mousehide                       " Hide mouse cursor
set autoindent                      " Auto indentation
set backspace=indent,eol,start      " Use backspace...
set whichwrap+=<,>,[,]              " Instead of _x
set hls                             " Highlight searchi
set complete=.,w,b,u,t,i            " Params for complete
set infercase                       " Fix completion case
set nosft                           " No full tags, please
set foldenable                      " Turn on folding
set foldmethod=marker               " With {{{,}}} markers
set viminfo=\'100,\"500,:100"       " read/write a .viminfo file --"Limit regs to 500 lines
set showmatch                       " show matching brackets and etc
set wildmenu                        " Filesystem via :e
set fileencodings=utf-8,cp1251      " Well, sometimes i edit files from win.
" Tabulation params
set shiftwidth=4
set softtabstop=4
set tabstop=4
set sw=4
set sts=4
set nolist
set expandtab
" Turn on syntax highlighting
syntax on
" Status line settings
set statusline=%F%m%r%h%w\ [FORMAT=%{strlen(&fenc)?&fenc:'none'},%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
set laststatus=2
" Fix <Enter> for comment
set fo+=cr

" Which compiler we must use?
if has('win32')
  set makeprg=nmake
  compiler msvc
else
  set makeprg=make
  compiler gcc
endif

" map <Del> i<Del><Esc>l
map <Del> "_x
" Map del

" Session options
set sessionoptions=curdir,buffers,tabpages

"-------------------------
" Binds and other
"-------------------------

" CTRL-F omni completion
imap <C-F> <C-X><C-O>

" C-c and C-v - Copy/Paste
vmap <C-C> "+yi
imap <C-V> <esc>"+gPi

" shift-insert fix for Xterm
map <S-Insert> <MiddleMouse>

" C-d - yyPi
imap <C-d> <esc>yypi

" C-N - Toggle lines
nmap <C-N><C-N> :set invnumber<CR>
vmap <C-N><C-N> <esc>:set invnumber<CR>
imap <C-N><C-N> <esc>:set invnumber<CR>

" Expand cword
nmap > :%s/\<<c-r>=expand("<cword>")<cr>\>/
 
" F2 - :w :)
nmap <F2> :w<cr>
vmap <F2> <esc>:w<cr>i
imap <F2> <esc>:w<cr>i

" F5 - BufExplorer
nmap <F5> <Esc>:BufExplorer<cr>
vmap <F5> <esc>:BufExplorer<cr>
imap <F5> <esc><esc>:BufExplorer<cr>

" F6 - bp...
map <F6> :bp<cr>
vmap <F6> <esc>:bp<cr>i
imap <F6> <esc>:bp<cr>i

" F8 - Marks Browser
map <F8> :MarksBrowser<cr>
vmap <F8> <esc>:MarksBrowser<cr>
imap <F8> <esc>:MarksBrowser<cr>

" F9 - toggle pasting mode
set pastetoggle=<F9>

" F10 - NerdTree
map <F10> :NERDTreeToggle<cr>
imap <F10> <esc>:NERDTreeToggle<cr>
nmap <F10> <esc>:NERDTreeToggle<cr>

" F11 - TagList
map <F11> :TlistToggle<cr>
vmap <F11> <esc>:TlistToggle<cr>
imap <F11> <esc>:TlistToggle<cr>

" tab navigation like firefox
map <C-Right> :tabnext<CR>
map <C-Left> <ESC>:tabprev<CR>
nmap <C-t> :tabnew<CR>
imap <C-t> <Esc>:tabnew<CR>

" Encoding settings (koi8-r, cp1251, cp866, utf8)
set wcm=<Tab> 
menu Encoding.koi8-r :e ++enc=koi8-r<CR>
menu Encoding.windows-1251 :e ++enc=cp1251<CR>
menu Encoding.cp866 :e ++enc=cp866<CR>
menu Encoding.utf-8 :e ++enc=utf8 <CR>

" C-Q - Exit Vim
map <C-Q> <Esc>:qa<cr>


" Smart mapper for tab completion
function InsertTabWrapper()
 let col = col('.') - 1
 if !col || getline('.')[col - 1] !~ '\k'
 return "\<tab>"
 else
 return "\<c-p>"
 endif
endfunction
" imap <tab> <c-r>=InsertTabWrapper()<cr>
imap <S-tab> <c-r>=InsertTabWrapper()<cr>

" order and what to complete. see ":help complete" for info
set complete=.,w,b,u,t,i
" enable dictionary (add k to complete to scan dict when completing)
" set dict=<FILENAME>
" adjust case of a keyword completion match
set infercase
" showfulltag   when completing tags in Insert mode show only the name
" not any arguments (when a c-funtion is inserted)
set nosft

" Filetype plugin
filetype plugin on
au BufRead,BufNewFile *.phps set filetype=php
au BufRead,BufNewFile *.thtml set filetype=php
au BufRead,BufNewFile *.erb set filetype=html

" Show only one file in Tlist
let g:Tlist_Show_One_File = 1

set completeopt-=preview
set completeopt+=longest
set mps-=[:]
 
" NERDTree hotkeys
nmap <C-N>v :NERDTree<cr>
vmap <C-N>v <esc>:NERDTree<cr>i
imap <C-N>v <esc>:NERDTree<cr>i

nmap <C-N>x :NERDTreeClose<cr>
vmap <C-N>x <esc>:NERDTreeClose<cr>i
imap <C-N>x <esc>:NERDTreeClose<cr>i

let g:ctags_title=1
let generate_tags=1
let g:ctags_regenerate=1

" {{{ NeoComplCache

let g:NeoComplCache_EnableAtStartup = 1                 " Enable NeoComplCache
let g:NeoComplCache_SmartCase = 1                       " Use smartcase 
let g:NeoComplCache_EnableCamelCaseCompletion = 1       " Camel case completion 
let g:NeoComplCache_EnableUnderbarCompletion = 1        " Underbar completion
let g:NeoComplCache_MinSyntaxLength = 3                 " Minimum syntax keywork length 
let g:NeoComplCache_ManualCompletionStartLength = 0     " Manual completion length 
let g:NeoComplCache_MinKeywordLength = 3                " Minimal keyword length 

" }}}
" Colorscheme based on $TERM
if $TERM == "xterm" || $TERM == "rxvt" || $TERM == "xterm-256color" || $TERM == "rxvt-unicode" || &term =~ "builtin_gui" || $TERM == "dumb"
    set t_Co=256
    colorscheme xoria256
else
    colorscheme desert
endif

let g:AutoClosePairs = {'(': ')', '{': '}', '[': ']', '"': '"', "'": "'" }

"ie both cscope and ctag for 'ctrl-]', ':ta', and 'vim -t'
set cscopetag

" check cscope for definition of a symbol before checking ctags: set to 1
" if you want the reverse search order.
set csto=1

" add any cscope database in current directory
if filereadable("cscope.out")
        cs add cscope.out 
" else add the database pointed to by environment variable 
elseif $CSCOPE_DB != ""
        cs add $CSCOPE_DB
endif

" show msg when any other cscope db added
set cscopeverbose  
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete
autocmd FileType rb,rake,ruby,eruby set omnifunc=rubycomplete#Complete
autocmd FileType rb,rake,ruby set noexpandtab

" Power on backup :)
set backup

" Smart backup
function! BackupDir()
    let l:backupdir=$HOME.'/.vim/backup/'.
            \substitute(expand('%:p:h'), '^'.$HOME, '~', '')
    " if directory no exist, create it
    if !isdirectory(l:backupdir)
        call mkdir(l:backupdir, 'p', 0700)
    endif

    " set directory for backups...
    let &backupdir=l:backupdir

    " ...and extension
    let &backupext=strftime('~%Y-%m-%d~')
endfunction

" And write.
autocmd! bufwritepre * call BackupDir()


nmap <PageUp> <C-U><C-U>
imap <PageUp> <C-O><C-U><C-O><C-U>
nmap <PageDown> <C-D><C-D>
imap <PageDown> <C-O><C-D><C-O><C-D>

for $f in split(glob("~/.vim/tags/*"), "\n")
    set tags+=$f
endfor

" Regenerate tag
source ~/.vim/autoload/autotag.vim

if has("multi_lang")
    if has("unix")
        language messages C
    else
        language messages en
    endif
endif

" Disable mouse on non-gui
if !has('gui_running')
  set mouse=
endif


" some more Console-mode-only settings
 set keywordprg=man
 set title titleold= titlestring=%t\ -\ VIM
 " change cursor color for Insert (commented out, doesn't work for me)
if &term == 'xterm' && 0
    let &t_SI = "\e]12;CursorShape=1\x07"
    let &t_EI = "\e]50;CursorShape=0\x07"
endif

" override previous 'keywordprg' settings if not on Unix
if !has('unix')
  set keywordprg=:help
endif

