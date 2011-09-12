# check for interactive
#if [[ $- != *i* ]] ; then
#         return
#fi

# bash completion
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

# user preferences
# bash-settings
export HISTCONTROL=ignoredups
export HISTSIZE=20000
export HISTFILESIZE=20000
export HISTTIMEFORMAT="[%Y-%m-%d - %H:%M:%S]"
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

#PS1
prompt_command () {
    local rts=$?
    local w="\[\033[1;32m\]\u@\[\033[1;31m\]\h"
    # different colors for different return status
    [ $rts -eq 0 ] && \
    local p="\[\033[1;30m\]>\[\033[0;32m\]>\[\033[1;32m\]>\[\033[m\]" || \
    local p="\[\033[1;30m\]>\[\033[0;31m\]>\[\033[1;31m\]>\[\033[m\]"
    PS1="${w} ${p} "
    case "$TERM" in
    xterm*|rxvt*)
        echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"
        ;;
    *)
        ;;
    esac
}
PROMPT_COMMAND=prompt_command

# load env
for envfile in ~/.rc/sh.d/S[0-9][0-9]*[^~] ; do
    source $envfile
done

