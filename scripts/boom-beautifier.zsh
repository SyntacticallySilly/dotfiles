#!/usr/bin/env zsh
# boom-beautifier.zsh
# Enhanced package manager wrapper with search, stats, and pretty output

# Color codes
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
CYAN='\033[0;36m'
MAGENTA='\033[0;35m'
NC='\033[0m'

# Function to display banner
show_banner() {
    echo "${CYAN}"
    figlet -f small "BOOM!" 2>/dev/null || echo " BOOM Package Manager "
    echo "${NC}"
}

# Function to search packages with fzf
boom_search() {
    if ! command -v fzf &> /dev/null; then
        echo "${YELLOW}Installing fzf for better search experience...${NC}"
        apt install fzf -y
    fi
    
    echo "${CYAN} Searching packages...${NC}"
    local selected=$(apt list 2>/dev/null | awk -F'/' '{print $1}' | fzf --height=50% --border --no-preview )
    
    if [[ -n "$selected" ]]; then
        echo "${GREEN}Selected package: ${selected}${NC}"
        echo "\n${BLUE} Package Information:${NC}"
        apt search "^${selected}$" 2>/dev/null | grep -A 5 "^${selected}/" || apt search "${selected}" 2>/dev/null | head -8
        echo ""
        read "response?Install ${selected}? [Y/n]: "
        if [[ "$response" =~ ^[Yy]$ ]] || [[ -z "$response" ]]; then
            apt install "$selected" -y
        fi
    fi
}

# Function to show installation stats
boom_stats() {
    echo "${CYAN} Package Statistics${NC}\n"
    
    local total_pkgs=$(dpkg --get-selections | wc -l)
    local disk_usage=$(du -sh /data/data/com.termux/files/usr 2>/dev/null | awk '{print $1}')
    local upgradable=$(apt list --upgradable 2>/dev/null | grep -c "upgradable")
    
    echo "${GREEN}Total Packages:${NC} ${total_pkgs}"
    echo "${BLUE}Disk Usage:${NC} ${disk_usage}"
    echo "${YELLOW}Upgradable:${NC} ${upgradable}"
    
    echo "\n${MAGENTA}Recently Installed (Last 5):${NC}"
    grep " install " /data/data/com.termux/files/usr/var/log/apt/history.log 2>/dev/null | tail -5 | \
        awk -F'install ' '{print "   "$2}' || echo "   No recent installations"
}

# Function to install with progress
boom_install() {
    show_banner
    echo "${GREEN} Installing: $@${NC}\n"
    apt update -qq && apt install "$@" -y
    
    if [[ $? -eq 0 ]]; then
        echo "\n${GREEN} Successfully installed: $@${NC}"
    else
        echo "\n${RED} Installation failed${NC}"
    fi
}

# Function to remove with confirmation
boom_remove() {
    echo "${YELLOW} Removing: $@${NC}"
    read "response?Are you sure? [y/N]: "
    if [[ "$response" =~ ^[Yy]$ ]]; then
        apt remove "$@" -y && apt autoremove -y
        echo "${GREEN} Package removed${NC}"
    else
        echo "${CYAN}Cancelled${NC}"
    fi
}

# Function to update system
boom_update() {
    show_banner
    echo "${CYAN} Updating package lists...${NC}"
    apt update
    echo "\n${GREEN}Checking for upgrades...${NC}"
    apt list --upgradable
}

# Function to upgrade system
boom_upgrade() {
    show_banner
    echo "${YELLOW} Upgrading all packages...${NC}"
    apt update && apt upgrade -y
    echo "\n${GREEN} System upgraded!${NC}"
}

# Main command parser
case "$1" in
    install|i)
        shift
        boom_install "$@"
        ;;
    remove|uninstall|r)
        shift
        boom_remove "$@"
        ;;
    search|s)
        boom_search
        ;;
    update|u)
        boom_update
        ;;
    upgrade|up)
        boom_upgrade
        ;;
    stats|info)
        boom_stats
        ;;
    *)
        show_banner
        echo "${CYAN}Usage:${NC}"
        echo "  ${GREEN}boom install${NC} [package]  - Install package(s)"
        echo "  ${GREEN}boom remove${NC} [package]   - Remove package(s)"
        echo "  ${GREEN}boom search${NC}             - Search packages (fzf)"
        echo "  ${GREEN}boom update${NC}             - Update package lists"
        echo "  ${GREEN}boom upgrade${NC}            - Upgrade all packages"
        echo "  ${GREEN}boom stats${NC}              - Show package statistics"
        ;;
esac

