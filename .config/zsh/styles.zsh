# ZLE (Line Editor) Widget Styles
zstyle ':zle:*' word-chars '*?_-.[]~=/&;!#$%^(){}<>'
zstyle ':zle:*' word-style unspecified

# Bracketed Paste
zstyle ':bracketed-paste-magic' active-widgets '.self-*'
zstyle ':bracketed-paste-magic' paste-init pasteinit

# URL Quote Magic
zstyle ':urlglobber' url-other-schema ftp git gopher http https magnet
zstyle ':url-quote-magic:*' url-metas '*?[]^()|{}<>'
zstyle ':url-quote-magic:*' url-globbers

# Auto-CD Settings
zstyle ':chpwd:*' recent-dirs-max 20
zstyle ':chpwd:*' recent-dirs-default true

# Zftp Module
zstyle ':zftp:*' progress none
zstyle ':zftp:*' update 5K

# zmv (Batch Rename) Settings
zstyle ':copy-earlier-word:*' match '[[:alnum:]]'

# Suppress default menu
zstyle ':completion:*' menu no

# Use LS_COLORS for coloring
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:descriptions' format '[%d]'

# Example: preview for cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --icons --color=always $realpath'
zstyle ':fzf-tab:complete:ls:*' fzf-preview 'eza -1 --icons --color=always $realpath'   # if you type ls <tab>
zstyle ':fzf-tab:complete:*:*' fzf-preview 'eza -1 --icons --color=always $realpath'    # broad fallback
zstyle ':fzf-tab:complete:kill:*' fzf-preview 'ps --pid=$word -o comm='
zstyle ':fzf-tab:*' fzf-flags --color='fg:#dbdbff,fg+:#dbdbff,bg+:#000000,hl:#0000ff,gutter:#000000,pointer:#0000ff,marker:#0000ff,header:#719872,spinner:#6d6dff,info:#dbdbff,prompt:#dbdbff,query:#dbdbff,border:#dbdbff'
