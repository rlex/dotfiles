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
if [ -x /usr/bin/dircolors ]; then
    eval `dircolors ~/.dircolors -b`
fi

# Prompt!
function precmd {
    # different colors for different return status
    if  [[ $? -eq 0 ]]; then
    PROMPT="%{$fg[green]%}%n%{$fg[cyan]%}@%m%{$fg[green]%}%{$fg[green]%} > %{$reset_color%}"
    else
    PROMPT="%{$fg[green]%}%n%{$fg[cyan]%}@%m%{$fg[green]%}%{$fg[red]%} > %{$reset_color%}"
    fi
}


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
#function precmd() {
 #title "zsh" "$USER@%m" "%55<...<%~"
#}

# preexec is called just before any command line is executed
function preexec() {
  title "$1" "$USER@%m" "%35<...<%~"
}

## Zsh completion ##
# New style completion system
autoload -U compinit; compinit
#  * List of completers to use
zstyle ":completion:*" completer _complete _match _approximate
#  * Allow approximate
zstyle ":completion:*:match:*" original only
zstyle ":completion:*:approximate:*" max-errors 1 numeric
#  * Selection prompt as menu
zstyle ":completion:*" menu select=1
#  * Menu selection for PID completion
zstyle ":completion:*:*:kill:*" menu yes select
zstyle ":completion:*:kill:*" force-list always
zstyle ":completion:*:processes" command "ps -au$USER"
zstyle ":completion:*:*:kill:*:processes" list-colors "=(#b) #([0-9]#)*=0=01;32"
#  * Don't select parent dir on cd
zstyle ":completion:*:cd:*" ignore-parents parent pwd
#  * Complete with colors
zstyle ":completion:*" list-colors ""

## Keybindings ##
#bindkey -e

# load env
for envfile in ~/.rc/sh.d/S[0-9][0-9]*[^~] ; do
    source $envfile
done
