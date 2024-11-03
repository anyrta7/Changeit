#!/bin/bash

add_first=""
add_end=""
output_file=""
backup_mode=0
quiet_mode=0
verbose_mode=0
declare -a select_texts
declare -a replace_texts

if [[ "$#" -eq 0 ]]; then
    echo "Error: No options provided."
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
