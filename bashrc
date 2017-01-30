# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias vi='vim'
alias c='clear'
alias r='reset'
alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../..'
alias mkdir='mkdir -pv'
alias diff='colordiff'
alias mv='mv -i'
alias cp='cp -i'
alias ln='ln -i'
alias update='sudo apt-get update'
alias upgrade='sudo apt-get upgrade'
alias ls='ls --color=auto --group-directories-first'
alias lh='ls -lh'
alias ll='ls -l'
alias lsr='ls -R'
alias less='less -r'
alias du='du -h'
alias df='df -h'
alias rb='make clean && make release'
alias rbd='make clean && make debug'
alias ipc='grep CommittedInstructionsPerCycle'
alias sq='squeue'
alias sendemail='sendemail -f rbera@iitk.ac.in -s mmtp.iitk.ac.in:25 -o tls=yes -xu rbera -xp winFast' 
alias bfg='java -jar /home/rbera/work/softwares/bfg-1.12.14.jar'

ds2home="/home/rbera/work/DRAMSim2"
pinhome="/home/rbera/work/pin"
traces="/home/rbera/work/traces/spec06"

# Machines
turing="rbera@turing.cse.iitk.ac.in"
cse="rbera@csecourses2.cse.iitk.ac.in"
pprserver="rbera@pprserver.cse.iitk.ac.in"
anirban="manirban@172.27.20.155"
gpu1="rbera@gpu01.cc.iitk.ac.in"

recursive="rbera@172.27.20.172"
minion1="rbera@172.27.22.111"
minion2="rbera@172.27.22.52"
minion3="rbera@172.27.22.179"
minion4="rbera@172.27.30.15"
minion5="rbera@172.27.22.189"

M2S_HOME=/home/rbera/work/multi2sim-modified
LARK_HOME=/home/rbera/work/scripts
PATH=$PATH:$ds2home:$pinhome:/home/rbera/work/scripts/bin:/home/rbera/work/sim:/home/rbera/work/offline-cache/src
LD_LIBRARY_PATH=/home/rbera/work/zlib:$LD_LIBRARY_PATH
PKG_CONFIG_PATH=${HOME}/local/lib/pkgconfig:${PKG_CONFIG_PATH}

install()
{ 	
	sudo apt-get install $@
}

remove()
{
	sudo apt-get autoremove $@
}

parse_git_branch() 
{
	git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[01;31m\]$(parse_git_branch)\[\033[00m\]\$ '

if [ -n "$DISPLAY" -a "$TERM" == "xterm" ]; then
	export TERM=xterm-256color
fi
