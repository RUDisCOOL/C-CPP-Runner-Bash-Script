# C/C++ Runner-Bash-Script
This is a very simple and easy to use bash script for running and compiling C/C++ programs

## Prerequisites
You must have gcc/g++ installed on your computer to run this script

## Features
- You don't need to give an output flag as always you would do while using gcc or g++. This script defaults to the name of the program file and you can give an output file name by using the **`-o`** flag with the output file name if you want to.
- Are you fed up of a lot of binary files just hanging there in a folder and that looks like sh*t. You can use the **`-r`** to remove the binary file after the execution of your code is completed.

## Usage
```
c_runner.sh [-r] [-o output_file] <file_name>
```

## Notes
- If you want to use it globally inside the whole computer then just add this script to your root's bin directoty i.e. `/bin`
- If you want to use it locally only at some places on your computer then just add the script file in that directory and use it accordingly.
