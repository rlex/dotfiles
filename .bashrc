# check for interactive
if [[ $- != *i* ]] ; then
         return
fi
# eval `$HOME/.toast/armed/bin/toast env`
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
		stty erase $'\177'
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
		stty erase $'\177'
		PS1='`tput smso`[\h - ${VIEW}\u ] [\w]`tput rmso`\n[\!]$ '
		alias v="/usr/bin/vi"
		alias vi="~/vim/bin/gvim"
		alias vd="~/vim/bin/gvim -d"
		alias vim="~/vim/bin/vim"
	;;

	5.5.1) #SunOs 5.5.1 ie. outback
		stty erase $'\177'
		PS1='`tput smso`[\h - ${VIEW}\u ] [\w]`tput rmso`\n[\!]$ '
		alias v="/usr/bin/vi"
		alias vi="~/vim/bin/gvim"
		alias vd="~/vim/bin/gvim -d"
		alias vim="~/vim/bin/vim"
	;;
	2.4.*) #Linux 2.4 kernels
#echo "debug> Inside 2.4"
		stty erase $'\177'
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
		stty erase $'\177'
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
# check for sudo need
if [ "$UID_VALUE" = "uid=0(root)" ]; then
        needsudo=
	else
        needsudo=sudo
fi
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
export CLICOLOR=1
export INPUTRC=~/.inputrc
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
alias -- -search="$needsudo aptitude search"
alias -- -show="$needsudo aptitude show"
alias -- -install="$needsudo aptitude install"
alias -- -remove="$needsudo aptitude remove"
alias -- -update="$needsudo aptitude update"
alias -- -upgrade="$needsudo aptitude upgrade"
alias -- -source="$needsudo dpkg -S"
alias -- -list="$needsudo dpkg -l"
alias -- -files="$needsudo dpkg -L"
alias nosmilies="PS1='${debian_chroot:+($debian_chroot)}'${prompt_color}'\u@\h'${sh_norm}':'${sh_light_blue}'\w'${sh_norm}'${ERROR_FLAG:+'${sh_light_red}'}\$${ERROR_FLAG:+'${sh_norm}'} '"
alias yessmilies="PS1='${debian_chroot:+($debian_chroot)}'${prompt_color}'\u@\h'${sh_norm}':'${sh_light_blue}'\w'${sh_norm}' $(smiley) ${ERROR_FLAG:+'${sh_light_red}'}\$${ERROR_FLAG:+'${sh_norm}'} '"
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
    || ( mkdir -p $HOME/.dotfile-backup; cp $HOME/.{bashrc,bash_profile,nanorc,screenrc,inputrc} $HOME/.dotfile-backup; scp $2 $1:'$HOME/.{bashrc,bash_profile,nanorc,screenrc,inputrc}' $HOME );
}

