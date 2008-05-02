# check for interactive
if [[ $- != *i* ]] ; then
         return
fi
# The following stuff only gets done the first time the login shell is started
if [  ! $ENV_DONE ]; then
   export ENV_DONE=TRUE

# Configure path based on OS type
CHECK_OS=`uname -a | awk '{print $3}'`
case $CHECK_OS in

5.*) #Solaris 2.* found
export PATH=".\
:/h/jlarsen/bin\
:/h/jlarsen/vim/bin\
:/usr/local/bin\
:/usr/bin\
:/bin\
:/usr/sbin\
:/opt/bin\
:/usr/ucb\
:/opt/rational/clearcase/bin\
:/usr/atria/bin\
:/u/scripts/testscripts\
:/u/scripts\
:/usr/local/bin"
;;

2.*) #Linux 2.* kernels
export PATH=".\
:~/bin\
:/usr/sbin\
:/sbin\
:/usr/local/bin\
:/bin\
:/usr/bin\
:/usr/X11R6/bin\
:/usr/games\
:$PATH"
;;

1.5.*) # cygwin 1.5.* running on a Windows host
export PATH=".\
:~/bin\
:/usr/sbin\
:$PATH"
;;

*) #Unknown OS 
echo "Unknown OS type detected in .bashrc: `uname -a | awk '{print $1,$3}'`"
;;
esac
fi
# Setup the prompt and other aliases based on OS version and ClearCase use
if [ $CLEARCASE_ROOT ]; then
	VIEW="`basename $CLEARCASE_ROOT` - "
else
	VIEW=""
fi
CHECK_OS=`uname -a | awk '{print $3}'`
#echo "debug> setting up the prompt: $CHECK_OS"
case $CHECK_OS in
	5.8) #Solaris 2.8 found
		stty erase 
      # Check if this is a root shell
		UID_VALUE=`id | awk '{print $1}'`
		if [ "$UID_VALUE" = "uid=0(root)" ]; then
			PS1='\e[1;31m\]\e[7m[\h - ${VIEW}\u ] [\w]\e[m\]\e[27m\n[\!]$ '
		else
			PS1='\e[7m[\h - ${VIEW}\u ] [\w]\e[27m\n[\!]$ '
		fi
		alias v="/usr/bin/vi"
		alias vi="~/vim/bin/gvim"
		alias vd="~/vim/bin/gvim -d"
		alias vim="~/vim/bin/vim"
	;;

	5.7) #Solaris 2.7 found
		stty erase 
		PS1='`tput smso`[\h - ${VIEW}\u ] [\w]`tput rmso`\n[\!]$ '
		alias v="/usr/bin/vi"
		alias vi="~/vim/bin/gvim"
		alias vd="~/vim/bin/gvim -d"
		alias vim="~/vim/bin/vim"
	;;

	5.5.1) #SunOs 5.5.1 ie. outback
		stty erase 
		PS1='`tput smso`[\h - ${VIEW}\u ] [\w]`tput rmso`\n[\!]$ '
		alias v="/usr/bin/vi"
		alias vi="~/vim/bin/gvim"
		alias vd="~/vim/bin/gvim -d"
		alias vim="~/vim/bin/vim"
	;;
	2.4.*) #Linux 2.4 kernels
#echo "debug> Inside 2.4"
		stty erase 
      # Check if this is a root shell
		UID_VALUE=`id | awk '{print $1}'`
		if [ "$UID_VALUE" = "uid=0(root)" ]; then
			PS1='${debian_chroot:+($debian_chroot)}'${prompt_color}'\u@\h'${sh_norm}':'${sh_light_blue}'\w'${sh_norm}' $(smiley) ${ERROR_FLAG:+'${sh_light_red}'}\$${ERROR_FLAG:+'${sh_norm}'} '
		else
			PS1='${debian_chroot:+($debian_chroot)}'${prompt_color}'\u@\h'${sh_norm}':'${sh_light_blue}'\w'${sh_norm}' $(smiley) ${ERROR_FLAG:+'${sh_light_red}'}\$${ERROR_FLAG:+'${sh_norm}'} '
		fi
	;;

	2.6.*) #Linux 2.6 kernels
#echo "debug> Inside 2.6"
		stty erase 
      # Check if this is a root shell
		UID_VALUE=`id | awk '{print $1}'`
		if [ "$UID_VALUE" = "uid=0(root)" ]; then
			PS1='${debian_chroot:+($debian_chroot)}'${prompt_color}'\u@\h'${sh_norm}':'${sh_light_blue}'\w'${sh_norm}' $(smiley) ${ERROR_FLAG:+'${sh_light_red}'}\$${ERROR_FLAG:+'${sh_norm}'} '
		else
