# ╔══════════════════════════════════════════════════════════════╗
# ║  Zinit Bootstrap                                              ║
# ║  Plugin manager installation and initialization             ║
# ╚══════════════════════════════════════════════════════════════╝

# ───────────────────────────────────────────────────────────────
#  Auto-install Zinit if not present
# ───────────────────────────────────────────────────────────────
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

# ───────────────────────────────────────────────────────────────
#  Initialize Zinit
# ───────────────────────────────────────────────────────────────
source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"

# Load Zinit completion system
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
