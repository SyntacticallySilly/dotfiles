#!/$PATH/bash

set -e  # Exit immediately on any error

# ─── Colors ────────────────────────────────────────────────────
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
BOLD='\033[1m'
RESET='\033[0m'

# ─── Helpers ───────────────────────────────────────────────────
info()    { echo -e "${CYAN}${BOLD}[syndot]${RESET} $*"; }
success() { echo -e "${GREEN}${BOLD}[  ok  ]${RESET} $*"; }
warn()    { echo -e "${YELLOW}${BOLD}[ warn ]${RESET} $*"; }
die()     { echo -e "${RED}${BOLD}[ fail ]${RESET} $*"; exit 1; }

banner() {
  echo -e "${CYAN}${BOLD}"
  cat <<'EOF'
  ███████╗██╗   ██╗███╗   ██╗██████╗  ██████╗ ████████╗
  ██╔════╝╚██╗ ██╔╝████╗  ██║██╔══██╗██╔═══██╗╚══██╔══╝
  ███████╗ ╚████╔╝ ██╔██╗ ██║██║  ██║██║   ██║   ██║
  ╚════██║  ╚██╔╝  ██║╚██╗██║██║  ██║██║   ██║   ██║
  ███████║   ██║   ██║ ╚████║██████╔╝╚██████╔╝   ██║
  ╚══════╝   ╚═╝   ╚═╝  ╚═══╝╚═════╝  ╚═════╝    ╚═╝
EOF
  echo -e "${RESET}"
  echo -e "  ${BOLD}Made with <3 by synthyst>${RESET}"
  echo -e "  ─────────────────────────────────────────────────────\n"
}

# ══════════════════════════════════════════════════════════════
# STEP 0 — Banner
# ══════════════════════════════════════════════════════════════
banner

# ══════════════════════════════════════════════════════════════
# STEP 1 — Storage & Package Update
# ══════════════════════════════════════════════════════════════
info "Setting up Termux storage access..."
termux-setup-storage
success "Storage setup done."

info "Updating package lists and upgrading installed packages..."
pkg update -y && pkg upgrade -y
success "System updated."

# ══════════════════════════════════════════════════════════════
# STEP 2 — Add Repos (tur-repo, termux-void)
#           Must be done before installing packages that live in them
# ══════════════════════════════════════════════════════════════
info "Installing extra repositories (tur-repo, glibc, termux-void)..."
pkg install -y tur-repo glibc-repo


curl -sL https://termuxvoid.github.io/repo/install.sh | bash -s -- -s

pkg update -y
success "Repos added and index refreshed."

# ══════════════════════════════════════════════════════════════
# STEP 3 — Install All Packages
# ══════════════════════════════════════════════════════════════
info "Installing all required packages..."

PACKAGES=(
  zsh
  neovim
  lua-language-server
  termux-api
  termux-tools
  clangd
  cmake
  yazi
  glow
  git
  wget
  tmux
  bat
  zoxide
  eza
  fzf
  fzy
  lazygit
  gcc
  man
  tealdeer
  starship
  nala
  ripgrep
  fd
  fastfetch
  stow
)

for pkg in "${PACKAGES[@]}"; do
  info "  Installing: ${BOLD}${pkg}${RESET}"
  pkg install -y "$pkg" || warn "  '$pkg' failed — skipping (may not exist in current repos)."
done

success "All packages installed."

# ══════════════════════════════════════════════════════════════
# STEP 4 — Clone Dotfiles Repo
# ══════════════════════════════════════════════════════════════
DOTFILES_DIR="$HOME/dotfiles"

if [[ -d "$DOTFILES_DIR" ]]; then
  warn "~/dotfiles already exists — removing before fresh clone..."
  rm -rf "$DOTFILES_DIR"
fi

info "Cloning dotfiles from GitHub..."
git clone https://github.com/synthyst/dotfiles 
success "Dotfiles cloned to $DOTFILES_DIR"

# ══════════════════════════════════════════════════════════════
# STEP 5 — Remove Conflicting Configs
# ══════════════════════════════════════════════════════════════
info "Removing existing configs that would conflict with stow..."

TARGETS=(
  "$HOME/.config"
  "$HOME/.termux"
  "$HOME/.zshrc"
  "$HOME/.bashrc"
  "$HOME/scripts"
)

for target in "${TARGETS[@]}"; do
  if [[ -e "$target" || -L "$target" ]]; then
    rm -rf "$target"
    success "  Removed: $target"
  else
    warn "  Not found (skipping): $target"
  fi
done

success "Conflict cleanup done."

# ══════════════════════════════════════════════════════════════
# STEP 6 — Stow Dotfiles
# ══════════════════════════════════════════════════════════════
info "Stowing dotfiles..."
cd "$DOTFILES_DIR"
stow .
success "Dotfiles stowed successfully."

# ══════════════════════════════════════════════════════════════
# STEP 7 — Set Default Shell to Zsh
# ══════════════════════════════════════════════════════════════
info "Setting default shell to zsh..."
chsh -s zsh
success "Default shell changed to zsh."

# ══════════════════════════════════════════════════════════════
# DONE
# ══════════════════════════════════════════════════════════════
echo ""
echo -e "${GREEN}${BOLD}╔══════════════════════════════════════════════════╗${RESET}"
echo -e "${GREEN}${BOLD}║   Syndot install complete! Restart Termux to     ║${RESET}"
echo -e "${GREEN}${BOLD}║   load your fresh zsh environment. Enjoy!        ║${RESET}"
echo -e "${GREEN}${BOLD}╚══════════════════════════════════════════════════╝${RESET}"
echo ""

exit

