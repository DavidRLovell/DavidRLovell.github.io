#!/bin/bash -x
# -x  Print commands and their arguments as they are executed.

# This script replicates what the Teaching Team will do with each Assessment01 submission.
# i.e., copy it to an empty directory and (try to!) run it, rendering the output to html.

# METHOD
# This script recursively and forcibly removes the directory called
RENDER_DIR="./render"
# before creating that directory again, and copying the Jupyter Notebook called
NOTEBOOK="Assessment01"
# into it.
# The script then uses nbconvert to execute and render that notebook to html
# There is a 2 minute timeout to handle problem Assessment01 code
# e.g., code that contains infinite loops or commands that are waiting for user input.

# EXIT TO AVOID INFINITE RECURSION
# The following section of code from ChatGPT ensures this script will exit
# if a file of the same name exists in the parent directory of this script.
# This is to avoid infinite recursion if someone invokes this script
# in their Assessment01.ipynb file
# See https://chatgpt.com/share/7d7e2aa3-3935-41c9-b9b8-2dfdcf348814

# Get the full path of the script
SCRIPT_PATH="$(realpath "$0")"

# Get the name of the script without the directory
SCRIPT_NAME="$(basename "$SCRIPT_PATH")"

# Get the parent directory of the script
PARENT_DIR="$(dirname "$SCRIPT_PATH")/.."

# Check if a file with the same name as the script exists in the parent directory
if [ -f "$PARENT_DIR/$SCRIPT_NAME" ] && [ "$PARENT_DIR/$SCRIPT_NAME" != "$SCRIPT_PATH" ]; then
  echo "A file named $SCRIPT_NAME exists in the parent directory. Exiting script."
  exit 1
fi

# COPY Assessment01 TO AN EMPTY DIRECTORY
# Make a fresh directory to render in
rm -rf $RENDER_DIR
mkdir  $RENDER_DIR
cp     $NOTEBOOK.ipynb $RENDER_DIR

# EXECUTE THE COPIED NOTEBOOK AND RENDER TO HTML
# The brackets ensure the enclosed commands run in a subshell, rather than changing the 
# working directory of this script.
(
    cd $RENDER_DIR
    timeout 2m jupyter nbconvert $NOTEBOOK --execute --allow-errors --to html
)