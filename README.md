# **Changeit**

``` text
╔═╗┬ ┬┌─┐┌┐┌┌─┐┌─┐┬┌┬┐
║  ├─┤├─┤││││ ┬├┤ │ │ 
╚═╝┴ ┴┴ ┴┘└┘└─┘└─┘o ┴
```

## Overview

This script allows you to modify the content of a text file by adding text at the beginning or end of each line, replacing certain text, and saving the results to an output file. The script also supports the option to create a backup of the output file if one already exists.

## Instalation

1. **Donwload the Script:**

   Use one of the following commands to download the script:

   ```bash
    wget https://github.com/anyrta7/changeit/raw/master/changeit.sh
    ```

    or use the curl

    ```bash
    curl -O https://github.com/anyrta7/changeit/raw/master/changeit.sh
    ```

2. **Make the Script Executable:**

    Grant execute permissions to the script with the following command:

    ```bash
    chmod +x changeit.sh
    ```

    To make the script run via bin, do the following:

    ```bash
    mv changeit.sh /usr/bin/changeit
    ```

## Usage

To use the script, run it with the `input file` and desired options. The script will process text based on the provided options.

```bash
changeit <file> [options]
```

### Options

- `-h`,  `--help` Display this help message
- `-v`,  `--verbose` Display additional processing information
- `-q`,  `--quiet` Silent mode, no output to the screen
- `-af`, `--add-first` Add **text** at the beginning of each line
- `-ae`, `--add-end` Add **text** at the end of each line
- `-s`,  `--select` Text to be replaced (must not be empty)
- `-r`,  `--replace` Replacement **text** (must follow --select and not be empty)
- `-o`,  `--output` Output file to save changes (default: display on screen)
- `-b`,  `--backup` Create a backup of the output file if it already exists

### Examples

1. **Add Text to the Beginning and End of Each Line:**

    ```bash
    changeit input.txt -af 'https://' -ae '/path' --output output.txt
    ```

2. **Replace Text with Backup:**

    ```bash
    changeit input1.txt -s 'old_text' -r 'new_text' -o output.txt -b
    ```

3. **Use the Script with stdin and Remove Text:**

    ```bash
    cat input.txt | changeit -s 'foo' -r ''
    ```

## Notes

- If no `--output` option is provided, the script will overwrite the original input files.
- The `--update` option will pull the latest version of the script from GitHub. Ensure that `git`, `curl`, or `wget` is available for updating the script.

For additional help or information, refer to the help message using `-h` or `--help`.