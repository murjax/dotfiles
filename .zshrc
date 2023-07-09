fpath=(
  $fpath
  ~/.rvm/scripts/zsh/Completion
  ~/.zsh/functions
  /usr/local/share/zsh/site-functions
)

# color term
export CLICOLOR=1
export LSCOLORS=Dxfxcxdxbxegedabadacad
export ZLS_COLORS=$LSCOLORS
export LC_CTYPE=en_US.UTF-8
export LESS=FRX

# iex shell history
export ERL_AFLAGS="-kernel shell_history enabled"

# make with the pretty colors
autoload colors; colors

# just say no to zle vim mode:
bindkey -e

# options
setopt appendhistory extendedglob histignoredups nonomatch prompt_subst interactivecomments

# prompt
p=
if [ -n "$SSH_CONNECTION" ]; then
  p='%{$fg_bold[yellow]%}%n@%m'
else
  p='%{$fg_bold[green]%}%n@%m'
fi

# show non-success exit code in right prompt
RPROMPT="%(?..{%{$fg[red]%}%?%{$reset_color%}})"

# history
HISTFILE=~/.zsh_history
HISTSIZE=5000
SAVEHIST=10000
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY

# default apps
(( ${+PAGER}   )) || export PAGER='less'
(( ${+EDITOR}  )) || export EDITOR='nvim'
export PSQL_EDITOR='nvim -c"setf sql"'

l.() {
  ls -ld "${1:-$PWD}"/.[^.]*
}

# Rails
alias rc="rails c"
alias rs="rails s"
alias rails-sessions="lsof -wni tcp:3000"
alias kill-rails="kill -9 $(lsof -wni tcp:3000)"
alias resetdb="rake db:drop && rake db:create && rake db:migrate && rake db:seed"
alias groutes="rake routes | grep $@"

# Git
alias gap='git add -p'
alias gnap='git add -N --ignore-removal . && gap && gref'
alias glp='git log -p'
alias glg='git log --graph --oneline --decorate --color --all'
alias gb='git branch'
alias gc='git commit -v'
alias gca='git commit -a -v'
alias gcl='git clean -f -d'
alias gd='git diff'
alias gdc='git diff --cached'
alias gdh='git diff HEAD'
alias gl='git pull'
alias glod='git log --oneline --decorate'
alias gp='git push'
alias gpr='git pull --rebase'
alias gst='git status'
alias gr='git rebase'
alias grc='git rebase --continue'
alias gra='git rebase --abort'
alias gco='git checkout'
alias branch-sort="git branch --sort=-committerdate"
alias my-commit-log="git log --author='Ryan Murphy'"

# Paths
export ANDROID_HOME="$HOME/Android/Sdk"
export PATH="$HOME/.rbenv/bin:$PATH"
export PATH="$(python3 -m site --user-base)/bin:$PATH"
export PATH=~/flutter/bin:$PATH
export ERL_AFLAGS="-kernel shell_history enabled"
export PATH=~/usr/local/android-studio/bin:$PATH
export JAVA_HOME=/usr/lib/jvm/jdk-19
export PATH=$JAVA_HOME/bin:$PATH
export PATH=/usr/local/go/bin:$PATH
export PATH=~/elixir/bin:$PATH
eval "$(rbenv init -)"

# System
alias l="ls -F -G -lah"
alias ll="ls -l"
alias la="ls -a"
alias lsd='ls -ld *(-/DN)'
alias md='mkdir -p'
alias rd='rmdir'
alias cd..='cd ..'
alias ..='cd ..'
alias cpfile="xclip -sel c < $@" # Linux only

plugins=(… zsh-completions)

autoload -U compinit && compinit
source "$HOME/.zsh/spaceship/spaceship.zsh"
source /home/murjax-dev/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# set cd autocompletion to commonly visited directories
cdpath=(~ ~/src $DEV_DIR $SOURCE_DIR)

# remove duplicates in $PATH
typeset -aU path
