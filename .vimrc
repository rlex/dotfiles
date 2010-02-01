" Set normal encoding
set encoding=utf8
set termencoding=utf-8

" Color always 256
set t_Co=256

" No vi manner
set nocompatible

" Turn ruler on
set ruler

" Show commands
set showcmd

" Copy with lines
set nu

" Make the window title reflect the file being edited
set title
set titlestring=VIM:\ %F

" Folding method
" set foldmethod=indent

" Incremental search
set incsearch

" No highlighting when search
set nohls

" Jump with scroll
set scrolljump=7

" 7 lines near cursor
set scrolloff=7

" Disable bell
set novisualbell
set t_vb= 

" Backup dir
set backupdir=~/.rc/.vim/swap/
set directory=~/.rc/.vim/swap/


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

" Enable unsaved buffer
set hidden

" Remove toolbar
set guioptions-=T

" Make command line one line high
set ch=1

" Hide mouse cursor
set mousehide

" Enable auto indentation
set autoindent

" Enable syntax highlight
syntax on

" allow to use backspace instead of "x"
set backspace=indent,eol,start whichwrap+=<,>,[,]

" Tabulation params
set shiftwidth=4
set softtabstop=4
set tabstop=4
set sw=4
set sts=4
"set et
"set ai
"set cin
set list
set expandtab

" Status line settings
set statusline=%<%f%h%m%r\ %b\ %{&encoding}\ 0x\ \ %l,%c%V\ %P 
set laststatus=2

" Smart indentation
" set smartindent

" Fix <Enter> for comment
set fo+=cr

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

" C-y - vim dd
nmap <C-y> dd
imap <C-y> <esc>ddi

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

" F3 - rake
nmap <F3> :!rake<cr>
vmap <F3> <esc>:!rake<cr>
imap <F3> <esc>:!rake<cr>

"map <F4> [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>]]

" F5 - BufExplorer
nmap <F5> <Esc>:BufExplorer<cr>
vmap <F5> <esc>:BufExplorer<cr>
imap <F5> <esc><esc>:BufExplorer<cr>

" F6 - bp...
map <F6> :bp<cr>
vmap <F6> <esc>:bp<cr>i
imap <F6> <esc>:bp<cr>i

" F7 - wall make
map <F7> :wall \| make<Cr>
imap <F7> <ESC>:wall \| make<Cr>
map <F4> :cn<Cr>zvzz:cc<Cr>
map <S-F4> :cp<Cr>zvzz:cc<Cr>

" F8 - Marks Browser
map <F8> :MarksBrowser<cr>
vmap <F8> <esc>:MarksBrowser<cr>
imap <F8> <esc>:MarksBrowser<cr>

" F9 - toggle pasting mode
set pastetoggle=<F9>

" F10 free

" F11 - TagList
map <F11> :TlistToggle<cr>
vmap <F11> <esc>:TlistToggle<cr>
imap <F11> <esc>:TlistToggle<cr>

" F12 - ExWhat?
map <F12> :Ex<cr>
vmap <F12> <esc>:Ex<cr>i
imap <F12> <esc>:Ex<cr>i

" tab navigation like firefox
map <C-Right> :tabnext<CR>
map <C-Left> <ESC>:tabprev<CR>
nmap <C-t> :tabnew<CR>
imap <C-t> <Esc>:tabnew<CR>

" Encoding settings (koi8-r, cp1251, cp866, utf8)
set wildmenu
set wcm=<Tab> 
menu Encoding.koi8-r :e ++enc=koi8-r<CR>
menu Encoding.windows-1251 :e ++enc=cp1251<CR>
menu Encoding.cp866 :e ++enc=cp866<CR>
menu Encoding.utf-8 :e ++enc=utf8 <CR>

