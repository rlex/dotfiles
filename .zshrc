## ZSH Options ##
unsetopt BG_NICE
setopt NO_HUP
setopt AUTO_CD
## History options ##
HISTFILE="$HOME/.zsh-history"
SAVEHIST=10000
HISTSIZE=10000
setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history
setopt share_history

## autoloads ##
autoload -U promptinit; promptinit
autoload -U colors; colors
autoload -U edit-command-line

## ls colors ##
# compatible with both linux (gnu coreutils)
# and mac os x / BSD (bsd coreutils)
if whence dircolors >/dev/null; then
  eval `dircolors ~/.dircolors -b`
else
  export CLICOLOR=1
fi

# proper formatting for shell titles
# more info: http://www.semicomplete.com/blog/productivity/better-zsh-xterm-title-fix.html
function title() {
  # escape '%' chars in $1, make nonprintables visible
  local a=${(V)1//\%/\%\%}

  # Truncate command, and join lines.
  a=$(print -Pn "%40>...>$a" | tr -d "\n")
  case $TERM in
    screen*)
      print -Pn "\e]2;$a @ $2\a" # plain xterm title
      print -Pn "\ek$a\e\\"      # screen title (in ^A")
      print -Pn "\e_$2   \e\\"   # screen location
    ;;
    xterm*)
      print -Pn "\e]2;$a @ $2\a" # plain xterm title
    ;;
  esac
}

# precmd is called just before the prompt is printed
function precmd() {
  title "zsh" "%m:%55<...<%~"
}

# preexec is called just before any command line is executed
function preexec() {
  title "$1" "%m:%35<...<%~"
}

## Zsh completion ##
# Load external files
#Homebrew zsh-only functions
if [ -d /usr/local/share/zsh/site-functions ]; then
  source /usr/local/share/zsh/site-functions
fi

#Homebrew zsh-only completions
if [ -d /usr/local/share/zsh-completions ]; then
  fpath=(/usr/local/share/zsh-completions $fpath)
fi

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

## Keybindings ##
#Create zkbd compatible hash
typeset -A key

key[Up]=${terminfo[kcuu1]}
key[Down]=${terminfo[kcud1]}

#up/arrow keys for complete + history
[[ -n "${key[Up]}"   ]]  && bindkey "${key[Up]}" history-beginning-search-backward
[[ -n "${key[Down]}" ]]  && bindkey "${key[Down]}" history-beginning-search-forward

function zle-line-init () {
    echoti smkx
}
function zle-line-finish () {
    echoti rmkx
}
zle -N zle-line-init
zle -N zle-line-finish

# load env (aliases, functions, etc crap)
# Z* files for ZSH only
# S* files for generic sh-compatible shells
for envfile in ~/.rc/sh.d/[SZ][0-9][0-9]*[^~] ; do
  source $envfile
done

#use fancy fonts only on proper terminal
if [[ $TERM =~ "(256color)" ]]; then
  prompt_symbol="❯"
  ssh_symbol=" ⇣⇡"
else
  prompt_symbol=">"
  ssh_symbol=" <=>"
fi

#there should be a better way to handle that...
if [[ -z "$SSH_CLIENT" ]]; then
  unset ssh_symbol
fi

# Right prompt
RPS1='$(git_prompt_string)'

# Left prompt settings
function precmd {
 # different colors for different return status
 # green - ok, red - non-zero exit
  if [[ $? -eq 0 ]]; then
    prompt_status="%{$fg[green]%}${prompt_symbol} %{$reset_color%}"
  else
    prompt_status="%{$fg[red]%}${prompt_symbol} %{$reset_color%}"
  fi
  if [[ -z "$SSH_CLIENT" ]]; then
    PROMPT="${prompt_status}"
  else
    PROMPT="%{$fg[green]%}%n%{$fg[cyan]%}@%M%{$fg_bold[blue]%}${ssh_symbol} ${prompt_status}"
  fi
}
