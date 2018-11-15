# .bashrc

# exit if not bash
test -n "$BASH" || exit

# get git branch
_git_br() {
    (
    until test "$PWD" = /; do
        if test -d .git; then
            git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
            return
        else
            cd .. 2>/dev/null || return 1
        fi
    done
    )
}

# check if command exists
has() {
    type -p $* &>/dev/null
}

# cd to dirname
cdd() {
    cd "$(dirname $1)"
}

# show hostname in prompt if in ssh session
if test -n "$SSH_CONNECTION"; then
    PS1="\u@\h:\W\$(_git_br) $ "
else
    PS1="\u:\W\$(_git_br) $ "
fi

# aliases
alias l="ls -lhF"
alias ll="ls -lhAF"

# shell options
shopt -s histappend

# command history options
HISTSIZE=5000
HISTFILESIZE=5000
HISTCONTROL=ignoreboth:erasedups
HISTIGNORE=bg:cd:exit:f:fg:j:l:ll:ls:v

# add custom bin directory to PATH
export PATH="~/code/bin:$PATH"

# set nvim/vim as EDITOR
if has nvim; then
    export VISUAL=nvim EDITOR=nvim
elif has vim; then
    export VISUAL=vim EDITOR=vim
fi

# source bash completion
if test -f /etc/bash_completion; then
    source /etc/bash_completion
elif test -f /usr/local/share/bash-completion/bash_completion; then
    source /usr/local/share/bash-completion/bash_completion
elif test -f /usr/share/bash-completion/bash_completion; then
    source /usr/share/bash-completion/bash_completion
elif test -f /usr/local/etc/bash_completion; then
    source /usr/local/etc/bash_completion
fi

# fzf config
test -f ~/.fzf.bash && source ~/.fzf.bash
export FZF_DEFAULT_OPTS="--reverse --border"
has ag && export FZF_DEFAULT_COMMAND="ag --hidden --ignore .git -f -g ''"
has rg && export FZF_DEFAULT_COMMAND="rg --files --hidden"

# fasd config
if has fasd; then
    eval "$(fasd --init auto)"
    alias j="fasd_cd -d"
    alias v="fasd -e vim"
fi

# source local bashrc
test -f ~/.bashrc.local && source ~/.bashrc.local
