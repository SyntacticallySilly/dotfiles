########## Environment & history ##########
export EDITOR=nvim
export VISUAL=nvim
export PATH="${HOME}/.local/bin:${PATH}"

HISTFILE=~/.zsh_history
HISTSIZE=200
SAVEHIST=200

setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_REDUCE_BLANKS
setopt HIST_EXPIRE_DUPS_FIRST

########## FZF ##########
# FZF with bat preview (requires bat, fd, fzf)
export FZF_DEFAULT_OPTS=" --style full --color='
                     fg:#dbdbff fg+:#dbdbff bg+:#000000
                     hl:#0000ff gutter:#000000
                     pointer:#0000ff marker:#0000ff
                     header:#719872
                     spinner:#6d6dff info:#dbdbff
                     prompt:#dbdbff query:#dbdbff
                     border:#dbdbff
                   '
--smart-case --preview 'bat --color=always --style=numbers --line-range :500 {}' --height 80% --layout=reverse --border"
export FZF_CTRL_T_OPTS="--preview 'bat --color=always --line-range :500 {}'"
export FZF_ALT_C_OPTS="--preview 'ls -la {}'"

########## Completion styles (zsh-autocomplete friendly) ##########
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# fzf-tab styling (harmless if plugin not loaded)
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls -1 --color=always $realpath'
zstyle ':fzf-tab:*' fzf-flags --height=50% --border --color=fg:240,bg:233,hl:65,fg+:15,bg+:237,hl+:108

########## Aliases ##########
alias n='nnn -EHd'
alias open='termux-open'
alias fcd='cd $(fd . --type d -H | fzf --no-preview --height 70%)'
alias home='cd ~'
alias ls='eza -a --no-quotes --icons=always'
alias lsf='eza -a -f --icons=always --no-quotes'
alias lsd='eza -a -DRT --level 2 --icons=always --no-quotes'
alias lsa='eza -a --icons=always --tree --level=3 --no-quotes'
alias exs='cd ~/storage/shared/'
alias refr='source ~/.zshrc && termux-reload-settings && cd ~'
alias nv='nvim'
alias acp="termux-clipboard-set <"
alias aps="termux-clipboard-get >"
alias zadd="zoxide add"
alias zedit="zoxide edit"
alias terstr="sshd"
alias killter="pkill sshd"
alias rish="sh ~/scripts/rish"
########## Zinit bootstrap ##########
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

########## Plugins (order optimized) ##########
# 1) Load zsh-autocomplete EARLY; it manages compinit itself
zinit light marlonrichert/zsh-autocomplete
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
zinit light hlissner/zsh-autopair
zinit light zdharma-continuum/fast-syntax-highlighting
zinit light sindresorhus/pretty-time-zsh
zinit light oknowton/zsh-dwim
zinit light duggum/zeza

# OMZ plugins are loaded with snippet and shouldnt be changed syntax wise.
zinit snippet OMZP::colored-man-pages
zinit snippet OMZP::command-not-found
zinit snippet OMZP::copypath
zinit snippet OMZP::catimg
zinit snippet OMZP::vi-mode
# Ensure vi-mode redraws the prompt on mode change (plugin-compatible)
export VI_MODE_RESET_PROMPT_ON_MODE_CHANGE=true  # redraw prompt on mode switch [plugin behavior]
# If the plugin tries to print its own right prompt marker, suppress it
RPROMPT=''

# Use vi keybindings at the line editor level
bindkey -v

# -------------------------------
# Vi-mode → Oh My Posh integration
# Exports POSH_VI_MODE and repaints the prompt immediately on keymap change
# -------------------------------

# Repaint helper that respects existing precmd/preprompt logic
_omp_redraw_prompt() {
  local f
  for f in "${precmd_functions[@]}"; do "$f"; done
  zle .reset-prompt
}

# Update POSH_VI_MODE on keymap changes and repaint
function _omp_zle-keymap-select() {
  if [[ "${KEYMAP}" == vicmd ]]; then
    export POSH_VI_MODE="NORMAL"
  else
    export POSH_VI_MODE="INSERT"
  fi
  _omp_redraw_prompt
}
zle -N _omp_zle-keymap-select
zle -N zle-keymap-select _omp_zle-keymap-select

# Reset mode after a command is accepted (ensures INS after execution/Ctrl-C)
function _omp_zle-line-finish() { export POSH_VI_MODE="INSERT"; }
zle -N _omp_zle-line-finish
zle -N zle-line-finish _omp_zle-line-finish

# Ensure POSH_VI_MODE has a sane default on startup
export POSH_VI_MODE="INSERT"

# Optional: cursor shape per mode (supported by the vi-mode plugin/term)
export VI_MODE_SET_CURSOR=true
export VI_MODE_CURSOR_NORMAL=2
export VI_MODE_CURSOR_VISUAL=6
export VI_MODE_CURSOR_INSERT=5

