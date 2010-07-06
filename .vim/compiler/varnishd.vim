" Vim compiler file
" Compiler:	Varnish
" Maintainer: Lex Rivera
" URL:
" Last Change: 2010 Jul 08

if exists("current_compiler")
  finish
endif
let current_compiler = "varnishd"

if exists(":CompilerSet") != 2		" older Vim always used :setlocal
  command -nargs=* CompilerSet setlocal <args>
endif

let s:cpo_save = &cpo
set cpo-=C

CompilerSet makeprg=varnishd\ -C\ -t

CompilerSet errorformat=%f:\ line\ %l:\ %m

let &cpo = s:cpo_save
unlet s:cpo_save
