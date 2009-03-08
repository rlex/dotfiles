# autoloads
autoload -U compinit
autoload -U promptinit
autoload colors
colors
compinit
promptinit

# path
export PATH=~/bin:$PATH:/usr/local/sbin:/sbin:/usr/local/bin:/usr/local/sbin:/usr/libexec:/opt/local/bin:/opt/local/sbin:/usr/local/mysql/bin
# Path for ruby gems
export PATH=$PATH:/var/lib/gems/1.8/bin

# manpath
export MANPATH=$MANPATH:/usr/local/man:/opt/local/share/man

# abbreviation
export EDITOR=vim
export PAGER=more

# CVS for HeX
#export CVSROOT=:ext:dakrone@cvsup.rawpacket.org:/home/project/rawpacket/cvs

# set aliases
alias mv='nocorrect mv'       # no spelling correction on mv
alias cp='nocorrect cp'
alias mkdir='nocorrect mkdir'
alias j=jobs
if ls -F --color=auto >&/dev/null; then
  alias ls="ls --color=auto -F"
else
  alias ls="ls -F"
fi
alias l.='ls -d .*'
alias ll='ls -lh'
alias la='ls -alh'
alias lr='ls -lR'
alias less='less -FRX'
alias grep='egrep -i --color=auto'
alias cd..='cd ..'
alias ..='cd ..'
alias nsmc='cd ~/src/ruby/nsm-console'
alias serv='cat /etc/services | grep'
alias pg='ps aux | grep'
alias nl='sudo netstat -tunapl'
alias dmesg='sudo dmesg'
alias remhex='ssh -i ~/.ssh/id_rawpacket dakrone@localhost -p 6666'
alias remblack='ssh -i ~/.ssh/id_rawpacket hinmanm@localhost -p 7777'
alias scsetup='sudo socat -d -d TCP4-listen:6666,fork OPENSSL:hexbit:443,cert=host.pem,verify=0'
alias scsetup2='sudo socat -d -d TCP4-listen:7777,fork OPENSSL:blackex:443,cert=host.pem,verify=0'
alias blackexprox='ssh -i ~/.ssh/id_rawpacket -ND 9999 hinmanm@localhost -p 7777'
alias blackprox='ssh -i ~/.ssh/id_rawpacket -ND 9999 hinmanm@black'
alias tcpdump='tcpdump -ttttnnn'

# history
HISTFILE=$HOME/.zsh-history
HISTSIZE=5000
SAVEHIST=1000
setopt appendhistory autocd extendedglob
setopt share_history
function history-all { history -E 1 }

# functions
mdc() { mkdir -p "$1" && cd "$1" }
setenv() { export $1=$2 }  # csh compatibility
sdate() { date +%Y.%m.%d }
pc() { awk "{print \$$1}" }
rot13 () { tr "[a-m][n-z][A-M][N-Z]" "[n-z][a-m][N-Z][A-M]" }
function maxhead() { head -n `echo $LINES - 5|bc` ; }
function maxtail() { tail -n `echo $LINES - 5|bc` ; }

# get current revision of a repo
function svn_revision { 
  svn info $@ | awk '/^Revision:/ {print $2}'
}
# print the log or 'no changes' after an update
function svn_up_and_log {
  local old_rev=$(svn_revision $@)
  local first_up=$((${old_rev} + 1))
  svn up -q $@
  if [ $(svn_revision $@) -gt ${old_rev} ]; then
    svn log -v -rHEAD:${first_up} $@
  else
    echo "No changes."
  fi
}
# tag a directory in a command to come to it later
function tag {
  alias $1='cd $PWD'
}
function bestcompress {
Z="compress"
gz="gzip" 
bz="bzip2"
Zout="/tmp/bestcompress.$$.Z"
gzout="/tmp/bestcompress.$$.gz"
bzout="/tmp/bestcompress.$$.bz"
skipcompressed=1

if [ "$1" = "-a" ] ; then
  skipcompressed=0  ; shift
fi

if [ $# -eq 0 ]; then
  echo "Usage: $0 [-a] file or files to optimally compress" >&2
fi

trap "/bin/rm -f $Zout $gzout $bzout"

for name 
do 
  if [ ! -f "$name" ] ; then 
    echo "$0: file $name not found. Skipped." >&2
    continue
  fi

  if [ "$(echo $name | egrep '(\.Z$|\.gz$|\.bz2$)')" != "" ] ; then
    if [ $skipcompressed -eq 1 ] ; then
      echo "Skipped file ${name}: it's already compressed." 
      continue
    else
      echo "Warning: Trying to double-compress $name" 
    fi
  fi

  $Z  < "$name" > $Zout  &
  $gz < "$name" > $gzout &
  $bz < "$name" > $bzout &
  
  wait	# run compressions in parallel for speed. Wait until all are done

  smallest="$(ls -l "$name" $Zout $gzout $bzout | \
     awk '{print $5"="NR}' | sort -n | cut -d= -f2 | head -1)"

  case "$smallest" in
     1 ) echo "No space savings by compressing $name. Left as-is."
	 ;;
     2 ) echo Best compression is with compress. File renamed ${name}.Z
         mv $Zout "${name}.Z" ; rm -f "$name"
	 ;;
     3 ) echo Best compression is with gzip. File renamed ${name}.gz
	 mv $gzout "${name}.gz" ; rm -f "$name"
	 ;;
     4 ) echo Best compression is with bzip2. File renamed ${name}.bz2
	 mv $bzout "${name}.bz2" ; rm -f "$name"
  esac

