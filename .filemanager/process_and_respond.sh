#!/bin/bash
# Process a file with Claude and return the response
# Usage: ./process_and_respond.sh "filename"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BASE_DIR="$(dirname "$SCRIPT_DIR")"
FILENAME="$1"
TRIAGE_DIR="$BASE_DIR/triage"
INDEX_FILE="$SCRIPT_DIR/index.md"

# Find Claude
if command -v claude &> /dev/null; then
    CLAUDE_PATH=$(which claude)
elif [ -f "$HOME/.local/bin/claude" ]; then
    CLAUDE_PATH="$HOME/.local/bin/claude"
else
    echo "Error: Claude Code CLI not found"
    exit 1
fi

# Run Claude and capture output
RESPONSE=$("$CLAUDE_PATH" -p "Process the file '$FILENAME' in the triage folder at '$TRIAGE_DIR'.

Context:
- Base directory: $BASE_DIR
- Index file: $INDEX_FILE
- Ignore folders: triage, .filemanager

Steps:
1. List existing category folders in '$BASE_DIR' (exclude 'triage' and '.filemanager')
2. Read and understand the file
3. Move it to the best matching folder (or create a new appropriately-named one)
4. Update the index at '$INDEX_FILE'

CRITICAL: Your final output must be ONLY plain text in this exact format (no markdown):

FILE: [filename]
SUMMARY: [1-2 sentence summary]
FILED TO: [folder name]" --allowedTools "Read,Edit,Write,Bash,Glob" 2>&1)

echo "$RESPONSE"
