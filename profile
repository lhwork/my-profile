
OSNAME="$(uname -s)"

case $OSNAME in
    "Darwin")
        export IS_MAC_OS_X=1
        export OS_GREETING="Mac OS X"
    ;;
    "Linux")
        export IS_LINUX=1
        export OS_GREETING="Linux"
    ;;
esac

# functions
unshift_path() {
    new_path="$1"
    echo $PATH | grep -q -s "$new_path"
    if [ $? -eq 1 ]; then
        PATH="$new_path":"$PATH"
    fi
    export PATH
}

unshift_path "/usr/local/bin"
unshift_path "/usr/local/sbin"
unshift_path "/usr/local/mongodb/bin"
unshift_path "/usr/local/mysql/bin"
unshift_path "/usr/local/scala/bin"
unshift_path "/usr/local/nginx/sbin"

if [ -f /usr/local/etc/bash_completion ]; then
    . /usr/local/etc/bash_completion
fi

# virtualenv
export WORKON_HOME=$HOME/.virtualenvs
source /usr/local/bin/virtualenvwrapper.sh

ve() {
    if [[ $1 == */* ]]; then
        source $1/bin/activate
   	else
   	    source $WORKON_HOME/$1/bin/activate
    fi
}

_ve() {
    COMPREPLY=()
    if [[ $COMP_CWORD == 1 ]] ; then
        COMPREPLY=( $(compgen -d $WORKON_HOME/${COMP_WORDS[COMP_CWORD]} | sed "s/\/.*\///") )
        return 0
    fi
}
complete -F _ve ve

# build mac os programs
if [ $IS_MAC_OS_X ]; then
    export ARCHFLAGS='-arch i386 -arch x86_64'
fi

# git prompt
if [ -f /usr/local/etc/bash_completion.d/git-prompt.sh ]; then
    source /usr/local/etc/bash_completion.d/git-prompt.sh
    #PS1='[\u@\h:\w\[\033[0;32m\]$(__git_ps1 "(%s)")\033[0m]\$ '
    PS1='[\u:\w\[\033[0;32m\]$(__git_ps1 "(%s)")\033[0m]\$ '  
fi
if [ -f /usr/local/etc/bash_completion.d/git-flow-completion.bash ]; then
    source /usr/local/etc/bash_completion.d/git-flow-completion.bash
fi

# hg
if [ -f /usr/local/etc/bash_completion.d/hg-completion.bash ]; then
    source /usr/local/etc/bash_completion.d/hg-completion.bash
fi

# svn
if [ -f /usr/local/etc/bash_completion.d/svn-completion.bash ]; then
    source /usr/local/etc/bash_completion.d/svn-completion.bash
fi

# golang
if [ -f /usr/local/etc/bash_completion.d/go-completion.bash ]; then
    source /usr/local/etc/bash_completion.d/go-completion.bash
fi

#rebar
if [ -f ~/bin/rebar-completion.bash ]; then
    source ~/bin/rebar-completion.bash
fi

#erlang
set ERL_MAX_PORTS=20480
export ERL_MAX_PORTS
#ulimit -n 20480

# alias
alias ll='ls -lwG'   # w中文,G颜色
alias py26='workon py26'
alias safari='open -a "Safari"'
alias chrome='open -a "Google Chrome"'
alias finder='open -a "Finder"'
alias tree="find . -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'"
alias vim='/Applications/MacVim.app/Contents/MacOS/Vim'
alias vi='/Applications/MacVim.app/Contents/MacOS/Vim'
alias gvim='/Applications/MacVim.app/Contents/MacOS/MacVim'
alias pg='ps -ef|grep'
alias mkve='mkvirtualenv --no-site-packages'

export EDITOR='vim'

source ~/bin/my_local.bash

