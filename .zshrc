## ZSH Options ##
unsetopt BG_NICE            # do not nice bg commands
setopt EXTENDED_HISTORY     # puts timestamps in the history
setopt NO_HUP               # don't send kill to background jobs when exiting

## History options ##
export HISTFILE="$HOME/.zsh-history"                      # path to history file
export HISTIGNORE="ls:l:pwd:mc:su:df:clear:fg:bg:history" # ignore some common commands
export HISTSIZE="5000"
export SAVEHIST="1000"
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

# Prompt!
export PS1="%{$fg[green]%}%n%{$fg[cyan]%}@%m%{$reset_color%}%{$fg[green]%} $newPWD%{$reset_color%}$ "

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
zstyle ":completion:*" menu select
zstyle ":completion:*" list-colors ${(s.:.)LS_COLORS}
# hosts autocomplete - broken!
#export hosts=(`cat ~/.rc/.hosts`)
#zstyle '*' hosts $hosts
# ps autocomplete
zstyle ":completion:*:processes" command "ps xua"
zstyle ":completion:*:processes" sort false
zstyle ":completion:*:processes-names" command "ps xho command"
zstyle ":completion:*:*:kill:*:processes" list-colors "=(#b) #([0-9]#)*=0=01;31"

## Keybindings ##
#bindkey -e

# load env variables
if [ -f $HOME/.rc/.sh_env ];
then
    source $HOME/.rc/.sh_env
fi
