## Options ##
# 1 for true, any other for false
export ext_functions="1"	# source ~/.rc/.sh_functions
export ext_alias="1"			# source ~/.rc/.sh_aliases
export ext_toast="1"			# add toast environment variables

## ZSH Options ##
unsetopt BG_NICE		      # do not nice bg commands
setopt EXTENDED_HISTORY		# puts timestamps in the history
setopt NO_HUP             # don't send kill to background jobs when exiting

## History options ##
export HISTFILE=$HOME/.zsh-history		# path to history file
export HISTIGNORE=ls:l:pwd:mc:su:df:clear:fg:bg:history # ignore some common commands
export HISTSIZE=5000
export SAVEHIST=1000
setopt append_history
setopt inc_append_history
setopt extended_history
setopt hist_find_no_dups
setopt hist_ignore_all_dups
setopt hist_reduce_blanks
setopt hist_ignore_space
setopt hist_no_store
setopt hist_no_functions
setopt no_hist_beep
setopt hist_save_no_dups

## autoloads ##
autoload -U compinit
autoload -U promptinit
autoload -U colors
## inits ##
colors
compinit
promptinit

## dircolors ##
eval `dircolors ~/.dircolors -b`

# load env variables
if [ -f $HOME/.rc/.sh_env ];
  then
	source $HOME/.rc/.sh_env
fi


# check for toast, if yes, env it
if [ "$ext_toast" = "1" ]; then
	if [ -f $HOME/.toast/armed/bin/toast ];
		then
	eval `$HOME/.toast/armed/bin/toast env`
	fi
fi

# check for sh functions file
if [ "$ext_functions" = "1" ]; then
	if [ -f $HOME/.rc/.sh_functions ];
		then
	source $HOME/.rc/.sh_functions
	fi
fi

# check for sh aliases file
if [ "$ext_toast" = "1" ]; then
	if [ -f $HOME/.rc/.sh_aliases ];
		then
	source $HOME/.rc/.sh_aliases
	fi
fi

# prompt (if running GNU screen, show window number)
#if [ x$WINDOW != x ]; then
    # [5:xdemon@mainframe:~]% 
#    export PS1="%{$fg[blue]%}[%{$fg[cyan]%}$WINDOW%{$fg[blue]%}:%{$fg[green]%}%n%{$fg[cyan]%}@%{$fg[green]%}%m%{$fg[blue]%}:%{$fg[magenta]%}%~%{$fg[blue]%}]%{$reset_color%}%# "
#else
    # [xdemon@mainframe:~]% 
#    export PS1="%{$fg[blue]%}[%{$fg[green]%}%n%{$fg[cyan]%}@%{$fg[green]%}%m%{$fg[blue]%}:%{$fg[magenta]%}%~%{$fg[blue]%}]%{$reset_color%}%# "
#fi
#export RPRMOPT="%{$reset_color%}"

# Two-lined prompt
PS1="%{${fg_bold[red]}%}[%{${fg_bold[default]}%}%D%{${fg_bold[red]}%}]-[%{${fg_bold[default]}%}%n%{${fg_bold[red]}%}]-[${fg_bold[default]}%m%{${fg_bold[red]}%}]-[\
%{${fg_bold[default]}%}${$(tty)#/dev/##}%}%{${fg_bold[red]}%}]-[\
%{${fg_bold[default]}%}%~%{${fg_bold[red]}%}]
[%{${fg_bold[default]}%}%*%{${fg_bold[red]}%}]-%#%{${fg_bold[default]}%} """

# colorize stderr
# exec 2>>(while read line; do print '\e[91m'${(q)line}'\e[0m' > /dev/tty; print -n $'\0'; done &)


# format titles for screen and rxvt
function title() {
  # escape '%' chars in $1, make nonprintables visible
  a=${(V)1//\%/\%\%}

  # Truncate command, and join lines.
  a=$(print -Pn "%40>...>$a" | tr -d "\n")

  case $TERM in
  screen*)
    print -Pn "\ek$a\e\\"      # screen  (in ^A")
    ;;
  xterm*|rxvt)
    print -Pn "\e]2;$2 | $a:$3\a" # plain xterm 
    ;;
  esac
}

# precmd is called just before the prompt is printed
function precmd() {
  title "zsh" "$USER@%m" "%55<...<%~"
}

# preexec is called just before any command line is executed
function preexec() {
  title "$1" "$USER@%m" "%35<...<%~"
}

## Zsh completion ##
zmodload -i zsh/complist
zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# hosts autocomplete - broken!
#export hosts=(`cat ~/.rc/.hosts`)
#zstyle '*' hosts $hosts
# ps autocomplete
zstyle ':completion:*:processes' command 'ps xua'
zstyle ':completion:*:processes' sort false
zstyle ':completion:*:processes-names' command 'ps xho command'
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'

## Keybindings ##
#bindkey -e

## Startup screen ##
OS=`uname`
if [ "$OS" = "Linux" ]; then
echo -e "I am: "`whoami` on `hostname` - `hostname -i`;
echo -e "ID: "`id`;
echo -e "Sysinfo:" `uname -o` - "Kernel" `uname -r`
echo -e "Status:" `uptime`
elif [ "$OS" = "Darwin" -o "$OS" = "FreeBSD" ]; then
echo -e "I am: "`whoami` on `hostname`
echo -e "ID: "`id`;
echo -e "Sysinfo:" `uname` - "Kernel" `uname -r`
echo -e "Status:" `uptime`
else
echo "You are `whoami` on `hostname` which works on `uname`"
fi

