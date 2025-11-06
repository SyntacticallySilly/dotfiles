#!/usr/bin/env bash
set -euo pipefail

# Colors
RED="\033[1;31m"
CYAN="\033[1;36m"
MAG="\033[1;35m"
GRN="\033[1;32m"
YEL="\033[1;33m"
BLU="\033[1;34m"
NC="\033[0m"

# 1) ANSI logo for "SYNDOT"
printf "${CYAN}███████╗${MAG}██╗   ██╗${YEL}███╗   ██╗${GRN}██████╗  ${RED}███████╗${BLU}████████╗${NC}\n"
printf "${CYAN}██╔════╝${MAG}╚██╗ ██╔╝${YEL}████╗  ██║${GRN}██╔══██╗ ${RED}██╔═══██╗${BLU}╚══██╔══╝${NC}\n"
printf "${CYAN}███████╗${MAG} ╚████╔╝ ${YEL}██╔██╗ ██║${GRN}██║  ██║ ${RED}██║   ██║${BLU}   ██║   ${NC}\n"
printf "${CYAN}╚════██║${MAG}  ╚██╔╝  ${YEL}██║╚██╗██║${GRN}██║  ██║ ${RED}██║   ██║${BLU}   ██║   ${NC}\n"
printf "${CYAN}███████║${MAG}   ██║   ${YEL}██║ ╚████║${GRN}██████╔╝ ${RED}╚██████╔╝${BLU}   ██║   ${NC}\n"
printf "${CYAN}╚══════╝${MAG}   ╚═╝   ${YEL}╚═╝  ╚═══╝${GRN}╚═════╝  ${RED} ╚═════╝ ${BLU}   ╚═╝   ${NC}\n"
printf "${GRN}              S Y N D O T${NC}\n\n"

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

printf "${YEL}Removing existing targets in ~ ...${NC}\n"
for t in "${targets[@]}"; do
  if [ -e "$t" ] || [ -L "$t" ]; then
    chmod -R u+rwX "$t" 2>/dev/null || true
    rm -rf --one-file-system "$t" 2>/dev/null || rm -rf "$t"
    printf "${RED}Removed:${NC} %s\n" "$t"
  else
    printf "${CYAN}Skip (not present):${NC} %s\n" "$t"
  fi
done

# 3) Execute `stow .` in ~/dotfiles
DOTFILES_DIR="${HOME_DIR}/dotfiles"
if [ ! -d "$DOTFILES_DIR" ]; then
  printf "${RED}Error:${NC} ~/dotfiles not found. Aborting.\n"
  exit 1
fi

printf "\n${GRN}Running stow from ${DOTFILES_DIR}${NC}\n"
cd "$DOTFILES_DIR"
stow .

# 4) Source zsh, reload Termux settings, cd ~
printf "\n${GRN}Finalizing session...${NC}\n"
if [ -f "${HOME_DIR}/.zshrc" ]; then
  # shellcheck source=/dev/null
  . "${HOME_DIR}/.zshrc"
fi

if command -v termux-reload-settings >/dev/null 2>&1; then
  termux-reload-settings
fi

cd "${HOME_DIR}"