done
}
function dirdiff () {
        diff -yB -W 80 <(ls -1 --color=never $1) <(ls -1 --color=never $2)
}
function zomb_ps () {
        ps hr -Nos | awk '$1=="Z" {print $1}'
}
function fixtty () {
	stty sane
	reset
}
function ff () {
   if [[ -z $1 ]]; then
      echo "Find files recursively starting at \`pwd\` - usage: ff pattern"
      return
   fi

   find . -type f \( -name "*$1*" -o -name ".$1*" -o -name ".*.*$1*" -o -name "*$1*.*" \) -print
}
function fd () {
   if [[ -z $1 ]]; then
      echo "Find directories recursively starting at \`pwd\` - usage: fd pattern"
      return
   fi

   find . -type d \( -name "*$1*" -o -name ".$1*" -o -name ".*.*$1*" -o -name "*$1*.*" \) -print
}
function wf () {
   # Use sed to replace field divider ":" with "  |  " so the output is easier to read
   find . -type f \( -name "*" -o -name ".*" \) -a -exec fgrep -n "$1" {} /dev/null \; | sed -e 's/:/  |  /g'
}
# ps grepper
psgrep() {
        if [ ! -z $1 ] ; then
                echo "Grepping for processes matching $1..."
                ps aux | grep $1 | grep -v grep
        else
                echo "!! Need name to grep for"
        fi
}
# backuper
bu ()
{
    if [ "`dirname $1`" == "." ]; then
        mkdir -p ~/.backup/`pwd`;
        cp $1 ~/.backup/`pwd`/$1-`date +%Y%m%d%H%M`.backup;
    else
        mkdir -p ~/.backup/`dirname $1`;
        cp $1 ~/.backup/$1-`date +%Y%m%d%H%M`.backup;
    fi
} 
# extractor
ee () {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xjf $1        ;;
            *.tar.gz)    tar xzf $1     ;;
            *.bz2)       bunzip2 $1       ;;
            *.rar)       rar x $1     ;;
            *.gz)        gunzip $1     ;;
            *.tar)       tar xf $1        ;;
            *.tbz2)      tar xjf $1      ;;
            *.tgz)       tar xzf $1       ;;
            *.zip)       unzip $1     ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1    ;;
            *)           echo "'$1' cannot be extracted via ee()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}
# startup screen
clear
echo -e "I am: "`whoami` on `hostname` - `hostname -i`;
echo -e "ID: "`id`;
echo -e "Sysinfo:" `uname -o` - "Kernel" `uname -r` 
echo -e "Status:" `uptime`

# prompt (if running screen, show window #)
if [ x$WINDOW != x ]; then
    # [5:hinmanm@dagger:~]% 
    export PS1="%{$fg[blue]%}[%{$fg[cyan]%}$WINDOW%{$fg[blue]%}:%{$fg[green]%}%n%{$fg[cyan]%}@%{$fg[green]%}%m%{$fg[blue]%}:%{$fg[magenta]%}%~%{$fg[blue]%}]%{$reset_color%}%# "
else
    # [hinmanm@dagger:~]% 
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
    print -Pn "\ek$a\e\\"      # screen title (in ^A")
    ;;
  xterm*|rxvt)
    print -Pn "\e]2;$2 | $a:$3\a" # plain xterm title
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

## For the "ZoomGo" ruby file
function zg () {
  eval cd `zg.rb $1`
}

# colorful listings
zmodload -i zsh/complist
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' hosts $ssh_hosts
zstyle ':completion:*:my-accounts' users-hosts $my_accounts
zstyle ':completion:*:other-accounts' users-hosts $other_accounts

### OPTIONS ###
unsetopt BG_NICE		      # do NOT nice bg commands
setopt EXTENDED_HISTORY		# puts timestamps in the history
setopt NO_HUP                 # don't send kill to background jobs when exiting

# Keybindings
bindkey -e
bindkey "^?"    backward-delete-char
bindkey "^H"    backward-delete-char
bindkey "^[[3~" backward-delete-char
bindkey "^[[1~" beginning-of-line
bindkey "^[[4~" end-of-line

bindkey '^r' history-incremental-search-backward
bindkey "^[[5~" up-line-or-history
bindkey "^[[6~" down-line-or-history
bindkey "^A" beginning-of-line
bindkey "^E" end-of-line
bindkey "^W" backward-delete-word
bindkey "^b" backward-word
bindkey "^f" forward-word
bindkey "^d" delete-word
bindkey "^k" kill-line
bindkey ' ' magic-space    # also do history expansion on space
bindkey '^I' complete-word # complete on tab, leave expansion to _expand
