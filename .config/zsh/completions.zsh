# ╔══════════════════════════════════════════════════════════════╗
# ║  Completion Styles                                            ║
# ║  Tab completion behavior and appearance                      ║
# ╚══════════════════════════════════════════════════════════════╝

# ───────────────────────────────────────────────────────────────
#  General Completion Styles
# ───────────────────────────────────────────────────────────────
# Case-insensitive matching (types 'doc' matches 'Documents')
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

zstyle ':completion:*' completer _extensions _complete _approximate
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$HOME/.cache/zsh/zcompcache"
zstyle ':completion:*' file-sort modification

# Enable menu-select widget for Tab
# zstyle ':autocomplete:tab:*' widget-style menu-select

# Colorize completion list using LS_COLORS
# zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"'ma=38;5;220'
zstyle ':completion:*:*:*:*:*' list-colors "${(s.:.)LS_COLORS}" 'ma=04;36;5;51'

zstyle ':completion:*:*:*:*:corrections' format '%F{yellow}!- %d (errors: %e) -!%f'
zstyle ':completion:*:descriptions' format '%F{yellow}%B-- %d --%b%f'
zstyle ':completion:*:messages' format '%B%F{cyan}%d%f%b'
zstyle ':completion:*:warnings' format '%F{red}No matches found%f'

zstyle ':completion:*:*:-command-:*:*' group-order alias builtins functions commands

# Disable default menu for fzf-tab integration
zstyle ':completion:*' menu select search

# removes semicolon when entering smth from the history
zstyle ':autocomplete:*' add-semicolon no

# delays autocompletion for better perfomance
zstyle ':autocomplete:*' delay 1

zstyle ':autocomplete:*' min-input 3

zstyle ':completion:*:default' select-prompt '%F{black}%K{12}line %l %p%f%k'
# ───────────────────────────────────────────────────────────────
#  FZF-Tab Specific Styles
# ───────────────────────────────────────────────────────────────
# Preview for cd command - show directory contents
# zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls -1 --color=always $realpath'

# Preview for zoxide jumps
# zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'eza -RAl --color=always --icons=always $realpath'

# Custom appearance for fzf-tab menu
# zstyle ':fzf-tab:*' fzf-flags --height=50% --border --color=fg:240,bg:233,hl:65,fg+:15,bg+:237,hl+:108


# Autocomplete plugin

# Note: -e lets you specify a dynamically generated value.
#
# # Override default for all listings
# # $LINES is the number of lines that fit on screen.
zstyle -e ':autocomplete:*:*' list-lines 'reply=( $(( LINES / 1  )) )'
#
# # Override for recent path search only
# zstyle ':autocomplete:recent-paths:*' list-lines 10
#
# # Override for history search only
zstyle ':autocomplete:history-incremental-search-backward:*' list-lines 12
# #
# # # Override for history menu only
zstyle ':autocomplete:history-search-backward:*' list-lines 500

zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p%s'
zstyle ':completion:*' list-prompt '%SAt %p: Hit TAB for more, or the character to insert%s'
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'


# Show recent dirs unless the current word is empty or equal to an existing directory.
# zstyle -e ':completion:*:directories' fake '
#     [[ -z $PREFIX$SUFFIX || -d $PREFIX$SUFFIX ]] ||
#         +autocomplete:recent-directories
# '
zstyle ':completion:*:directories' sort no

# Autosuggestions customization
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#63689B,underline"
ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd completion) 

# ───────────────────────────────────────────────────────────────
#  Custom Completions
# ───────────────────────────────────────────────────────────────
# Starship
source ~/dotfiles/.config/zsh/comp/starship.zsh
# source ~/dotfiles/.config/zsh/comp/nala.zsh
source ~/dotfiles/.config/zsh/comp/typioca.zsh
source ~/dotfiles/.config/zsh/comp/typer.zsh
source ~/dotfiles/.config/zsh/comp/treesitter.zsh
source ~/dotfiles/.config/zsh/comp/atuin.zsh
