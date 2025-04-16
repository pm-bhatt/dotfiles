#startship
eval "$(starship init zsh)"
#Disable Underline
(( ${+ZSH_HIGHLIGHT_STYLES} )) || typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[path]='none'
ZSH_HIGHLIGHT_STYLES[path_prefix]='none'

#Activate autosuggest
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh