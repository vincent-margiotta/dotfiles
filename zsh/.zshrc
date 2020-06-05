export ZSH=$HOME/.oh-my-zsh
export LANG=en_US.UTF-8
export ARCHFLAGS="-arch x86_64"
export PATH="/usr/local/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
export EDITOR='vim'

ZSH_THEME=personal
COMPLETION_WAITING_DOTS="true"
plugins=(jira catimg vi-mode)

#setopt AUTO_CD
setopt AUTO_PUSHD
setopt PUSHD_SILENT
setopt PUSHD_IGNORE_DUPS

# enable bash completion
autoload bashcompinit && bashcompinit

source $ZSH/oh-my-zsh.sh
source $HOME/.aliases
source $HOME/.functions

eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
if which nodenv > /dev/null; then eval "$(nodenv init -)"; fi

__load_key

export ASDF_DATA_DIR=`brew --prefix asdf`/
source $ASDF_DATA_DIR/asdf.sh

export PATH="/usr/local/sbin:$PATH"
