" Parameters
set nocompatible
set nobackup
set directory=~/.vim/swap
set number
set cindent
set showmatch
set autoindent
set incsearch
set ignorecase
set hlsearch
set encoding=utf8
set tenc=utf8
set fileencoding=utf8
set ttyfast
set title
set hlsearch
set ruler
set backspace=2
set shiftwidth=4      " A tab becomes four spaces
set softtabstop=4
set tabstop=4
set fileformat=unix

colo desert
syntax on
filetype plugin indent on

" Load matchit (% to bounce from do to end, etc.)
" runtime! macros/matchit.vim

augroup myfiletypes
  " Clear old autocmds in group
  autocmd! 
  autocmd BufRead,BufNewFile *.haml                      setfiletype haml
  autocmd BufRead,BufNewFile *.sass                      setfiletype sass
  autocmd FileType ruby,eruby,yaml,html,haml,sass,css,js,vim set sw=2 sts=2 et
  autocmd FileType ruby,eruby,haml                           imap <buffer> <CR> <C-R>=RubyEndToken()<CR>
  autocmd FileType php                                       set sw=4 sts=4 et
augroup END

" Shortcmds
nmap tp :tabprev<cr>
nmap tn :tabnext<cr>
nmap to :tabnew<cr>
nmap tc :tabclose<cr>
