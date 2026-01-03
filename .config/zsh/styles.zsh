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
