
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

unshift_path "/opt/local/bin"
unshift_path "/opt/local/sbin"
unshift_path "/usr/local/git/bin"
unshift_path "/usr/local/mongodb/bin"
unshift_path "/usr/local/mysql/bin"
unshift_path "/usr/local/scala-2.8.1/bin"
unshift_path "/usr/local/nginx/sbin"

if [ -f /opt/local/etc/bash_completion ]; then
    . /opt/local/etc/bash_completion
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

# golang
export GOROOT=$HOME/Code/go
unshift_path "$GOROOT/bin"

# build mac os programs
if [ $IS_MAC_OS_X ]; then
    export ARCHFLAGS='-arch i386 -arch x86_64'
fi

# git prompt
if [ -f /usr/local/git/contrib/completion/git-completion.bash ]; then
    source /usr/local/git/contrib/completion/git-completion.bash
    #PS1='[\u@\h:\w\[\033[0;32m\]$(__git_ps1 "(%s)")\033[0m]\$ '
    PS1='[\u:\w\[\033[0;32m\]$(__git_ps1 "(%s)")\033[0m]\$ '  
fi
if [ -f ~/bin/git-flow-completion.bash ]; then
    source ~/bin/git-flow-completion.bash
fi

# hg
if [ -f ~/bin/hg-completion.bash ]; then
    source ~/bin/hg-completion.bash
fi

# svn
if [ -f ~/bin/svn-completion.bash ]; then
    source ~/bin/svn-completion.bash
fi

#rebar
if [ -f ~/bin/rebar-completion.bash ]; then
    source ~/bin/rebar-completion.bash
fi

# alias
alias ll     = 'ls -lwG'   # w中文,G颜色
alias py26   = 'workon py26'
alias safari = 'open -a "Safari"'
alias chrome = 'open -a "Google Chrome"'
alias finder = 'open -a "Finder"'
alias tree   = "find . -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'"
alias vim    = '/Applications/MacVim.app/Contents/MacOS/Vim'
alias vi     = '/Applications/MacVim.app/Contents/MacOS/Vim'
alias gvim   = '/Applications/MacVim.app/Contents/MacOS/MacVim'

export EDITOR='vim'

