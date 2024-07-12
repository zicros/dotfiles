# Documentation on prompt:
#   https://zsh.sourceforge.io/Doc/Release/Prompt-Expansion.html
# Prompt:
#   PWD
#   time>
PROMPT=$'%F{green}%d%f% \n%*➜ '

# Based on https://github.com/ohmyzsh/ohmyzsh/blob/master/themes/robbyrussell.zsh-theme
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"