# Oh My Posh init
# Adjust the config path to your file location
# -------------------------------
# eval "$(oh-my-posh init zsh --config ~/.config/oh-my-posh/omp.toml)"


### Style Completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

########## Keybindings ##########
# Autocomplete
bindkey ',' autosuggest-accept
bindkey '\' menu-select
bindkey '`' forward-word

# zsh-autosuggestions
bindkey '^n' history-search-forward
bindkey '^p' history-search-backward


########## Atuin ##########
# Initialize Atuin first, then custom keybindings
# eval "$(atuin init zsh)"

# Vi-mode Atuin bindings (only if vi keymap is used)
bindkey -M vicmd '\' atuin-search
bindkey -M vicmd '^[[A' atuin-up-search-vicmd
bindkey -M vicmd '^[OA' atuin-up-search-vicmd
bindkey -M vicmd '^k' atuin-up-search-vicmd

########## Yazi ############
function y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
    yazi "$@" --cwd-file="$tmp"
    if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
        builtin cd -- "$cwd"
    fi
    rm -f -- "$tmp"
}

########## Zoxide (recommended at end) ##########
eval "$(zoxide init zsh)"

########## Oh My Posh ##########
eval "$(oh-my-posh init zsh --config ~/.config/omp/zen.toml)"

# ═══════════════════════════════════════════════════════════════
#  Script Aliases
# ═══════════════════════════════════════════════════════════════

# System Monitor
alias sysmon='zsh ~/scripts/system-health-monitor.zsh'

# Boom Package Manager
alias apt='zsh ~/scripts/boom-beautifier.zsh'

# Clipboard Manager
alias clipman='zsh ~/scripts/clipboard-manager.zsh'
alias clipsave='zsh ~/scripts/clipboard-manager.zsh save'
alias cliplist='zsh ~/scripts/clipboard-manager.zsh list'
alias clipsearch='zsh ~/scripts/clipboard-manager.zsh search'
alias clipall='zsh ~/scripts/clipboard-manager.zsh paste-all'
alias clipcurrent='zsh ~/scripts/clipboard-manager.zsh current'

# File Organizer
alias organize='zsh ~/scripts/file-organizer.zsh'
alias orgdown='zsh ~/scripts/file-organizer.zsh organize'
alias orgstats='zsh ~/scripts/file-organizer.zsh stats'

# Shizuku stuff.
alias shizuku='zsh ~/scripts/shizuku'


########## Cosmetic (interactive only) ##########
# Auto-start SSH server silently, enable this after setting up your Mixplorer.
# pgrep -x "sshd" > /dev/null || sshd

# Welcome greeting with neofetch.
if [[ -o interactive ]]; then
  command -v neofetch >/dev/null && clear && neofetch
fi

# ───────────────────────────────────────────────────────────────
# Syndot: check for upstream updates and prompt after neofetch
# ───────────────────────────────────────────────────────────────

function _syndot_check_updates() {
  local repo="$HOME/dotfiles"
  local remote="origin"
  local branch

  [[ -d "$repo/.git" ]] || return 0

  branch="$(git -C "$repo" rev-parse --abbrev-ref --symbolic-full-name @{u} 2>/dev/null)"
  if [[ -z "$branch" ]]; then
    if git -C "$repo" show-ref --verify --quiet refs/remotes/origin/main; then
      branch="origin/main"
    elif git -C "$repo" show-ref --verify --quiet refs/remotes/origin/master; then
      branch="origin/master"
    else
      return 0
    fi
  fi

  git -C "$repo" fetch --quiet "$remote" >/dev/null 2>&1 || return 0

  local upstream="$branch"
  local left_right_count
  left_right_count="$(git -C "$repo" rev-list --left-right --count "$upstream"...@ 2>/dev/null)" || return 0
  local behind ahead
  behind="${left_right_count%% *}"
  ahead="${left_right_count##* }"

  if [[ "${behind:-0}" -gt 0 ]]; then
    export SYNDOT_NEEDS_UPDATE=1
  fi
}

if [[ -o interactive ]]; then
  _syndot_check_updates
fi

if [[ -o interactive && -n "${SYNDOT_NEEDS_UPDATE:-}" ]]; then
  print -P "%F{39}Syndot updates are available for ~/dotfiles. Update now?%f [Y/n] "
  local _syndot_reply
  read -sk 1 _syndot_reply
  echo
  if [[ -z "$_syndot_reply" || "$_syndot_reply" == [Yy] ]]; then
    bash "$HOME/dotfiles/uodate.sh"
  fi
  unset SYNDOT_NEEDS_UPDATE _syndot_reply
fi
