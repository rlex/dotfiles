## Options ##
# 1 for true, any other for false
export ext_functions="1"
export ext_alias="1"
export ext_toast="1"

## ZSH Options ##
unsetopt BG_NICE		      # do NOT nice bg commands
setopt EXTENDED_HISTORY		# puts timestamps in the history
setopt NO_HUP                 # don't send kill to background jobs when exiting

## History options ##
HISTFILE=$HOME/.zsh-history
HISTSIZE=5000
SAVEHIST=1000
setopt appendhistory autocd extendedglob
setopt share_history

## autoloads ##
autoload -U compinit
autoload -U promptinit
autoload -U colors
## inits ##
colors
compinit
promptinit

## Paths ##
# main path 
export PATH=~/bin:$PATH:/usr/local/sbin:/sbin:/usr/local/bin:/usr/local/sbin:/usr/libexec:/opt/local/bin:/opt/local/sbin:/usr/local/mysql/bin
# path for ruby1.8 in archlinux
export PATH=/opt/ruby1.8/bin:$PATH
# Path for ruby gems in homedir
export PATH=$PATH:~/.gem/ruby/1.8/bin
# path for mans
export MANPATH=$MANPATH:/usr/local/man:/opt/local/share/man

# variables
export EDITOR=vim
export VISUAL=vim
export PAGER=more

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

# prompt (if running screen, show window #)
if [ x$WINDOW != x ]; then
    # [5:xdemon@mainframe:~]% 
    export PS1="%{$fg[blue]%}[%{$fg[cyan]%}$WINDOW%{$fg[blue]%}:%{$fg[green]%}%n%{$fg[cyan]%}@%{$fg[green]%}%m%{$fg[blue]%}:%{$fg[magenta]%}%~%{$fg[blue]%}]%{$reset_color%}%# "
else
    # [xdemon@mainframe:~]% 
    export PS1="%{$fg[blue]%}[%{$fg[green]%}%n%{$fg[cyan]%}@%{$fg[green]%}%m%{$fg[blue]%}:%{$fg[magenta]%}%~%{$fg[blue]%}]%{$reset_color%}%# "
fi
export RPRMOPT="%{$reset_color%}"


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
zstyle ':completion:*' hosts $ssh_hosts
zstyle ':completion:*:my-accounts' users-hosts $my_accounts
zstyle ':completion:*:other-accounts' users-hosts $other_accounts

## Keybindings ##
#bindkey -e

## Startup screen ##
clear
echo -e "I am: "`whoami` on `hostname` - `hostname -i`;
echo -e "ID: "`id`;
echo -e "Sysinfo:" `uname -o` - "Kernel" `uname -r` 
echo -e "Status:" `uptime`