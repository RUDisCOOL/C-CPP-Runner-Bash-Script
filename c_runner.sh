#!/usr/bin/bash

RED='\033[31m'
GREEN='\033[32m'
BLUE='\033[34m'
YELLOW='\033[33m'
NC='\033[0m'
REMOVE_AFTER_COMPLETE=false
output_file_name=""

# Function to display usage
usage() {
    echo -e "${RED}Usage: $0 [-r] [-o output_file] <file_name>${NC}"
    exit 1
}

# Use getopts to parse short options
while getopts "ro:" opt; do
    case ${opt} in
        r)
            REMOVE_AFTER_COMPLETE=true
            ;;
        o)
            output_file_name="$OPTARG"
            ;;
        *)
            usage
            ;;
    esac
done

# Shift the arguments so that $1 refers to the file_name after options
shift $((OPTIND - 1))

# Check if file name is provided
if [ $# -eq 0 ]; then
    echo -e "${RED}No file name provided${NC}"
    usage
fi

file_name=$1
file_type="${file_name##*.}"

# Set output file name to default if not provided via -o
if [ -z "$output_file_name" ]; then
    output_file_name="${file_name%.*}"
fi

# Debugging: Print file and output names
echo -e "${YELLOW}Compiling file: $file_name${NC}"
echo -e "${YELLOW}Output file: $output_file_name${NC}"

# Compile based on file type
if [ "$file_type" == "cpp" ]; then
    g++ "$file_name" -o "$output_file_name"
elif [ "$file_type" == "c" ]; then
    gcc "$file_name" -o "$output_file_name"
else
    echo -e "${RED}Error: Invalid file format\nFile is neither .cpp nor .c${NC}"
    exit 1
fi

# Check if the binary was successfully created
if [ ! -f "$output_file_name" ]; then
    echo -e "${RED}Error: Compilation failed. Binary not found.${NC}"
    exit 1
fi

# Execute the binary
echo -e "${GREEN}Executing the binary: ./${output_file_name}${BLUE}"
"./${output_file_name}"
echo -e "${NC}"

# Check if the binary was executed successfully
if [ $? -ne 0 ]; then
    echo -e "${RED}Error: Failed to execute ${output_file_name}.${NC}"
    exit 1
fi

# Remove the binary if the -r flag was provided
if [ "$REMOVE_AFTER_COMPLETE" = true ]; then
    rm -f "$output_file_name"
    echo -e "${RED}Binary file ${output_file_name} removed after execution.${NC}"
fi
