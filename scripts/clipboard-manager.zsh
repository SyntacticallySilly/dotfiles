#!/usr/bin/env zsh
# clipboard-manager.zsh
# Manage clipboard history with search, restore, and paste-all capabilities

set -euo pipefail

CLIP_DIR="$HOME/.clipboard_history"
CLIP_FILE="$CLIP_DIR/history.txt"
MAX_ENTRIES=100

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
CYAN='\033[0;36m'
NC='\033[0m'

have() { command -v "$1" >/dev/null 2>&1; }

# Initialize clipboard directory
init_clipboard() {
    mkdir -p "$CLIP_DIR"
    touch "$CLIP_FILE"
}

# Check for termux-api
check_dependencies() {
    if ! have termux-clipboard-get || ! have termux-clipboard-set; then
        echo "${RED}Error: termux-api not installed${NC}"
        echo "${YELLOW}Install with: pkg install termux-api${NC}"
        echo "${YELLOW}Also install Termux:API from F-Droid${NC}"
        exit 1
    fi
}

# Save current clipboard to history
save_clipboard() {
    local clip_content
    clip_content="$(termux-clipboard-get 2>/dev/null || true)"
    
    if [[ -z "${clip_content// }" ]]; then
        echo "${RED}Clipboard is empty${NC}"
        return
    fi
    
    local timestamp
    timestamp="$(date '+%Y-%m-%d %H:%M:%S')"
    local entry="[$timestamp] $clip_content"
    
    # Check if it's a duplicate of the last entry
    local last_entry
    last_entry="$(tail -1 "$CLIP_FILE" 2>/dev/null || true)"
    if [[ "$entry" != "$last_entry" ]]; then
        echo "$entry" >> "$CLIP_FILE"
        
        # Keep only last MAX_ENTRIES
        local line_count
        line_count="$(wc -l < "$CLIP_FILE")"
        if (( line_count > MAX_ENTRIES )); then
            tail -n "$MAX_ENTRIES" "$CLIP_FILE" > "$CLIP_FILE.tmp"
            mv "$CLIP_FILE.tmp" "$CLIP_FILE"
        fi
        
        echo "${GREEN}✅ Clipboard saved${NC}"
    else
        echo "${YELLOW}Duplicate entry, not saved${NC}"
    fi
}

# List clipboard history
list_history() {
    if [[ ! -s "$CLIP_FILE" ]]; then
        echo "${YELLOW}No clipboard history yet${NC}"
        return
    fi
    
    echo "${CYAN}📋 Clipboard History${NC}\n"
    
    local count=1
    while IFS= read -r line; do
        echo "${GREEN}[$count]${NC} $line"
        ((count++))
    done < "$CLIP_FILE"
}

# Search history with fzf
search_history() {
    if ! have fzf; then
        echo "${YELLOW}fzf not installed. Installing...${NC}"
        pkg install fzf -y || {
            echo "${RED}Failed to install fzf${NC}"
            return 1
        }
    fi
    
    if [[ ! -s "$CLIP_FILE" ]]; then
        echo "${YELLOW}No clipboard history yet${NC}"
        return
    fi
    
    local selected
    selected="$(cat "$CLIP_FILE" | \
        fzf --height=60% \
            --border=rounded \
            --prompt="Select clipboard entry: " \
            --header="ENTER: restore to clipboard | ESC: cancel" \
            --preview='echo {} | sed "s/^\[[^]]*\] //"' \
            --preview-window=down:3:wrap \
            --bind='ctrl-y:execute-silent(echo {} | sed "s/^\[[^]]*\] //" | termux-clipboard-set)+abort' \
            --color='fg:#d0d0d0,bg:#1c1c1c,hl:#5f87af' \
            --color='fg+:#ffffff,bg+:#3a3a3a,hl+:#5fd7ff' \
            --color='info:#afaf87,prompt:#d7005f,pointer:#af5fff' \
            --color='marker:#87ff00,spinner:#af5fff,header:#87afaf')"
    
    if [[ -n "$selected" ]]; then
        # Extract content without timestamp
        local content
        content="$(echo "$selected" | sed 's/^\[[^]]*\] //')"
        echo "$content" | termux-clipboard-set
        
        # Try to paste
        trigger_paste_key || true
        
        echo "${GREEN}✅ Restored to clipboard:${NC}"
        echo "$content"
    fi
}

