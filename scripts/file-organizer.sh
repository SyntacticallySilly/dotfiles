#!/usr/bin/env zsh
# file-organizer.zsh
# Automatically organize files by type into categorized folders

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
CYAN='\033[0;36m'
MAGENTA='\033[0;35m'
NC='\033[0m'

# File type categories
declare -A FILE_CATEGORIES=(
    [images]="jpg jpeg png gif bmp svg webp ico"
    [documents]="pdf doc docx txt md odt rtf"
    [archives]="zip tar gz bz2 rar 7z xz"
    [videos]="mp4 avi mkv mov wmv flv webm"
    [audio]="mp3 wav flac aac ogg m4a"
    [code]="py java c cpp rs go js ts html css sh zsh"
    [data]="json xml csv yaml yml sql"
    [packages]="deb apk rpm pkg"
    [minecraft]="mcpack mcworld mcaddon mctemplate"
)

# Default directories
DEFAULT_SOURCE="$HOME/storage/downloads"
DEFAULT_DEST="$HOME/storage/shared/org"

# Function to create category folders
create_folders() {
    local dest_dir=$1

    for category in ${(k)FILE_CATEGORIES}; do
        mkdir -p "$dest_dir/$category"
    done

    mkdir -p "$dest_dir/others"
    echo "${GREEN} Created organization folders${NC}"
}

# Function to get file category
get_category() {
    local file=$1
    local extension="${file##*.}"
    extension="${extension:l}"  # Convert to lowercase

    for category in ${(k)FILE_CATEGORIES}; do
        if [[ " ${FILE_CATEGORIES[$category]} " =~ " $extension " ]]; then
            echo "$category"
            return
        fi
    done

    echo "others"
}

# Function to generate unique filename
get_unique_filename() {
    local dest_path=$1
    local filename=$(basename "$dest_path")
    local dirname=$(dirname "$dest_path")
    local name="${filename%.*}"
    local ext="${filename##*.}"

    if [[ "$name" == "$ext" ]]; then
        ext=""
    else
        ext=".$ext"
    fi

    local counter=1
    local new_path="$dest_path"

    while [[ -e "$new_path" ]]; do
        new_path="$dirname/${name}_${counter}${ext}"
        ((counter++))
    done

    echo "$new_path"
}

# Function to organize files
organize_files() {
    local source_dir=${1:-$DEFAULT_SOURCE}
    local dest_dir=${2:-$DEFAULT_DEST}
    local mode=${3:-move}  # move or copy

    # Validate source directory
    if [[ ! -d "$source_dir" ]]; then
        echo "${RED}Error: Source directory does not exist: $source_dir${NC}"
        echo "${YELLOW}Run 'termux-setup-storage' if you haven't already${NC}"
        return 1
    fi

    # Create destination folders
    create_folders "$dest_dir"

    echo "${CYAN} Organizing files from: $source_dir${NC}"
    echo "${CYAN}󰞁 Destination: $dest_dir${NC}\n"

    local file_count=0
    local -A category_counts

    # Initialize counters
    for category in ${(k)FILE_CATEGORIES}; do
        category_counts[$category]=0
    done
    category_counts[others]=0

    # Process each file
    for file in "$source_dir"/*; do
        # Skip if not a file
        [[ ! -f "$file" ]] && continue

        local filename=$(basename "$file")
        local category=$(get_category "$filename")
        local dest_path="$dest_dir/$category/$filename"

        # Handle filename conflicts
        dest_path=$(get_unique_filename "$dest_path")

        # Move or copy file
        if [[ "$mode" == "copy" ]]; then
            cp "$file" "$dest_path" && {
                echo "${GREEN} Copied:${NC} $filename ${BLUE}→${NC} $category"
                ((file_count++))
                ((category_counts[$category]++))
            }
        else
            mv "$file" "$dest_path" && {
                echo "${GREEN} Moved:${NC} $filename ${BLUE}→${NC} $category"
                ((file_count++))
                ((category_counts[$category]++))
            }
        fi
    done

    # Display summary
    echo "\n${CYAN}═══════════════════════════════════════${NC}"
    echo "${MAGENTA} Organization Summary${NC}\n"

    for category in ${(k)category_counts}; do
        local count=${category_counts[$category]}
        if (( count > 0 )); then
            echo "  ${GREEN}$category:${NC} $count file(s)"
        fi
    done

    echo "\n${GREEN}󱦟 Total files organized: $file_count${NC}"
    echo "${CYAN}═══════════════════════════════════════${NC}"
}

# Function to show statistics
show_stats() {
    local source_dir=${1:-$DEFAULT_SOURCE}

    if [[ ! -d "$source_dir" ]]; then
        echo "${RED}Directory does not exist: $source_dir${NC}"
        return 1
    fi

    echo "${CYAN} File Statistics for: $source_dir${NC}\n"

    local -A type_counts
    local total=0

    for file in "$source_dir"/*; do
        [[ ! -f "$file" ]] && continue

        local filename=$(basename "$file")
        local category=$(get_category "$filename")
        ((type_counts[$category]++))
        ((total++))
    done

    for category in ${(k)type_counts}; do
        echo "  ${GREEN}$category:${NC} ${type_counts[$category]} file(s)"
    done

    echo "\n${YELLOW}Total files: $total${NC}"
}

# Main command parser
case "$1" in
    organize|o)
        organize_files "$2" "$3" "move"
        ;;
    copy|c)
        organize_files "$2" "$3" "copy"
        ;;
    stats|s)
        show_stats "$2"
        ;;
    setup)
        create_folders "${2:-$DEFAULT_DEST}"
        ;;
    *)
        echo "${CYAN}File Organizer${NC}\n"
        echo "Usage:"
        echo "  ${GREEN}$0 organize [source] [dest]${NC}  - Move files to organized folders"
        echo "  ${GREEN}$0 copy [source] [dest]${NC}      - Copy files (keep originals)"
        echo "  ${GREEN}$0 stats [source]${NC}            - Show file statistics"
        echo "  ${GREEN}$0 setup [dest]${NC}              - Create organization folders"
        echo "\nDefaults:"
        echo "  Source: ${YELLOW}$DEFAULT_SOURCE${NC}"
        echo "  Dest:   ${YELLOW}$DEFAULT_DEST${NC}"
        ;;
esac
