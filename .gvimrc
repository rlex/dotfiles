if !has('gui_running')
  set mouse=
endif


set guioptions-=T
set guioptions-=m


if has("gui_running")

 " set the GUI font, using the correct format for the build we're on
 if has("gui_gtk2")
     set gfn=Bitstream\ Vera\ Sans\ Mono\ 10
     let s:pfn = 'Bitstream\ Vera Sans Mono'
 " set gfn=Monaco\ 7
 " let s:pfn='Monaco'
 elseif has("gui_photon")
     set gfn=Bitstream\ Vera\ Sans\ Mono:s10
     let s:pfn = 'Bitstream\ Vera Sans Mono'
 " set gfn=Monaco=s7
 " let s:pfn='Monaco'
 elseif has("gui_kde")
     set gfn=Bitstream\ Vera\ Sans\ Mono/10/-1/5/50/0/0/0/1/0
     let s:pfn = 'Bitstream\ Vera Sans Mono'
 "  set gfn=Monaco/7/-1/5/50/0/0/0/1/0
 "  let s:pfn='Monaco'
 elseif has("x11")
     set gfn=-*-lucidatypewriter-medium-r-normal-*-*-90-*-*-m-*-*
     let s:pfn = 'Lucida'
 else
     set gfn=Lucida_Console:h9:cDEFAULT
     let s:pfn = 'Lucida Console'
 endif

 " set GUI cursor shape
 set guicursor=n-v-c:block-Cursor/lCursor,ve:ver35-Cursor,o:hor50-Cursor
 set guicursor+=i-ci:ver25-Cursor/lCursor,r-cr:hor20-Cursor/lCursor
 set guicursor+=sm:block-Cursor,a:blinkwait750-blinkoff750-blinkon750

 set keywordprg=MANPAGER=more\ man\ -a\  " command to be used for the K command
else

 " print font for Console mode
 let s:pfn = 'Courier'

 if (&term == "pcterm") || (&term == "win32")
     " if exists("+guicursor")
     " Console cursor shape (Windows only)
     set guicursor=n-v-c:block,o:hor50,i-ci:hor15,r-cr:hor30
     set guicursor+=sm:block,a:blinkwait750-blinkoff750-blinkon750

 elseif &term == "linux"
    " don't try running CSApprox on Linux text-only console
    let g:CSApprox_loaded = 1

     " avoid some line-depth screwups
     if &lines > 47
         set lines=47
     endif

 elseif &term == "mlterm" " the true-bidi terminal
     let &t_kb = "\x7F" " termcap patch for mlterm backspace key
 endif

 " some more Console-mode-only settings
 set keywordprg=man
 set title titleold= titlestring=%t\ -\ VIM
 " change cursor color for Insert (commented out, doesn't work for me)
 if &term == 'xterm' && 0
     let &t_SI = "\e]12;CursorShape=1\x07"
     let &t_EI = "\e]50;CursorShape=0\x07"
 endif
endif " has("gui_running") ... else ...
