#!/bin/zsh

# Default to a .venv directory in the current path if no argument is given
if [[ -n "$1" ]]; then
    VENV_PATH="$1"
else
    VENV_PATH="./.venv"
fi

# Check for virtual environment
if [[ -d "$VENV_PATH" && -f "$VENV_PATH/bin/activate" ]]; then
    VENV_NAME=$(basename "$VENV_PATH")
    TITLE="%F{cyan}(VENV: $VENV_NAME)%f - Stylized Kitty"
    ACTIVATE_CMD="source $VENV_PATH/bin/activate"
else
    echo "Warning: Virtual environment not found at $VENV_PATH. Launching without activation."
    TITLE="Stylized Kitty"
    ACTIVATE_CMD=""
fi

# Run kitty with a Zsh-stylized title
kitty --title "$TITLE" zsh -c "
    $ACTIVATE_CMD
    print -P \"\033]0;${TITLE}\007\"
    exec zsh
"
