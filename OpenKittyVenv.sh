#!/bin/zsh

# Get current directory or use given argument for venv path
if [[ -n "$1" ]]; then
    VENV_PATH="$1"
else
    VENV_PATH="./.venv"
fi

# Check if virtual environment exists
if [[ -d "$VENV_PATH" && -f "$VENV_PATH/bin/activate" ]]; then
    VENV_NAME=$(basename "$VENV_PATH")
    TITLE="(VENV: $VENV_NAME) - Stylized Kitty"
    ACTIVATE_CMD="source \"$VENV_PATH/bin/activate\""
else
    echo "Warning: Virtual environment not found at $VENV_PATH. Launching without activation."
    TITLE="Stylized Kitty"
    ACTIVATE_CMD=""
fi

# Launch kitty with proper quoting to handle spaces and execution
kitty --title "$TITLE" zsh -c "
    $ACTIVATE_CMD
    print -P '\033]0;${TITLE}\007'
    exec zsh
"
