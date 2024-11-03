#!/bin/bash

cat <<EOF
╔═╗┬ ┬┌─┐┌┐┌┌─┐┌─┐┬┌┬┐
║  ├─┤├─┤││││ ┬├┤ │ │ 
╚═╝┴ ┴┴ ┴┘└┘└─┘└─┘o ┴ 
EOF

add_first=""
add_end=""
output_file=""
backup_mode=0
quiet_mode=0
verbose_mode=0
declare -a select_texts
declare -a replace_texts

show_help() {
    cat <<EOF
Usage: $0 [file] [options]

Options:
  -h,  --help              Display this help message
  -v,  --verbose           Display additional processing information
  -q,  --quiet             Silent mode, no output to the screen
  -af, --add-first <text>  Add <text> at the beginning of each line
  -ae, --add-end   <text>  Add <text> at the end of each line
  -s,  --select    <text>  Text to be replaced (must not be empty)
  -r,  --replace   <text>  Replacement text (must follow --select and not be empty)
  -o,  --output    <text>  Output file to save changes (default: display on screen)
  -b,  --backup            Create a backup of the output file if it already exists
EOF
    exit 1
}

process_line() {
    local line="$1"

    [[ -n "$add_first" ]] && line="${add_first}${line}"
    [[ -n "$add_end" ]] && line="${line}${add_end}"

    for ((i = 0; i < ${#select_texts[@]}; i++)); do
        line="${line//"${select_texts[i]}"/"${replace_texts[i]}"}"
    done

    if [[ -n "$output_file" ]]; then
        echo "$line" >>"$output_file" # Append output to the file
    elif [[ "$quiet_mode" -eq 0 ]]; then
        echo "$line"
    fi

    if [[ "$verbose_mode" -eq 1 ]]; then
        echo "Processed line: $line"
    fi
}

if [[ "$#" -eq 0 ]]; then
    echo "Error: No options provided."
    show_help
fi

if [[ -t 0 ]]; then
    input_file="$1"
    shift
else
    input_file=""
fi

while [[ "$#" -gt 0 ]]; do
    case "$1" in
    -af | --add-first)
        add_first="$2"
        shift 2
        ;;
    -ae | --add-end)
        add_end="$2"
        shift 2
        ;;
    -s | --select)
        select_texts+=("$2")
        shift 2
        ;;
    -r | --replace)
        replace_texts+=("$2")
        shift 2
        ;;
    -o | --output)
        output_file="$2"
        shift 2
        ;;
    -b | --backup)
        backup_mode=1
        shift
        ;;
    -q | --quiet)
        quiet_mode=1
        shift
        ;;
    -v | --verbose)
        verbose_mode=1
        shift
        ;;
    -h | --help) show_help ;;
    *)
        echo "Unknown option: $1"
        show_help
        ;;
    esac
done

if [[ ${#select_texts[@]} -ne ${#replace_texts[@]} ]]; then
    echo "Error: Each -s must have a corresponding -r."
    show_help
fi

for select in "${select_texts[@]}"; do
    if [[ -z "$select" ]]; then
        echo "Error: Selected text for replacement must not be empty."
        exit 1
    fi
done

for replace in "${replace_texts[@]}"; do
    if [[ -z "$replace" ]]; then
        echo "Error: Replacement text must not be empty."
        exit 1
    fi
done

if [[ -n "$output_file" ]]; then
    if [[ -e "$output_file" ]]; then
        # If output file exists and backup mode is enabled, create a backup
        if [[ "$backup_mode" -eq 1 ]]; then
            cp "$output_file" "${output_file}.bak" # Create a backup
            echo "Backup created: ${output_file}.bak"
        fi

        # Clear the output file (regardless of backup mode)
        >"$output_file" # Clear the file
        echo "Output file '$output_file' has been cleared."
    else
        # Create the output file if it does not exist
        touch "$output_file"
    fi
fi

if [[ -n "$input_file" ]]; then
    while IFS= read -r line; do
        process_line "$line"
    done <"$input_file"
else
    while IFS= read -r line; do
        process_line "$line"
    done # Read from stdin
fi
