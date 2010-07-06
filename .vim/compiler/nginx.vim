" Vim compiler file
" Compiler:	Nginx syntax checker
" Maintainer:	Lex Rivera
" URL:	
" Last Change:	2010 Jul 08

if exists("current_compiler")
  finish
endif
let current_compiler = "nginx"

if exists(":CompilerSet") != 2		" older Vim always used :setlocal
  command -nargs=* CompilerSet setlocal <args>
endif

let s:cpo_save = &cpo
set cpo-=C
" FIXME: We should NOT pass path in args
CompilerSet makeprg=nginx\ -t

CompilerSet errorformat=%m\ in\ %f:%l

let &cpo = s:cpo_save
unlet s:cpo_save
