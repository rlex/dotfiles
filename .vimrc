"{{{ Generic params
set encoding=utf8                   " normal encoding
set termencoding=utf-8              " terminal encoding
set nocompatible                    " no vi manner
set ruler                           " cursor position always enabled
set showcmd                         " show commands
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
" Persistent undo
set undodir=~/.vim/swap/undodir
set undofile
set undolevels=1000
set undoreload=10000
" Turn on syntax highlighting
syntax on
" Status line settings
set statusline=File:%F%m%r%h%w\ Enc:%{strlen(&fenc)?&fenc:'none'}\ Line:%{&ff}\ Syntax:%Y\ ASCII:\%03.3b\ HEX:\%02.2B\ Position:%04l,%04v\ Percent:%p%%
set laststatus=2
set fo+=cr " Fix enter for comment
set sessionoptions=curdir,buffers,tabpages
"}}}

" {{{ Functions
" Map key in all modes
function SMap(key, action, ...)
    let modes = " vi"
    if (a:0 > 0)
        let modes = a:{1}
    endif
    if (match(modes, '\Ii') != -1)
        execute 'imap ' . a:key . ' <Esc>' . a:action
    endif
    if (match(modes, '\Nn') != -1)
        execute 'nmap ' . a:key . ' <Esc>' . a:action
    endif
    if (match(modes, ' ') != -1)
        execute 'map ' . a:key . ' <Esc>' . a:action
    endif
    if (match(modes, '\Vv') != -1)
        execute 'vmap ' . a:key . ' <Esc>' . a:action
    endif
endfunction
" }}}

"{{{ Binds

" map <Del> i<Del><Esc>l
map <Del> "_x
" Map del

" Fast toggle comment
map c ,c<SPACE>

" Bind buffers switching to <>
map < :bprev<cr>
map > :bnext<cr>

" CTRL-F omni completion
imap <C-F> <C-X><C-O>

" Ctrl-d for quit all
call SMap("<C-d>", ":qa<cr>")

" C-c and C-v - Copy/Paste
vmap <C-v> <esc>"+p
imap <C-v> <esc>"+p

" shift-insert fix for Xterm
map <S-Insert> <MiddleMouse>

" F2 - quick save
call SMap("<F2>", ":w<cr>")

" F3 - :make
call SMap("<F3>", ":make<cr>")

" F5 - TaskList
call SMap("<F5>", ":TaskList<cr>")

" F8 - toggle pasting mode
set pastetoggle=<F8>

" F9 - TagList
call SMap("<F9>", ":TlistToggle<cr>")

" F10 - NerdTree
call SMap("<F10>", ":NERDTreeToggle<cr>")

" F11 - line numbers
call SMap("<F11>", ":set<Space>nu!<cr>")

" tab navigation like firefox
call SMap("<C-Right>", ":tabnext<cr>")
call SMap("<C-Left>", ":tabprev<cr>")
call SMap("<C-t>", ":tabnew<cr>")

" Encoding settings (koi8-r, cp1251, cp866, utf8)
set wcm=<Tab> 
menu Encoding.utf-8 :e ++enc=utf8<cr>
menu Encoding.koi8-r :e ++enc=koi8-r<cr>
menu Encoding.windows-1251 :e ++enc=cp1251<cr>
menu Encoding.cp866 :e ++enc=cp866<cr>
call SMap("<F7>", ":emenu Encoding.<TAB>")

" C-Q - Exit Vim
map <C-Q> <Esc>:qa<cr>

" Folding toggle with ctrl-f
call SMap("<C-f>", "za<space>")

" Pageup/pagedown
call SMap("<PageUp>", "<C-U><C-U>")
call SMap("<PageDown>", "<C-D><C-D>")
" }}}

" {{{ Smart mapper for tab completion
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
" }}}

" {{{ Completion
" order and what to complete. see ":help complete" for info
set complete=.,w,b,u,t,i
" enable dictionary (add k to complete to scan dict when completing)
" set dict=<FILENAME>
" adjust case of a keyword completion match
set infercase
" showfulltag   when completing tags in Insert mode show only the name
" not any arguments (when a c-funtion is inserted)
set nosft
" }}}

"{{{ Filetype plugin
filetype plugin on
au BufRead,BufNewFile *.phps       set filetype=php
au BufRead,BufNewFile *.vcl        set filetype=varnish
au BufRead,BufNewFile *etc/nginx/* set filetype=nginx
au BufRead,BufNewFile /*etc/nagios/*.cfg,/*etc/nagios3/*.cfg,*sample-config/template-object/*.cfg{,.in},/var/lib/nagios/objects.cache set filetype=nagios
" }}}

" {{{ Various plugins settings
let g:Tlist_Show_One_File = 1

set completeopt-=preview
set completeopt+=longest
set mps-=[:]
 
let g:ctags_title=1
let generate_tags=1
let g:ctags_regenerate=1

" }}}

" {{{ NeoComplCache

let g:neocomplcache_enable_at_startup = 0                 " Enable NeoComplCache
let g:neocomplcache_enable_smart_case = 1                       " Use smartcase 
let g:neocomplcache_enable_camel_case_completion = 1       " Camel case completion 
let g:neocomplcache_enable_underbar_completion = 1        " Underbar completion
let g:neocomplcache_min_syntax_length = 3                 " Minimum syntax keywork length 
let g:neocomplcache_manual_completion_start_length = 0     " Manual completion length 
let g:neocomplcache_min_keyword_length = 3                " Minimal keyword length 

imap <silent><C-l>     <Plug>(neocomplcache_snippets_expand)
smap <silent><C-l>     <Plug>(neocomplcache_snippets_expand)

" }}}

" {{{ Colorscheme based on $TERM
if $TERM =~ "xterm" || $TERM =~ "rxvt" || $TERM =~ "screen" || &term =~ "builtin_gui" || $TERM == "dumb"
    set t_Co=256
    colorscheme xoria256
else
    colorscheme desert
endif
" }}}

" {{{ srcexpl
let g:SrcExpl_winHeight = 8 " Set Source explorer height
let g:SrcExpl_refreshTime = 100 " 100 ms to refresh 
let g:SrcExpl_jumpKey = "<ENTER>" " Set Enter key to jump into the exact definition context 
let g:SrcExpl_gobackKey = "<SPACE>" "Set Space key for back from the definition contex 
let g:SrcExpl_pluginList = [ 
        \ "__Tag_List__", 
        \ "_NERD_tree_", 
        \ "Source_Explorer" 
    \ ] 
let g:SrcExpl_searchLocalDef = 0 " Disable local def searching
let g:SrcExpl_isUpdateTags = 1  " Update ctags automatically
let g:SrcExpl_updateTagsCmd = "ctags --sort=foldcase -R ." " Use ctags with args
let g:SrcExpl_updateTagsKey = "<F12>" "Set F12 key for updating the tags file artificially 

" }}}

" {{{ cscope
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

" }}}

" {{{ Vim tags
for $f in split(glob("~/.vim/tags/*"), "\n")
    set tags+=$f
endfor

" Regenerate tag
source ~/.vim/autoload/autotag.vim
"}}}

" {{{ Various fixes
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
" }}}

" {{{ Syntastic plugin
let g:syntastic_enable_signs=1
" }}}
