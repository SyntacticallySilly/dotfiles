#!/usr/bin/env bash
set -euo pipefail

# Essential packages to install
ESSENTIAL_PACKAGES="zellij termux-tools nala tur-repo zoxide yazi eza fd ripgrep fzf zsh neofetch neovim chafa man stow"

# Colors
RED="\u001B[1;31m"
CYAN="\u001B[1;36m"
MAG="\u001B[1;35m"
GRN="\u001B[1;32m"
YEL="\u001B[1;33m"
BLU="\u001B[1;34m"
NC="\u001B[0m"

# 1) ANSI logo for "SYNDOT"
printf "${CYAN}███████╗${MAG}██╗   ██╗${YEL}███╗   ██╗${GRN}██████╗  ${RED}███████╗${BLU}████████╗${NC}
"
printf "${CYAN}██╔════╝${MAG}╚██╗ ██╔╝${YEL}████╗  ██║${GRN}██╔══██╗ ${RED}██╔═══██╗${BLU}╚══██╔══╝${NC}
"
printf "${CYAN}███████╗${MAG} ╚████╔╝ ${YEL}██╔██╗ ██║${GRN}██║  ██║ ${RED}██║   ██║${BLU}   ██║   ${NC}
"
printf "${CYAN}╚════██║${MAG}  ╚██╔╝  ${YEL}██║╚██╗██║${GRN}██║  ██║ ${RED}██║   ██║${BLU}   ██║   ${NC}
"
printf "${CYAN}███████║${MAG}   ██║   ${YEL}██║ ╚████║${GRN}██████╔╝ ${RED}╚██████╔╝${BLU}   ██║   ${NC}
"
printf "${CYAN}╚══════╝${MAG}   ╚═╝   ${YEL}╚═╝  ╚═══╝${GRN}╚═════╝  ${RED} ╚═════╝ ${BLU}   ╚═╝   ${NC}
"
printf "${GRN}              S Y N D O T${NC}

"

# 2) Forcibly and recursively delete targets in $HOME
HOME_DIR="${HOME}"

# Paths to nuke
targets=(
  "${HOME_DIR}/.config"
  "${HOME_DIR}/scripts"
  "${HOME_DIR}/.termux"
  "${HOME_DIR}/.zshrc"
  "${HOME_DIR}/.bashrc"
)

printf "${YEL}Removing existing targets in ~ ...${NC}
"
for t in "${targets[@]}"; do
  if [ -e "$t" ] || [ -L "$t" ]; then
    chmod -R u+rwX "$t" 2>/dev/null || true
    rm -rf --one-file-system "$t" 2>/dev/null || rm -rf "$t"
    printf "${RED}Removed:${NC} %s
" "$t"
  else
    printf "${CYAN}Skip (not present):${NC} %s
" "$t"
  fi
done

# 3) Execute `stow .` in ~/dotfiles
DOTFILES_DIR="${HOME_DIR}/dotfiles"
if [ ! -d "$DOTFILES_DIR" ]; then
  printf "${RED}Error:${NC} ~/dotfiles not found. Aborting.
"
  exit 1
fi

printf "
${GRN}Running stow from ${DOTFILES_DIR}${NC}
"
cd "$DOTFILES_DIR"
stow .

# 4) Source zsh, reload Termux settings, cd ~
printf "
${GRN}Finalizing session...${NC}
"
if [ -f "${HOME_DIR}/.zshrc" ]; then
  # shellcheck source=/dev/null
  . "${HOME_DIR}/.zshrc"
fi

if command -v termux-reload-settings >/dev/null 2>&1; then
  termux-reload-settings
fi

cd "${HOME_DIR}"

# 5) Install packages
printf "
${MAG}Installing essential packages...${NC}
"

# Update package lists first
printf "${YEL}Updating package repositories...${NC}
"
pkg update -y

# Install all packages from ESSENTIAL_PACKAGES variable
printf "${YEL}Installing: ${ESSENTIAL_PACKAGES}${NC}
"
pkg install -y ${ESSENTIAL_PACKAGES}

printf "
${GRN}✓ All packages installed successfully!${NC}
"
# changes thw default shell to zsh.
printf "
${GRN} Setting up the shell...${NC}
"
chsh -s zsh

printf "${CYAN}Setup complete!${NC}
"