# Restore by number
restore_by_number() {
    local num="${1:-}"
    
    if [[ -z "$num" ]]; then
        echo "${RED}Usage: clipman restore <number>${NC}"
        return 1
    fi
    
    if [[ ! -s "$CLIP_FILE" ]]; then
        echo "${YELLOW}No clipboard history yet${NC}"
        return
    fi
    
    local total_lines
    total_lines="$(wc -l < "$CLIP_FILE")"
    
    if (( num < 1 || num > total_lines )); then
        echo "${RED}Invalid entry number. Valid range: 1-${total_lines}${NC}"
        return
    fi
    
    local selected content
    selected="$(sed -n "${num}p" "$CLIP_FILE")"
    content="$(echo "$selected" | sed 's/^\[[^]]*\] //')"
    
    echo "$content" | termux-clipboard-set
    trigger_paste_key || true
    
    echo "${GREEN}✅ Restored entry #${num} to clipboard${NC}"
}

# Try to trigger system paste into focused field (Android KEYCODE_PASTE=279)
trigger_paste_key() {
    if have input; then
        input keyevent 279 2>/dev/null || return 1
    else
        return 1
    fi
}

# Set clipboard to all entries combined
set_all_to_clipboard() {
    local sep="${1:-\n\n}"
    # Join entries with chosen separator, removing timestamps
    awk -v SEP="$sep" '
        {
            sub(/^\[[^]]*\] /, "")
            if (NR > 1) printf "%s", SEP
            printf "%s", $0
        }
    ' "$CLIP_FILE" | termux-clipboard-set
}

# Paste all history entries
paste_all() {
    if [[ ! -s "$CLIP_FILE" ]]; then
        echo "${YELLOW}No clipboard history to paste${NC}"
        return
    fi
    
    local sep="${1:-\n\n}"
    
    echo "${CYAN}Combining all ${GREEN}$(wc -l < "$CLIP_FILE")${CYAN} entries...${NC}"
    set_all_to_clipboard "$sep"
    
    # Try to paste
    if trigger_paste_key; then
        echo "${GREEN}✅ All entries pasted${NC}"
    else
        echo "${GREEN}✅ All entries copied to clipboard${NC}"
        echo "${YELLOW}Manual paste required (input keyevent not available)${NC}"
    fi
}

# Clear history
clear_history() {
    read "response?${YELLOW}Clear all clipboard history? [y/N]:${NC} "
    if [[ "$response" =~ ^[Yy]$ ]]; then
        > "$CLIP_FILE"
        echo "${GREEN}✅ History cleared${NC}"
    else
        echo "${CYAN}Cancelled${NC}"
    fi
}

# Show current clipboard
show_current() {
    local current
    current="$(termux-clipboard-get 2>/dev/null || true)"
    if [[ -n "$current" ]]; then
        echo "${CYAN}Current Clipboard:${NC}"
        echo "$current"
    else
        echo "${YELLOW}Clipboard is empty${NC}"
    fi
}

# Display usage
usage() {
    echo "${CYAN}Clipboard Manager${NC}\n"
    echo "Usage:"
    echo "  ${GREEN}clipman save${NC}             - Save current clipboard"
    echo "  ${GREEN}clipman list${NC}             - List all history"
    echo "  ${GREEN}clipman search${NC}           - Search with fzf (interactive)"
    echo "  ${GREEN}clipman restore <n>${NC}      - Restore entry #n"
    echo "  ${GREEN}clipman paste-all [sep]${NC}  - Paste all entries (default sep: blank line)"
    echo "  ${GREEN}clipman current${NC}          - Show current clipboard"
    echo "  ${GREEN}clipman clear${NC}            - Clear all history"
    echo ""
    echo "Aliases: ${BLUE}s${NC}=save, ${BLUE}l${NC}=list, ${BLUE}f${NC}|${BLUE}search${NC}=search, ${BLUE}r${NC}=restore, ${BLUE}c${NC}=current"
}

# Main script
init_clipboard
check_dependencies

case "${1:-help}" in
    save|s)
        save_clipboard
        ;;
    list|l)
        list_history
        ;;
    search|find|f)
        search_history
        ;;
    restore|r)
        restore_by_number "${2:-}"
        ;;
    paste-all|all|pa)
        paste_all "${2:-}"
        ;;
    current|c)
        show_current
        ;;
    clear)
        clear_history
        ;;
    help|--help|-h|*)
        usage
        ;;
esac