#echo "debug> Inside 2.6 non root"
			PS1='${debian_chroot:+($debian_chroot)}'${prompt_color}'\u@\h'${sh_norm}':'${sh_light_blue}'\w'${sh_norm}' $(smiley) ${ERROR_FLAG:+'${sh_light_red}'}\$${ERROR_FLAG:+'${sh_norm}'} '
		fi
	;;

	1.5.*) #cygwin shell.  Some alias paths are different on Windows.  Change those here.
		PS1='\e[7m[\h - ${VIEW}\u ] [\w]\e[27m\n[\!]$ '
	;;

	*) #Unknown OS.  Be safe and use the slower way for PS1
		stty erase 
		echo "Unknown OS type detected in .bashrc: `uname -a | awk '{print $1,$3}'`"
		PS1='`tput smso`[\h - ${VIEW}\u ] [\w]`tput rmso`\n[\!]$ '
	;;
esac

# bash completion
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi
# toast
if [ -f $HOME/.toast/armed/bin/toast ]; then
    eval `$HOME/.toast/armed/bin/toast env`
fi
# if xterm
case "$TERM" in
xterm*|rxvt*)
        PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'
        ;;
*)
        ;;
esac
# debian-chroot
if [ -z "$debian_chroot" -a -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi
# timeout
if vt=`/bin/fgconsole 2>/dev/null`; then
    (($vt > 0)) && (($vt <= 6)) && TMOUT=300
fi
# user preferences
# exports
export PAGER=less
export EDITOR=vi
export LESS='-R'
export PATH=$PATH:$HOME/bin:/usr/local/bin
export LESSCHARSET=utf-8
# bash-settings
export HISTCONTROL=ignoredups
export HISTSIZE=20000
export HISTFILESIZE=20000
export HISTTIMEFORMAT="[%Y-%m-%d - %H:%M:%S] "
export HISTIGNORE="&:ls:ll:la:l:pwd:exit:clear:b:r:exit:env:date:.:..:...:....:.....:pwd:cfg:rb:eb:!!:fg:bg:cd:h:mc"
export CLICOLOR=1
shopt -s checkwinsize
shopt -s extglob
shopt -s nocaseglob
shopt -s nullglob dotglob
shopt -s histappend 
shopt -s cdspell
complete -cf sudo
stty -ixon 
set -o noclobber
set -o notify
# using tty1-6, log out after 5 minutes of inactivity
if vt=`/bin/fgconsole 2>/dev/null`; then
    (($vt > 0)) && (($vt <= 6)) && TMOUT=300
fi

# aliases
alias ls='ls --color'
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'
alias back='cd $OLDPWD'
alias cd..='cd ..'
alias df='df -h'
alias du='du -h -c'
alias mkdir='mkdir -p -v'
alias ..='cd ..'
alias grep='grep --color=auto'
alias ncmpc='ncmpc -c'
alias daemons='ls /var/run/daemons'
alias jobslist='jobs -l'
alias nano='nano -w'
alias more='less'
alias pgrep="pgrep -l"
alias recent="ls -lAt | head"
alias cls='clear'
alias h='history'
alias ssh='ssh -C'
alias killhup='killall -1'
alias killterm='pkill -9'
alias r='screen -DRA' resume='screen -DRA'
alias -- -search="sudo apt-cache search"
alias -- -show="sudo apt-cache show"
alias -- -install="sudo apt-get install"
alias -- -remove="sudo apt-get remove"
alias -- -update="sudo apt-get update"
alias -- -upgrade="sudo apt-get upgrade"
alias -- -source="sudo dpkg -S"
alias -- -list="sudo dpkg -l"
alias -- -files="sudo dpkg -L"

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
# the name of my primary (local) machine
GRP=$(groups |sed 's/ .*//')
if [ "$GRP" != "$USER" ]; then
        prompt_group=$GRP
fi
if [ "$UID_VALUE" = "uid=0(root)" ]; then
        prompt_color=$sh_light_red
else
        prompt_color=$sh_light_green
fi
PS1='${debian_chroot:+($debian_chroot)}'${prompt_color}'\u@\h'${sh_norm}':'${sh_light_blue}'\w'${sh_norm}' $(smiley) ${ERROR_FLAG:+'${sh_light_red}'}\$${ERROR_FLAG:+'${sh_norm}'} '

# Set an error flag to be used in our prompt.
PROMPT_COMMAND='if [ $? -ne 0 ]; then ERROR_FLAG=1; else ERROR_FLAG=; fi; '
## functions
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
# SmiliePrompt
smiley() { if [ $? == 0 ]; then echo '^_^'; else echo '0_o'; fi; }
# psgrep
psgrep() {
        if [ ! -z $1 ] ; then
                echo "Grepping for processes matching $1..."
                ps aux | grep $1 | grep -v grep
        else
                echo "!! Need name to grep for"
        fi
}
grab() {
        sudo chown -R ${USER} ${1:-.}
}
have() {
        type "$1" &> /dev/null
}
# now set up some aliases again...
have htop && alias top='htop'
#have perl && alias gettoast='perl -e 'socket(S,2,1,0)&&connect(S,pack("Sna4x8",2,80,gethostbyname(
#      "toastball.net")||die("dns")))&&syswrite(S,"GET /toast/toast\n")&&
#      open(STDIN,"<&S")&&exec($^X,qw(-x - arm toast))||die($!)''
#have GET && alias gettoast='GET http://toastball.net/toast/toast|perl -x - arm toast'
have wget && alias gettoast='wget -O- http://toastball.net/toast/toast|perl -x - arm toast'
# calculator
function calc () {
    gawk -v CONVFMT="%12.2f" -v OFMT="%.9g"  "BEGIN { print $* ; }"
    }
# startup screen
clear
echo -e "I am: "`whoami` on `hostname` - `hostname -i`;
echo -e "ID: "`id`;
echo -e "Sysinfo:" `uname -o` - "Kernel" `uname -r` 
echo -e "Status:" `uptime`
# dotfiles management
function dotfiles-get () {
  [ -z $1 ] \
    && echo -e "Usage:\n    $FUNCNAME [user@]hostname [ssh-args]" \
    || ( mkdir -p $HOME/.dotfile-backup; cp $HOME/.{bashrc,bash_profile,nanorc,screenrc} $HOME/.dotfile-backup; scp $2 $1:'$HOME/.{bashrc,bash_profile,nanorc,screenrc}' $HOME );
}

function dotfiles-drop () {
  [ -z $1 ] \
    && echo -e "Usage:\n    $FUNCNAME [user@]hostname [ssh-args]" \
    || ( ssh $1 'mkdir -p $HOME/.dotfile-backup; cp $HOME/.{bashrc,bash_profile,nanorc,screenrc} $HOME/.dotfile-backup'; scp $HOME/.{bashrc,bash_profile,nanorc,screenrc} $2 $1:'$HOME' );
}

forecast() {
_ZIP=$1
if   [ $# = 1 ];then
     printf "$_ZIP\n" | egrep '^[0-9][0-9][0-9][0-9][0-9]$' >>/dev/null
     if   [ $? = 0 ];then
          printf "Your 10 Day Weather Forecast as follows:\n";
          lynx -dump "http://www.weather.com/weather/print/$_ZIP" | sed -n '/%$/s/\[.*\]//p';
          printf "\n"
     elif [ $? = 1 ];then
          printf "Bad ZIP code!\n"
     fi
elif [ $# != 1 ];then
     printf "You need to supply a ZIP code!\n"
fi
} 
function h () {
	local list_size=10

	# If $1 is a number then just execute it without displaying list
	if [ $1 ]; then
		local command=`fc -ln  $1 $1`
		echo $command
		$command
		return
	fi

   # Initialize the bottom of the list
	local bottom=$HISTSIZE
	let bottom=HISTCMD-HISTSIZE
	if [ $bottom -lt 1 ];then
		bottom=1
	fi

   # Setup the start of the listing
	local start=$HISTCMD
	let start=start-list_size
	if [ $start -lt $bottom ];then
		start=$bottom
	fi

   # Setup the end of the listing
	local stop=$HISTCMD
	let stop=stop-2

   # Display the first listing
	fc -lr  $start $stop

   # Get user input on what to do next
	local response=""
	while [ "$response" = "" ]; do
		read -a response -p "> "
      # Display next listing if enter pressed
		if [ "$response" = "" ]; then
			let stop=start-1
			if [ $stop -le $bottom ];then
				stop=$bottom
			fi
			let start=start-list_size
			if [ $start -lt $bottom ];then
				start=$bottom
			fi
			fc -lr  $start $stop
		fi
	done

	# Exit if dot pressed
	if [ "$response" = "." ]; then 
		return
	fi

   # Try to execute the line number entered by user
	local command=`fc -ln  $response $response`
	echo "$command" >| /tmp/$$.command
	chmod 700 /tmp/$$.command
	/tmp/$$.command
	rm -f /tmp/$$.command
} # h
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
