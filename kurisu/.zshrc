# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory autocd extendedglob nomatch notify
unsetopt beep
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/dev/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

#Shell prompt
export PS1="$fg[blue]%n@%m $reset_color%~ "

#dir colors
autoload -U colors && colors
eval `dircolors /home/dev/.dircolors-solarized-dark`
alias ls="ls --color=auto --group-directories-first"
alias grep="grep --color=auto"
alias screenfetch="screenfetch -D 'Arch'"
alias :q='exit'
