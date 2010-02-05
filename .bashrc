# check for interactive
if [[ $- != *i* ]] ; then
         return
fi

# bash completion
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# load env variables
if [ -f $HOME/.rc/.sh_env ];
  then
        source $HOME/.rc/.sh_env
fi

# if xterm
case "$TERM" in
xterm*|rxvt*)
        PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'
        ;;
*)
        ;;
esac

# user preferences
# exports
export PAGER=less
export EDITOR=nano
export LESS='-R'
export PATH=$PATH:$HOME/bin:/usr/local/bin
export LESSCHARSET=utf-8
# bash-settings
export HISTCONTROL=ignoredups
export HISTSIZE=20000
export HISTFILESIZE=20000
export HISTTIMEFORMAT="[%Y-%m-%d - %H:%M:%S] "
export HISTIGNORE="&:ls:ll:la:l:pwd:exit:clear:b:r:exit:env:date:.:..:...:....:.....:pwd:cfg:rb:eb:!!:fg:bg:cd:h:mc"
export HISTFILE=~/.bash_history
export CLICOLOR=1
shopt -s checkwinsize
shopt -s extglob
shopt -s nocaseglob
shopt -s nullglob dotglob
shopt -s histappend 
shopt -s cdspell
shopt -s hostcomplete 
shopt -s execfail       
set -o notify           
complete -cf sudo
shopt -s no_empty_cmd_completion 
stty -ixon 
set -o noclobber
set completion-ignore-case on
set match-hidden-files on
set show-all-if-ambiguous on
# using tty1-6, log out after 5 minutes of inactivity
if vt=`/bin/fgconsole 2>/dev/null`; then
    (($vt > 0)) && (($vt <= 6)) && TMOUT=300
fi

#colors
sh_norm="\[\033[0m\]"
sh_black="\[\033[0;30m\]"
sh_darkgray="\[\033[1;30m\]"
sh_blue="\[\033[0;34m\]"
sh_light_blue="\[\033[1;34m\]"
sh_green="\[\033[0;32m\]"
sh_light_green="\[\033[1;32m\]"
sh_cyan="\[\033[0;36m\]"
sh_light_cyan="\[\033[1;36m\]"
sh_red="\[\033[0;31m\]"
sh_light_red="\[\033[1;31m\]"
sh_purple="\[\033[0;35m\]"
sh_light_purple="\[\033[1;35m\]"
sh_brown="\[\033[0;33m\]"
sh_yellow="\[\033[1;33m\]"
sh_light_gray="\[\033[0;37m\]"
sh_white="\[\033[1;37m\]"
#PS1
GRP=$(groups |sed 's/ .*//')
if [ "$UID_VALUE" = "uid=0(root)" ]; then
        prompt_color=$sh_light_red
else
        prompt_color=$sh_light_green
fi
PS1='${debian_chroot:+($debian_chroot)}'${prompt_color}'\u@\h'${sh_norm}':'${sh_light_blue}'\w'${sh_norm}' $(smiley) ${ERROR_FLAG:+'${sh_light_red}'}\$${ERROR_FLAG:+'${sh_norm}'} '

# Set an error flag to be used in our prompt.
PROMPT_COMMAND='if [ $? -ne 0 ]; then ERROR_FLAG=1; else ERROR_FLAG=; fi; '
## functions
# SmiliePrompt
smiley() { if [ $? == 0 ]; then echo '^_^'; else echo '0_o'; fi; }
function calc () {
    gawk -v CONVFMT="%12.2f" -v OFMT="%.9g"  "BEGIN { print $* ; }"
    }
# startup screen
clear
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
fi
