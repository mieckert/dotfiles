#!/usr/bin/env bash

# Safety check for Bash version
if (( BASH_VERSINFO[0] < 4 )); then
    echo "echo '❌ Error: Bash 4.0+ required. Check your PATH or run brew install bash.'"
    exit 1
fi

ENV_DIR="$HOME/.env"
declare -A FILE_TO_TITLE
declare -A FILE_TO_EXCLUDES
SELECTED_IDS=()

if [[ ! -d "$ENV_DIR" ]]; then
    echo "echo '❌ Error: .env directory not found.'"
    exit 1
fi

# 1. Gather Metadata
for FILE_PATH in "$ENV_DIR"/*.env; do
    [[ "$FILE_PATH" == *".unset.env" ]] && continue
    [[ ! -f "$FILE_PATH" ]] && continue

    FILENAME=$(basename "$FILE_PATH")
    ID="${FILENAME%.env}"
    
    TITLE=$(grep -m 1 "^# Title:" "$FILE_PATH" | sed 's/^# Title: //')
    EXCLUDES=$(grep -m 1 "^# Excludes:" "$FILE_PATH" | sed 's/^# Excludes: //')
    
    [ -z "$TITLE" ] && TITLE="$ID"

    FILE_TO_TITLE["$ID"]="$TITLE"
    FILE_TO_EXCLUDES["$ID"]="$EXCLUDES"
done

# 2. Display UI
CHOSEN_TITLES=$(printf "%s\n" "${FILE_TO_TITLE[@]}" | gum choose --no-limit --cursor-prefix "[ ] " --selected-prefix "[x] " --unselected-prefix "[ ] ")
[[ -z "$CHOSEN_TITLES" ]] && exit 0

# 3. Map Titles back to IDs
for TITLE in "${FILE_TO_TITLE[@]}"; do
    if echo "$CHOSEN_TITLES" | grep -q "^$TITLE$"; then
        for KEY in "${!FILE_TO_TITLE[@]}"; do
            [[ "${FILE_TO_TITLE[$KEY]}" == "$TITLE" ]] && SELECTED_IDS+=("$KEY")
        done
    fi
done

# 4. Conflict Validation
for ID in "${SELECTED_IDS[@]}"; do
    EX_ID="${FILE_TO_EXCLUDES[$ID]}"
    if [[ -n "$EX_ID" ]]; then
        for CHECK_ID in "${SELECTED_IDS[@]}"; do
            if [[ "$CHECK_ID" == "$EX_ID" ]]; then
                echo "gum style --foreground 196 '❌ Conflict: $ID.env excludes $EX_ID.env'" >&2
                exit 1
            fi
        done
    fi
done

# 5. Output Commands for Eval
for ID in "${!FILE_TO_TITLE[@]}"; do
    T="${FILE_TO_TITLE[$ID]}"
    P="$ENV_DIR/$ID.env"
    U="$ENV_DIR/$ID.unset.env"

    is_selected=false
    for s_id in "${SELECTED_IDS[@]}"; do
        [[ "$s_id" == "$ID" ]] && is_selected=true && break
    done

    if [ "$is_selected" = true ]; then
        # Print the file content line by line to ensure clean execution
        while IFS= read -r line || [[ -n "$line" ]]; do
            [[ "$line" =~ ^# ]] && continue # Skip comments
            [[ -z "$line" ]] && continue     # Skip empty lines
            echo "$line"
        done < "$P"
        echo "echo '✅ Enabled: $T'"
    else
        if [[ -f "$U" ]]; then
            cat "$U"
            echo "" # Safety newline
        else
            VARS=$(grep -oE 'export [A-Z0-9_]+' "$P" | awk '{print $2}')
            if [[ -n "$VARS" ]]; then
                for V in $VARS; do 
                    echo "unset $V"
                done
            fi
        fi
        echo "echo '  Disabled: $T'"
    fi
done