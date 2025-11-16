# ╔══════════════════════════════════════════════════════════════╗
# ║  Completion Styles                                            ║
# ║  Tab completion behavior and appearance                      ║
# ╚══════════════════════════════════════════════════════════════╝

# ───────────────────────────────────────────────────────────────
#  General Completion Styles
# ───────────────────────────────────────────────────────────────
# Case-insensitive matching (types 'doc' matches 'Documents')
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# Show description headers for completion groups
zstyle ':completion:*:descriptions' format '[%d]'

# Colorize completion list using LS_COLORS
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# Disable default menu for fzf-tab integration
zstyle ':completion:*' menu yes

zstyle ':completion:*:default' select-prompt '%F{black}%K{12}line %l %p%f%k'
# ───────────────────────────────────────────────────────────────
#  FZF-Tab Specific Styles
# ───────────────────────────────────────────────────────────────
# Preview for cd command - show directory contents
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls -1 --color=always $realpath'

# Preview for zoxide jumps
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'eza -RAl --color=always --icons=always $realpath'

# Custom appearance for fzf-tab menu
zstyle ':fzf-tab:*' fzf-flags --height=50% --border --color=fg:240,bg:233,hl:65,fg+:15,bg+:237,hl+:108

# ───────────────────────────────────────────────────────────────
#  Custom Completions
# ───────────────────────────────────────────────────────────────
# Use apt completions for nala package manager
compdef nala=apt