function dotfiles-drop () {
  [ -z $1 ] \
    && echo -e "Usage:\n    $FUNCNAME [user@]hostname [ssh-args]" \
    || ( ssh $1 'mkdir -p $HOME/.dotfile-backup; cp $HOME/.{bashrc,bash_profile,nanorc,screenrc,inputrc} $HOME/.dotfile-backup'; scp $HOME/.{bashrc,bash_profile,nanorc,screenrc,inputrc} $2 $1:'$HOME' );
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
       
cpx() {   
		if [ -z "$1" -o -z "$2" ]
        then
                echo Usage: cpx src dest
                return 1
        fi

        tar cpf - $1 | (cd $2 && tar xvpBf -)
        return $?
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
function validate {
errors=0

in_path()
{
  # given a command and the PATH, try to find the command. Returns
  # 1 if found, 0 if not.  Note that this temporarily modifies the
  # the IFS input field seperator, but restores it upon completion.
  cmd=$1    path=$2    retval=0

  oldIFS=$IFS; IFS=":"

  for directory in $path 
  do
    if [ -x $directory/$cmd ] ; then
      retval=1      # if we're here, we found $cmd in $directory
    fi
  done
  IFS=$oldIFS
  return $retval
}

validate()
{
  varname=$1    varvalue=$2
  
  if [ ! -z $varvalue ] ; then
    if [ "${varvalue%${varvalue#?}}" = "/" ] ; then
      if [ ! -x $varvalue ] ; then
        echo "** $varname set to $varvalue, but I cannot find executable."
        errors=$(( $errors + 1 ))
      fi
    else
      if in_path $varvalue $PATH ; then 
        echo "** $varname set to $varvalue, but I cannot find it in PATH."
        errors=$(( $errors + 1 ))
      fi
    fi 
  fi
}

####### Beginning of actual shell script #######

if [ ! -x ${SHELL:?"Cannot proceed without SHELL being defined."} ] ; then
  echo "** SHELL set to $SHELL, but I cannot find that executable."
  errors=$(( $errors + 1 ))
fi

if [ ! -d ${HOME:?"You need to have your HOME set to your home directory"} ]
then
  echo "** HOME set to $HOME, but it's not a directory."
  errors=$(( $errors + 1 ))
fi

# Our first interesting test: are all the paths in PATH valid?

oldIFS=$IFS; IFS=":"     # IFS is the field separator. We'll change to ':'

for directory in $PATH
do
  if [ ! -d $directory ] ; then
      echo "** PATH contains invalid directory $directory"
      errors=$(( $errors + 1 ))
  fi
done

IFS=$oldIFS             # restore value for rest of script

# The following can be undefined, and they can also be a progname, rather
# than a fully qualified path.  Add additional variables as necessary for
# your site and user community.

validate "EDITOR" $EDITOR
validate "MAILER" $MAILER
validate "PAGER"  $PAGER

# and, finally, a different ending depending on whether errors > 0

if [ $errors -gt 0 ] ; then
  echo "Errors encountered. Please notify sysadmin for help."
else
  echo "Your environment checks out fine."
  return
fi
}

function diskhogs {
MAXDISKUSAGE=20
violators="/tmp/diskhogs0.$$"

trap "/bin/rm -f $violators" 0

for name in $(cut -d: -f1,3 /etc/passwd | awk -F: '$2 > 99 { print $1 }')
do
  echo -n "$name "
  
  find / /usr /var /Users -user $name -xdev -type f -ls | \
      awk '{ sum += $7 } END { print sum / (1024*1024) }'

done | awk "\$2 > $MAXDISKUSAGE { print \$0 }" > $violators

if [ ! -s $violators ] ; then
  echo "No users exceed the disk quota of ${MAXDISKUSAGE}MB"
  cat $violators
fi

while read account usage ; do

   cat << EOF | fmt | mail -s "Warning: $account Exceeds Quota" $account
Your disk usage is ${usage}MB but you have only been allocated 
${MAXDISKUSAGE}MB.  This means that either you need to delete some of 
your files, compress your files (see 'gzip' or 'bzip2' for powerful and
easy-to-use compression programs), or talk with us about increasing
your disk allocation.

Thanks for your cooperation on this matter.

Dave Taylor @ x554
EOF

  echo "Account $account has $usage MB of disk space. User notified."

done < $violators

}

function diskspace {
tempfile="/tmp/available.$$"

trap "rm -f $tempfile"

cat << 'EOF' > $tempfile
    { sum += $4 }
END { mb = sum / 1024
      gb = mb / 1024
      printf "%.0f MB (%.2fGB) of available disk space\n", mb, gb
    }
EOF

df -k | awk -f $tempfile
}

function verifycron {
validNum()
{
  # return 0 if valid, 1 if not. Specify number and maxvalue as args
  num=$1   max=$2

  if [ "$num" = "X" ] ; then
    return 0
  elif [ ! -z $(echo $num | sed 's/[[:digit:]]//g') ] ; then
    return 1
  elif [ $num -lt 0 -o $num -gt $max ] ; then
    return 1
  else
    return 0
  fi
}

validDay()
{
  # return 0 if a valid dayname, 1 otherwise

  case $(echo $1 | tr '[:upper:]' '[:lower:]') in
    sun*|mon*|tue*|wed*|thu*|fri*|sat*) return 0 ;;
    X) return 0	;; # special case - it's an "*"
    *) return 1
  esac
}

validMon()
{
  # return 0 if a valid month name, 1 otherwise

   case $(echo $1 | tr '[:upper:]' '[:lower:]') in 
     jan*|feb*|mar*|apr*|may|jun*|jul*|aug*) return 0		;;
     sep*|oct*|nov*|dec*)		     return 0		;;
     X) return 0 ;; # special case, it's an "*"
     *) return 1	;;
   esac
}

fixvars()
{
  # translate all '*' into 'X' to bypass shell expansion hassles
  # save original as "sourceline" for error messages

  sourceline="$min $hour $dom $mon $dow $command"
   min=$(echo "$min" | tr '*' 'X')
  hour=$(echo "$hour" | tr '*' 'X')
   dom=$(echo "$dom" | tr '*' 'X')
   mon=$(echo "$mon" | tr '*' 'X')
   dow=$(echo "$dow" | tr '*' 'X')
}

