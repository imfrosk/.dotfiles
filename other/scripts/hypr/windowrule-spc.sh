#!/usr/bin/env bash

# Hyprland Window Rule Creator
# Creates window rules using only the window class
# No title matching, no backup files

# Configuration
CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/hypr"
RULES_FILE="${HOME}/.dotfiles/programs/home/hyprland/config/generated-windowrules.conf"

get_window_details() {
    local client=$(hyprctl activewindow -j)
    
    WINDOW_CLASS=$(echo "$client" | jq -r '.class')
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
    local x="$2"
    local y="$3"
    local width="$4"
    local height="$5"
    
    local esc_class=$(escape_regex "$class")
    local temp_file=$(mktemp)
    local rules_found=0

    # Process existing file
    if [[ -f "$RULES_FILE" ]]; then
        while IFS= read -r line; do
            # Skip existing rules for this class
            if [[ "$line" =~ windowrule.*class:.*${esc_class} ]]; then
                rules_found=1
                continue
            fi
            echo "$line" >> "$temp_file"
        done < "$RULES_FILE"
    fi

    # Add/update rules (without title matching)
    echo "windowrule = float,class:^${class}$" >> "$temp_file"
    echo "windowrule = size ${width} ${height},class:^${class}$" >> "$temp_file"
    echo "windowrule = move ${x} ${y},class:^${class}$" >> "$temp_file"

    mv "$temp_file" "$RULES_FILE"

    echo -e "\nCreated rules for class: ${class}"
    echo "  Position: ${x}x${y}"
    echo "  Size: ${width}x${height}"
}

main() {
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
    
    update_rules "$WINDOW_CLASS" "$WINDOW_POSITION_X" \
                 "$WINDOW_POSITION_Y" "$WINDOW_SIZE_WIDTH" "$WINDOW_SIZE_HEIGHT"
    
    if [[ -n "$HYPRLAND_INSTANCE_SIGNATURE" ]]; then
        echo "Reloading Hyprland..."
        hyprctl reload
    fi
}

main "$@"
