# ╔══════════════════════════════════════════════════════════════╗
# ║  Aliases                                                      ║
# ║  Command shortcuts and common operations                     ║
# ╚══════════════════════════════════════════════════════════════╝

# ───────────────────────────────────────────────────────────────
#  File Management
# ───────────────────────────────────────────────────────────────
# Yazi : File manager.
alias y='yazi'
# eza: Modern ls replacement with icons
alias l='eza -aa --no-quotes --group-directories-first --icons=always --git-ignore --git'
alias ls='eza -aa --no-quotes --group-directories-first --icons=auto  --follow-symlinks'
alias sf='eza -a -f --icons=always --no-quotes --git-ignore --git --no-user'
alias lsd='eza -a -DRTl --level 2 --icons=always --no-quotes --git-ignore --git --no-user'
alias lsa='eza -a --icons=always --tree --level=3 --no-quotes --git-ignore --git --no-user'
alias lsg="eza --git-repos"

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
alias refr='source ~/.zshrc && termux-reload-settings'

alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -p'
alias ps='ps auxf'
alias ping='ping -c 10'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias countfiles="for t in files links directories; do echo \`find . -type \${t:0:1} | wc -l\` \$t; done 2> /dev/null"
alias mktar='tar -cvf'
alias mkbz2='tar -cvjf'
alias mkgz='tar -cvzf'
alias untar='tar -xvf'
alias unbz2='tar -xvjf'
alias ungz='tar -xvzf'

# Termux-specific utilities
alias debian="proot-distro login debian --user root --shared-tmp && termux-x11 :0 &"
alias open='termux-open'             # Open any file in a external android app.
alias acp="termux-clipboard-set <"   # Copy file to clipboard
alias aps="termux-clipboard-get >"   # Paste clipboard to file
alias sysup="apt update -y && apt upgrade -y && zinit update && zsh ~/dotfiles/update.sh"
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
alias ps='procs'
alias du="dust"
alias df="duf"

# ───────────────────────────────────────────────────────────────
#  Custom Scripts
# ───────────────────────────────────────────────────────────────
# File organizer script
alias janitor='zsh ~/dotfiles/scripts/janitor.sh'
# alias janitor work='zsh ~/dotfiles/scripts/janitor.sh organize'
# alias janitor stats='zsh ~/dotfiles/scripts/janitor.sh stats'

# Theme cycler.
alias themectl='zsh ~/dotfiles/scripts/theme-cycler.sh'

# for rish
alias rish="sh ~/bin/rish"

alias help='glow ~/dotfiles/syndot.md'

alias -g -- -h='-h 2>&1 | bat --language=help --style=plain'
# alias -g -- --help='--help 2>&1 | bat --language=help --style=plain'

alias -s json=jless
alias -s md='$EDITOR'
alias -s go='$EDITOR'
alias -s rs='$EDITOR'
alias -s txt=bat
alias -s log=bat
alias -s py='$EDITOR'
alias -s js='$EDITOR'
alias -s ts='$EDITOR'
alias -s html=termux-open

alias gbat="bat --style=numbers,changes --wrap=never"

# Pipe to jq
# alias -g J='| jq'
alias -g C='| termux-clipboard-set'

alias arch='proot-distro login archlinux --user Syn'
alias i='sudo pacman -S'


# NOTE: DO NOT USE THIS AS YOUR NEOVIM ALIAS. I USE IT FOR A PERSONAL PROJECT.
# if you're looking for an alias just use 'nv' instead or set your own.
alias neo='XDG_CONFIG_HOME=~/dev/ignite/neovim nvim'