if [ $# -ne 1 ] || [ ! -r $1 ] ; then
  echo "Usage: $0 usercrontabfile" >&2
  fi

lines=0  entries=0  totalerrors=0

while read min hour dom mon dow command
do
  lines="$(( $lines + 1 ))" 
  errors=0
  
  if [ -z "$min" -o "${min%${min#?}}" = "#" ] ; then
    continue	# nothing to check
  elif [ ! -z $(echo ${min%${min#?}} | sed 's/[[:digit:]]//') ] ;  then
    continue	# first char not digit: skip!
  fi

  entries="$(($entries + 1))"

  fixvars

  #### Broken into fields, all '*' replaced with 'X' 
  # minute check

  for minslice in $(echo "$min" | sed 's/[,-]/ /g') ; do
    if ! validNum $minslice 60 ; then
      echo "Line ${lines}: Invalid minute value \"$minslice\""
      errors=1
    fi
  done

  # hour check
  
  for hrslice in $(echo "$hour" | sed 's/[,-]/ /g') ; do
    if ! validNum $hrslice 24 ; then
      echo "Line ${lines}: Invalid hour value \"$hrslice\"" 
      errors=1
    fi
  done

  # day of month check

  for domslice in $(echo $dom | sed 's/[,-]/ /g') ; do
    if ! validNum $domslice 31 ; then
      echo "Line ${lines}: Invalid day of month value \"$domslice\""
      errors=1
    fi
  done

  # month check

  for monslice in $(echo "$mon" | sed 's/[,-]/ /g') ; do
    if ! validNum $monslice 12 ; then
      if ! validMon "$monslice" ; then
        echo "Line ${lines}: Invalid month value \"$monslice\""
        errors=1
      fi
    fi
  done

  # day of week check

  for dowslice in $(echo "$dow" | sed 's/[,-]/ /g') ; do
    if ! validNum $dowslice 7 ; then
      if ! validDay $dowslice ; then
        echo "Line ${lines}: Invalid day of week value \"$dowslice\""
        errors=1
      fi
    fi
  done

  if [ $errors -gt 0 ] ; then
    echo ">>>> ${lines}: $sourceline"
    echo ""
    totalerrors="$(( $totalerrors + 1 ))"
  fi
done < $1

echo "Done. Found $totalerrors errors in $entries crontab entries."
}

function fbackup {
usageQuit()
{
  cat << "EOF" >&2
Usage: $0 [-o output] [-i|-f] [-n]
  -o lets you specify an alternative backup file/device
  -i is an incremental or -f is a full backup, and -n prevents
  updating the timestamp if an incremental backup is done.
EOF
}

compress="bzip2"	# change for your favorite compression app
inclist="/tmp/backup.inclist.$(date +%d%m%y)"
 output="/tmp/backup.$(date +%d%m%y).bz2"
 tsfile="$HOME/.backup.timestamp"
  btype="incremental"	# default to an incremental backup
  noinc=0			#   and an update of the timestamp

trap "/bin/rm -f $inclist" 

while getopts "o:ifn" opt; do
  case "$arg" in
    o ) output="$OPTARG";  	;;
    i ) btype="incremental";	;;
    f ) btype="full";		;;
    n ) noinc=1;		;;
    ? ) usageQuit		;;
  esac
done

shift $(( $OPTIND - 1 ))

echo "Doing $btype backup, saving output to $output"

timestamp="$(date +'%m%d%I%M')"

if [ "$btype" = "incremental" ] ; then 
  if [ ! -f $tsfile ] ; then
    echo "Error: can't do an incremental backup: no timestamp file" >&2
    fi
  find $HOME -depth -type f -newer $tsfile -user ${USER:-LOGNAME} | \
    pax -w -x tar | $compress > $output
  failure="$?"
else
  find $HOME -depth -type f -user ${USER:-LOGNAME} | \
    pax -w -x tar | $compress > $output
  failure="$?"
fi

if [ "$noinc" = "0" -a "$failure" = "0" ] ; then
  touch -t $timestamp $tsfile
fi
}

function ftpsyncup {
timestamp=".timestamp"
tempfile="/tmp/ftpsyncup.$$"
count=0

trap "/bin/rm -f $tempfile" 0 1 15      # zap tempfile on exit &sigs

if [ $# -eq 0 ] ; then
  echo "Usage: $0 user@host { remotedir }" >&2
fi

user="$(echo $1 | cut -d@ -f1)"
server="$(echo $1 | cut -d@ -f2)"

echo "open $server" > $tempfile
echo "user $user" >> $tempfile

if [ $# -gt 1 ] ; then
  echo "cd $2" >> $tempfile
fi

if [ ! -f $timestamp ] ; then
  # no timestamp file, upload all files
  for filename in *
  do 
    if [ -f "$filename" ] ; then
      echo "put \"$filename\"" >> $tempfile
      count=$(( $count + 1 ))
    fi
  done
else
  for filename in $(find . -newer $timestamp -type f -print)
  do 
    echo "put \"$filename\"" >> $tempfile
    count=$(( $count + 1 ))
  done
fi

if [ $count -eq 0 ] ; then
  echo "$0: No files require uploading to $server" >&2
fi

echo "quit" >> $tempfile

echo "Synchronizing: Found $count files in local folder to upload."

if ! ftp -n < $tempfile ; then
  echo "Done. All files synchronized up with $server"
  touch $timestamp
fi
}
function ftpsyncdown {
tempfile="/tmp/ftpsyncdown.$$"

trap "/bin/rm -f $tempfile" 0 1 15      # zap tempfile on exit

if [ $# -eq 0 ] ; then
  echo "Usage: $0 user@host { remotedir }" >&2
fi

user="$(echo $1 | cut -d@ -f1)"
server="$(echo $1 | cut -d@ -f2)"

echo "open $server" > $tempfile
echo "user $user" >> $tempfile

if [ $# -gt 1 ] ; then
  echo "cd $2" >> $tempfile
fi

cat << EOF >> $tempfile
prompt
mget *
quit
EOF

echo "Synchronizing: Downloading files"

if ! ftp -n < $tempfile ; then
  echo "Done. All files on $server downloaded to $(pwd)"
fi
}

