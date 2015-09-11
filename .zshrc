## ZSH Options ##
unsetopt BG_NICE            # do not nice bg commands
setopt EXTENDED_HISTORY     # puts timestamps in the history
setopt NO_HUP               # don't send kill to background jobs when exiting
setopt AUTO_CD              # enter dirname to cd
## History options ##
export HISTFILE="$HOME/.zsh-history"                      # path to history file
SAVEHIST=10000
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
autoload -U promptinit; promptinit
autoload -U colors; colors

## ls colors ##
if whence dircolors >/dev/null; then
  eval `dircolors ~/.dircolors -b`
else
  export CLICOLOR=1
fi

# Prompt!
function precmd {
  # different colors for different return status
  if  [[ $? -eq 0 ]]; then
    PROMPT="%{$fg[green]%}%n%{$fg[cyan]%}@%M%{$fg[green]%}%{$fg[green]%} > %{$reset_color%}"
  else
    PROMPT="%{$fg[green]%}%n%{$fg[cyan]%}@%M%{$fg[green]%}%{$fg[red]%} > %{$reset_color%}"
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
autoload -U bashcompinit; bashcompinit
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
#  * SSH completion. Need clean known_hosts, thought.
[ -f ~/.ssh/config ] && : ${(A)ssh_config_hosts:=${${${${(@M)${(f)"$(<~/.ssh/config)"}:#Host *}#Host }:#*\**}:#*\?*}}
[ -f ~/.ssh/known_hosts ] && : ${(A)ssh_known_hosts:=${${${(f)"$(<$HOME/.ssh/known_hosts)"}%%\ *}%%,*}}
[ -f ~/.ssh/known_hosts.work ] && : ${(A)ssh_known_hosts_debian:=${${${(f)"$(<$HOME/.ssh/known_hosts.work)"}%%\ *}%%,*}}

zstyle ':completion:*:hosts' hosts $ssh_config_hosts $ssh_known_hosts $ssh_known_hosts_work

#Homebrew zsh-only completion
if [ -f /usr/local/share/zsh/site-functions ]; then
  . /usr/local/share/zsh/site-functions
fi

if [ -f /usr/local/share/zsh-completions ]; then
  fpath=(/usr/local/share/zsh-completions $fpath)
fi

## Keybindings ##
#up/arrow keys for complete + history 
bindkey '\e[A' history-beginning-search-backward
bindkey '\e[B' history-beginning-search-forward


# load env
for envfile in ~/.rc/sh.d/S[0-9][0-9]*[^~] ; do
    source $envfile
done
