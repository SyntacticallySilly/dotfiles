#!/usr/bin/env bash
set -euo pipefail

# Essential packages to keep updated (same as setup script)
ESSENTIAL_PACKAGES="termux-tools nala tur-repo stow zoxide yazi eza fd ripgrep fzf zsh neofetch neovim chafa man"

# Colors
RED="\u001B[1;31m"
CYAN="\u001B[1;36m"
MAG="\u001B[1;35m"
GRN="\u001B[1;32m"
YEL="\u001B[1;33m"
BLU="\u001B[1;34m"
NC="\u001B[0m"

# Header
printf "${CYAN}╔════════════════════════════════╗${NC}
"
printf "${CYAN}║${GRN}     SYNDOT UPDATE SCRIPT     ${CYAN}║${NC}
"
printf "${CYAN}╚════════════════════════════════╝${NC}

"

HOME_DIR="${HOME}"
DOTFILES_DIR="${HOME_DIR}/dotfiles"

# 1) Pull latest changes from Git repository
printf "${YEL}[1/3] Pulling latest dotfiles from repository...${NC}
"

if [ ! -d "$DOTFILES_DIR" ]; then
  printf "${RED}Error:${NC} ~/dotfiles not found. Please run setup first.
"
  exit 1
fi

cd "$DOTFILES_DIR"

# Stash any local changes before pulling
if ! git diff-index --quiet HEAD -- 2>/dev/null; then
  printf "${YEL}Stashing local changes...${NC}
"
  git stash
fi

# Pull latest changes
if git pull origin main; then
  printf "${GRN}✓ Dotfiles updated successfully!${NC}
"
else
  printf "${RED}✗ Failed to pull updates. Check your internet connection or repository.${NC}
"
  exit 1
fi

# 2) Re-stow dotfiles
printf "
${YEL}[2/3] Applying updated configurations...${NC}
"
stow --restow .
printf "${GRN}✓ Configurations applied!${NC}
"

# 3) Update packages
printf "
${YEL}[3/3] Updating system packages...${NC}
"

# Update package lists
printf "${CYAN}Updating package repositories...${NC}
"
nala update -y

# Upgrade all installed packages
printf "${CYAN}Upgrading all packages...${NC}
"
nala full-upgrade -y

# Ensure essential packages are installed/updated
printf "${CYAN}Verifying essential packages: ${ESSENTIAL_PACKAGES}${NC}
"
nala install -y ${ESSENTIAL_PACKAGES}

printf "
${GRN}✓ All packages updated successfully!${NC}
"

# 4) Reload settings
printf "
${YEL}Reloading shell and Termux settings...${NC}
"

if [ -f "${HOME_DIR}/.zshrc" ]; then
  # shellcheck source=/dev/null
  . "${HOME_DIR}/.zshrc"
fi

if command -v termux-reload-settings >/dev/null 2>&1; then
  termux-reload-settings
fi

cd "${HOME_DIR}"

printf "
${GRN}════════════════════════════════${NC}
"
printf "${GRN}✓ Update complete!${NC}
"
printf "${GRN}════════════════════════════════${NC}
"
