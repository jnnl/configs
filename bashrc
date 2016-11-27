# bashrc
# General bash configs

# Get current git branch for PS1
get_git_branch() {
    git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export PS1="\u@\h:\W\$(get_git_branch) $ "
alias ll="ls -lahF"

# Linux-specific settings
if [[ $(uname) == "Linux" ]]; then
    alias gdb="gdb -q"

    export TERM="xterm-256color"
    export PATH="$PATH:"$HOME"/code/bin"
    export SUDO_EDITOR=vim

    if [[ $(hostname) == "arch" ]]; then
        export PS1="\u:\W\$(get_git_branch) $ "
    fi
fi

# MacOS-specific settings
if [[ $(uname) == "Darwin" ]]; then
    alias bup="brew update && brew upgrade && brew cleanup && brew doctor"
    alias gdb="sudo gdb -q"

    export TERM="xterm-256color"
    export PATH="$PATH:/usr/local/sbin:"$HOME"/code/bin"
    export HOMEBREW_NO_ANALYTICS=1

    if [[ $(hostname) == "jmac" || $(hostname) == "jmac.local" ]]; then
        export PS1="\u:\W\$(get_git_branch) $ "
    fi
fi
