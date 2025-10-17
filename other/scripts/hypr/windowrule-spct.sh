#!/usr/bin/env bash

# Hyprland Window Rule Creator
# Creates or updates window rules for the currently focused window
# Adds descriptive comments and prevents duplicate rules

# Configuration
CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/hypr"
RULES_FILE="${HOME}/.dotfiles/modules/gui/ux/hyprland/config/generated-windowrules.conf"

get_window_details() {
    local client=$(hyprctl activewindow -j)
    
    WINDOW_CLASS=$(echo "$client" | jq -r '.class')
    WINDOW_TITLE=$(echo "$client" | jq -r '.title')
    WINDOW_ADDRESS=$(echo "$client" | jq -r '.address')
    WINDOW_POSITION_X=$(echo "$client" | jq -r '.at[0]')
    WINDOW_POSITION_Y=$(echo "$client" | jq -r '.at[1]')
    WINDOW_SIZE_WIDTH=$(echo "$client" | jq -r '.size[0]')
    WINDOW_SIZE_HEIGHT=$(echo "$client" | jq -r '.size[1]')
}

escape_regex() {
    printf '%s' "$1" | sed 's/[][\.*^$(){}?+|]/\\&/g'
}

update_rules() {
    local class="$1"
    local title="$2"
    local x="$3"
    local y="$4"
    local width="$5"
    local height="$6"
    
    # Escape special characters
    local esc_class=$(escape_regex "$class")
    local esc_title=$(escape_regex "$title")
    
    # Create temp file
    local temp_file=$(mktemp)
    local rules_found=0
    
    # Process existing file
    if [[ -f "$RULES_FILE" ]]; then
        while IFS= read -r line; do
            # Skip existing rules for this window
            if [[ "$line" =~ windowrule.*class:.*${esc_class}.*title:.*${esc_title} ]]; then
                rules_found=1
                continue
            fi
            echo "$line" >> "$temp_file"
        done < "$RULES_FILE"
    fi
    
    
    # Add/update rules
    echo "windowrule = float,class:^${class}$,title:^${title}$" >> "$temp_file"
    echo "windowrule = size ${width} ${height},class:^${class}$,title:^${title}$" >> "$temp_file"
    echo "windowrule = move ${x} ${y},class:^${class}$,title:^${title}$" >> "$temp_file"
    
    # Replace original file
    mv "$temp_file" "$RULES_FILE"
    
    echo -e "\nCreated/updated rules for:"
    echo "  Class:    ${class}"
    echo "  Title:    ${title}"
    echo "  Position: ${x}x${y}"
    echo "  Size:     ${width}x${height}"
}

main() {
    # Check requirements
    if ! command -v hyprctl &> /dev/null; then
        echo "Error: hyprctl not found. Are you running Hyprland?"
        exit 1
    fi
    
    if ! command -v jq &> /dev/null; then
        echo "Error: jq is required but not installed. Please install jq first."
        exit 1
    fi
    
    get_window_details
    
    if [[ -z "$WINDOW_CLASS" ]]; then
        echo "Error: Could not get window details. No window focused?"
        exit 1
    fi
    
    update_rules "$WINDOW_CLASS" "$WINDOW_TITLE" "$WINDOW_POSITION_X" \
                 "$WINDOW_POSITION_Y" "$WINDOW_SIZE_WIDTH" "$WINDOW_SIZE_HEIGHT"
}

main "$@"
