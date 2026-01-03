# ╔══════════════════════════════════════════════════════════════╗
# ║  Aliases                                                      ║
# ║  Command shortcuts and common operations                     ║
# ╚══════════════════════════════════════════════════════════════╝

# ───────────────────────────────────────────────────────────────
#  File Management
# ───────────────────────────────────────────────────────────────
# nnn: File manager with extended options, hidden files, detail view
alias n='nnn -EHd'

# Yazi : File manager.
alias y='yazi'
# eza: Modern ls replacement with icons
alias ls='eza -aa --no-quotes --icons=always --git-repos-no-status'
alias lsf='eza -a -f --icons=always --no-quotes'          # Files only
alias lsd='eza -a -DRTl --level 2 --icons=always --no-quotes'  # Dirs (tree, level 2)
alias lsa='eza -a --icons=always --tree --level=3 --no-quotes'  # All (tree, level 3)

# ───────────────────────────────────────────────────────────────
#  Navigation
# ───────────────────────────────────────────────────────────────
# fcd: Fuzzy find and change directory
alias fcd='z $(fd . --type d -H | fzf --no-preview --height 70%)'

# fzf : Normal fzf with bat preview.
alias fzf='fzf --style full --color='fg:#dbdbff,fg+:#dbdbff,bg+:#000000,hl:#0000ff,gutter:#000000,pointer:#0000ff,marker:#0000ff,header:#719872,spinner:#6d6dff,info:#dbdbff,prompt:#dbdbff,query:#dbdbff,border:#dbdbff' --smart-case --preview 'bat --color=always --style=numbers --line-range :500 {}' --layout=reverse --border'

# Quick jump to home directory
alias home='z ~'

# Access Termux shared storage
alias exs='z ~/storage/shared/'

# ───────────────────────────────────────────────────────────────
#  Zoxide Integration
# ───────────────────────────────────────────────────────────────
alias zadd="zoxide add"
alias zedit="zoxide edit"

# ───────────────────────────────────────────────────────────────
#  Editor
# ───────────────────────────────────────────────────────────────
# Quick Neovim launch
alias nv='nvim'

# ───────────────────────────────────────────────────────────────
#  System Operations
# ───────────────────────────────────────────────────────────────
# Reload Zsh configuration and return to home
alias refr='source ~/.zshrc && termux-reload-settings && cd ~'

# Termux-specific utilities
alias debian="proot-distro login debian --user root --shared-tmp && termux-x11 :0 &"
alias open='termux-open'             # Open any file in a external android app.
# alias pkg='nala'                     #}
# alias apt='nala'                     #}-- Replace legacy apt and pkg for a better frontend.
alias acp="termux-clipboard-set <"   # Copy file to clipboard
alias aps="termux-clipboard-get >"   # Paste clipboard to file
alias sysup="nala update -y && nala upgrade -y && zinit update && zsh ~/dotfiles/update.sh && source ~/.zshrc && termux-reload-settings"
# ───────────────────────────────────────────────────────────────
#  SSH Server Management
# ───────────────────────────────────────────────────────────────
alias terstr="sshd"          # Start SSH server
alias killter="pkill sshd"   # Stop SSH server

# ───────────────────────────────────────────────────────────────
#  Convenience
# ───────────────────────────────────────────────────────────────
alias lg="lazygit"
alias configzsh="z ~/dotfiles/.config/zsh && nvim"
alias confignvim="z ~/dotfiles/.config/nvim && nvim"
alias cd="z"
alias grep="rg"
alias cat='bat --style=plain'
alias less='bat --paging=always'
# alias ps='procs'
alias du="dust"
alias df="duf"

# ───────────────────────────────────────────────────────────────
#  Custom Scripts
# ───────────────────────────────────────────────────────────────
# File organizer script
alias orgctl='zsh ~/dotfiles/scripts/file-organizer.sh'
alias orgdown='zsh ~/dotfiles/scripts/file-organizer.sh organize'
alias orgstats='zsh ~/dotfiles/scripts/file-organizer.sh stats'

# Theme cycler.
alias themectl='zsh ~/dotfiles/scripts/theme-cycler.sh'

# Shizuku remote shell
alias rish='zsh ~/scripts/rish'

alias help='glow ~/dotfiles/syndot.md'

alias -g -- -h='-h 2>&1 | bat --language=help --style=plain'
alias -g -- --help='--help 2>&1 | bat --language=help --style=plain'

alias -s json=jless
alias -s md=bat
alias -s go='$EDITOR'
alias -s rs='$EDITOR'
alias -s txt=bat
alias -s log=bat
alias -s py='$EDITOR'
alias -s js='$EDITOR'
alias -s ts='$EDITOR'
alias -s html=termux-open

# Pipe to jq
# alias -g J='| jq'
#
# Copy output to clipboard (macOS)
alias -g C='| termux-clipboard-set'
