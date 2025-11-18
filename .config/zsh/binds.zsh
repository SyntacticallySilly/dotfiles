bindkey -v
# Autocomplete
bindkey '\' menu-select
bindkey '`' forward-word
# bindkey -M menuselect '\r' .accept-line

# zsh-autosuggestions
# bindkey '^[n' history-search-forward
# bindkey '^[p' vi-history-search-backward
#
bindkey ',' autosuggest-accept

# bindkey -M viins \
#   "^P"    .up-history \
#   "^N"    .down-history \
#   "k"     .up-line-or-history \
# #   "^[OA"  .up-line-or-history \
# #   "^[[A"  .up-line-or-history \
# #   "j"     .down-line-or-history \
# #   "^[OB"  .down-line-or-history \
# #   "^[[B"  .down-line-or-history \
# #   "/"     .vi-history-search-backward \
# #   "?"     .vi-history-search-forward \
#
# bindkey '/' history-search-backward
bindkey '?' history-search-backward