" їїїїї їїїїї їїїї [ їїї їїїї =)
imap [ []<LEFT>
" їїїїїїїїїї ї їїї {
imap {<CR> {<CR>}<Esc>O

" ї-q - їїїїї її Vim 
map <C-Q> <Esc>:qa<cr>


" їїїїїїїїїїїїїї їїїї її tab =)
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


" їїїїї їїїїїї їїїїї їїїїїїїїї
set complete=""
" її їїїїїїїї їїїїїї
set complete+=.
" її їїїїїїї
set complete+=k
" її їїїїїї їїїїїїїї їїїїїїї
set complete+=b
" її їїїїї 
set complete+=t

" Filetype plugin
filetype plugin on
au BufRead,BufNewFile *.phps set filetype=php
au BufRead,BufNewFile *.thtml set filetype=php
au BufRead,BufNewFile *.erb set filetype=html

" SessionMgr Settings
let g:SessionMgr_AutoManage = 0
let g:SessionMgr_DefaultName = "mysession"

" Show only one file in Tlist
let g:Tlist_Show_One_File = 1

set completeopt-=preview
set completeopt+=longest
set mps-=[:]

:au Filetype html,xml,xsl,erb,rhtml,phtml,htm,rb,php source ~/.vim/scripts/closetag.vim 
" NERDTree hotkeys
nmap <C-N>v :NERDTree<cr>
vmap <C-N>v <esc>:NERDTree<cr>i
imap <C-N>v <esc>:NERDTree<cr>i

nmap <C-N>x :NERDTreeClose<cr>
vmap <C-N>x <esc>:NERDTreeClose<cr>i
imap <C-N>x <esc>:NERDTreeClose<cr>i

"TagList Hotkeys :TlistToggle
nmap <C-N>t :TlistToggle<cr>
vmap <C-N>t <esc>:TlistToggle<cr>i
imap <C-N>t <esc>:TlistToggle<cr>i

"nmap <C-N>x :TlistToggle<cr>
"vmap <C-N>x <esc>:TlistToggle<cr>i
"imap <C-N>x <esc>:TlistToggle<cr>i

let g:ctags_statusline=1
let g:ctags_title=1
let generate_tags=1
let g:ctags_regenerate=1

" set background=dark
" syntax highlighting
syntax on " syntax highlighting
colorscheme xoria256
set hls

let g:AutoClosePairs = {'(': ')', '{': '}', '[': ']', '"': '"', "'": "'" }

autocmd BufNewFile,BufRead *.rb source ~/.vim/scripts/rubysnippets.vim

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
"autocmd FileType rb set omnifunc=rubycomplete#Complete

" set encodings
set fileencodings=utf-8,cp1251

autocmd FileType html :set omnifunc=htmlcomplete#CompleteTags
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete
autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1

nmap <leader>rci :%!ruby-code-indenter<cr>

autocmd FileType rb,rake,ruby set noexpandtab

" убираем замену таба на две точки в haml-файлах
" autocmd FileType haml set listchars=tab:\ \ 

" включить сохранение резервных копий
set backup

" сохранять умные резервные копии ежедневно
function! BackupDir()
	" определим каталог для сохранения резервной копии
	let l:backupdir=$HOME.'/.vim/backup/'.
			\substitute(expand('%:p:h'), '^'.$HOME, '~', '')

	" если каталог не существует, создадим его рекурсивно
	if !isdirectory(l:backupdir)
		call mkdir(l:backupdir, 'p', 0700)
	endif

	" переопределим каталог для резервных копий
	let &backupdir=l:backupdir

	" переопределим расширение файла резервной копии
	let &backupext=strftime('~%Y-%m-%d~')
endfunction

" выполним перед записью буффера на диск
autocmd! bufwritepre * call BackupDir()


" включаем syntax/haml.vim
"au BufRead,BufNewFile *.haml         setfiletype haml 
"au BufRead,BufNewFile *.haml         set listchars=tab:\ \ 
au BufEnter *        if &ft == 'haml' |  set listchars=tab:\ \  | else | set listchars=tab:··| endif

nmap <PageUp> <C-U><C-U>
imap <PageUp> <C-O><C-U><C-O><C-U>
nmap <PageDown> <C-D><C-D>
imap <PageDown> <C-O><C-D><C-O><C-D>

for $f in split(glob("~/.vim/tags/*"), "\n")
	set tags+=$f
endfor

source ~/.vim/autoload/autotag.vim

inoremap <expr> <C-d> pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<C-d>"
inoremap <expr> <C-u> pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<C-u>"

if has("multi_lang")
	if has("unix")
		language messages C
	else
		language messages en
	endif
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

set ignorecase smartcase

