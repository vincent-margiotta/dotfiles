##
# This is my personal Z-shell theme.

function prompt_git_info() {
  if ! __git_prompt_git rev-parse --git-dir &> /dev/null; then
    return 0
  fi

  local ref
  ref=$(__git_prompt_git symbolic-ref --short HEAD 2> /dev/null) \
  || ref=$(__git_prompt_git rev-parse --short HEAD 2> /dev/null) \
  || return 0

  print -n "%{$fg[cyan]%}["
  print -n "%{$fg[yellow]%}${ref:gs/%/%%}%{$reset_color%}"
  print -n "%{$fg[cyan]%}]%{$reset_color%}"
  print -n "$(parse_git_dirty)"
}

PROMPT='%{$fg[cyan]%}[$([[ -n "$SSH_CLIENT$SSH_TTY$SSH_CONNECTION" ]] && print -n "%{$fg[red]%}R%{$fg[cyan]%}][")%2~]$(prompt_git_info)%{$reset_color%} '
RPROMPT=''

ZSH_THEME_GIT_PROMPT_PREFIX=""
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_DIRTY=""
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[cyan]%} ✈"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[yellow]%} ✭"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%} ✗"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[blue]%} ➦"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[magenta]%} ✂"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[grey]%} ✱"
