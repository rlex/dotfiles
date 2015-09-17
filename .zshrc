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

# add custom completion scripts
autoload -U compinit && compinit
zmodload -i zsh/complist

# man zshcontrib
zstyle ':vcs_info:*' actionformats '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '
zstyle ':vcs_info:*' formats '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{5}]%f '
zstyle ':vcs_info:*' enable git

# Enable completion caching, use rehash to clear
zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path ~/.zsh/cache

# Fallback to built in ls colors
zstyle ':completion:*' list-colors ''

# Make the list prompt friendly
zstyle ':completion:*' list-prompt '%SAt %p: Hit TAB for more, or the character to insert%s'

# Make the selection prompt friendly when there are a lot of choices
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'

# Add simple colors to kill
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'

# list of completers to use
zstyle ':completion:*::::' completer _expand _complete _ignored _approximate

zstyle ':completion:*' menu select=1 _complete _ignored _approximate

# insert all expansions for expand completer
# zstyle ':completion:*:expand:*' tag-order all-expansions

# match uppercase from lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# offer indexes before parameters in subscripts
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

# formatting and messages
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
zstyle ':completion:*' group-name ''


local _myhosts
if [[ -f $HOME/.ssh/known_hosts ]]; then
    _myhosts=( ${${${${(f)"$(<$HOME/.ssh/known_hosts)"}:#[0-9]*}%%\ *}%%,*} )
    zstyle ':completion:*' hosts $_myhosts
else
    zstyle ':completion:*:hosts' hosts
fi

zstyle ':completion:*:*:*:users' ignored-patterns \
        adm amanda apache avahi beaglidx bin cacti canna clamav daemon \
        dbus distcache dovecot fax ftp games gdm gkrellmd gopher \
        hacluster haldaemon halt hsqldb ident junkbust ldap lp mail \
        mailman mailnull mldonkey mysql nagios \
        named netdump news nfsnobody nobody nscd ntp nut nx openvpn \
        operator pcap postfix postgres privoxy pulse pvm quagga radvd \
        rpc rpcuser rpm shutdown squid sshd sync uucp vcsa xfs '_*'


# ignore completion functions (until the _ignored completer)
zstyle ':completion:*:functions' ignored-patterns '_*'
zstyle '*' single-ignored show

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

if [[ ! -z "$SSH_CLIENT" ]]; then
  RPROMPT="$(git_prompt_string) $RPROMPT ⇄" # ssh icon
else
  RPROMPT="$(git_prompt_string)"
fi
