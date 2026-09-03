bindkey -v
# bindkey -M menuselect '\r' .accept-line
# bindkey '^?' history-search-backward
# bindkey '!' history-incremental-search-backward

# zsh-autosuggestions
bindkey ',' autosuggest-accept

bindkey '\' menu-search
bindkey '£' menu-select
bindkey '^I' menu-select

bindkey '%' edit-command-line
bindkey -M vicmd 'v' edit-command-line

# Undo/
bindkey -M viins '^u' undo
bindkey -M vicmd 'u' undo
bindkey -M vicmd 'U' redo

bindkey ' ' magic-space

bindkey -M vicmd 'yy' copy-buffer-to-clipboard

bindkey '^R' atuin-search
