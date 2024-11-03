#!/bin/bash

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
