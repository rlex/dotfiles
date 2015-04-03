" {{{ Custom options
colorscheme xoria256          " Define colorscheme for graphic mode
set guioptions-=T             " No toolbar
"set guioptions-=m            " No menubar
" }}}

" {{{ Fonts settings
if has("x11")
  set gfn=Terminus\ 7
elseif has("win32")
  set gfn=Fixedsys:h7:cANSI
endif
" }}}

" Disable toolbar / menubar
set guioptions-=T
"set guioptions-=m

" {{{ Fix linux text-only console
if has('gui_running')
  if (&term == "linux")
    " don't try running CSApprox on Linux text-only console
    let g:CSApprox_loaded = 1
    " avoid some line-depth screwups
    if &lines > 47
      set lines=47
    endif
  endif
endif
" }}}
