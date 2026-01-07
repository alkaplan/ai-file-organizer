#!/bin/bash
# Process a file with Claude and return the response
# Usage: ./process_and_respond.sh "filename"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BASE_DIR="$(dirname "$SCRIPT_DIR")"
FILENAME="$1"
TRIAGE_DIR="$BASE_DIR/triage"
ROOT_INDEX="$SCRIPT_DIR/index.md"
MANUAL_REVIEW_DIR="$BASE_DIR/manual-review"

# Sensitive file patterns - these skip Claude and go to manual-review
SENSITIVE_PATTERNS=(
    "*passport*"
    "*ssn*"
    "*social_security*"
    "*tax_return*"
    "*w2*"
    "*1099*"
    "*bank_statement*"
    "*private_key*"
    "*credentials*"
    "*.pem"
    "*.key"
)

# Check if filename matches any sensitive pattern
FILENAME_LOWER=$(echo "$FILENAME" | tr '[:upper:]' '[:lower:]')
for pattern in "${SENSITIVE_PATTERNS[@]}"; do
    if [[ "$FILENAME_LOWER" == $pattern ]]; then
        # Move to manual-review instead
        mkdir -p "$MANUAL_REVIEW_DIR"
        mv "$TRIAGE_DIR/$FILENAME" "$MANUAL_REVIEW_DIR/"
        echo "FILE: $FILENAME"
        echo "SUMMARY: Sensitive file detected - not sent to Claude for processing"
        echo "FILED TO: manual-review (requires manual categorization)"
        exit 0
    fi
done

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
- Root index: $ROOT_INDEX
- Ignore folders: triage, .filemanager, manual-review

INDEX STRUCTURE:
1. Root index ($ROOT_INDEX) - High-level overview with:
   - Folder descriptions (### foldername/ + one-line description + file count)
   - Recent Activity table (last 10 items: Date, Action, File, Folder)
   - Total file count at bottom

2. Per-folder index ([folder]/_index.md) - Detailed file list with:
   - # foldername/ header
   - One-line folder description
   - ## Files section with table: File | Summary
   - Can have sub-sections for grouping related files

STEPS:
1. Read existing folder _index.md files to understand categories
2. Read and understand the new file
3. Choose the best folder (or create new one with _index.md)
4. Move file to that folder
5. Update the folder's _index.md (add row to Files table)
6. Update root index:
   - Increment folder file count
   - Add to Recent Activity (newest at top, keep max 10)
   - Update total count

CRITICAL: Your final output must be ONLY plain text in this exact format (no markdown):

FILE: [filename]
SUMMARY: [1-2 sentence summary]
FILED TO: [folder name]" --allowedTools "Read,Edit,Write,Bash,Glob" 2>&1)

echo "$RESPONSE"
