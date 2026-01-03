bindkey -v
# Autocomplete
bindkey '\' menu-select
bindkey '`' forward-word
# bindkey -M menuselect '\r' .accept-line
# bindkey '^?' history-search-backward
bindkey '?' history-incremental-search-backward

# zsh-autosuggestions
bindkey ',' autosuggest-accept

# random
bindkey '^[OA' forward-word

# do what i mean.
bindkey '%' edit-command-line
bindkey '^q' exit
bindkey -M vicmd 'v' edit-command-line

# Undo/
bindkey -M vicmd 'u' undo
bindkey -M vicmd 'U' redo

bindkey ' ' magic-space

bindkey -M vicmd 'yy' copy-buffer-to-clipboard
