# File Management System

AI-powered file triage using Claude Code. Email or drop files → Claude reads, summarizes, and organizes them.

## How It Works

1. Drop a file in `triage/` (or email it)
2. Claude reads and understands the content
3. File gets moved to an appropriate category folder
4. You get a summary of what was filed and where

Category folders are created dynamically based on your files. No preset structure.

## Requirements

- macOS
- [Claude Code CLI](https://claude.ai/code) installed and authenticated

## Setup

### 1. Install Claude Code

```bash
npm install -g @anthropic-ai/claude-code
claude  # Run once to authenticate
```

### 2. Set Up Email Integration (Optional)

To file documents via email:

1. Add a dedicated email account to Apple Mail (e.g., `yourname.triage@gmail.com`)

2. Copy the AppleScript to Mail's scripts folder:
   ```bash
   mkdir -p ~/Library/Application\ Scripts/com.apple.mail
   cp .filemanager/SaveAttachmentAndReply.scpt ~/Library/Application\ Scripts/com.apple.mail/
   ```

3. Compile the AppleScript:
   ```bash
   osacompile -o ~/Library/Application\ Scripts/com.apple.mail/SaveAttachmentAndReply.scpt .filemanager/SaveAttachmentAndReply.scpt
   ```

4. Create a Mail rule:
   - Mail → Settings → Rules → Add Rule
   - Condition: "To contains [your triage email]"
   - Action: Run AppleScript → `SaveAttachmentAndReply.scpt`

5. Email an attachment → Mail triggers rule → Claude processes → You get a reply

**Note:** Apple Mail rules may need manual triggering (Message → Apply Rules) due to IMAP quirks.

## Usage

### Email Mode
Email an attachment to your triage address. You'll receive a reply with:
```
FILE: document.pdf
SUMMARY: A rental agreement for 123 Main St, $2000/month.
FILED TO: housing
```

### Manual Mode
Drop files directly into the `triage/` folder, then run:
```bash
.filemanager/process_and_respond.sh "filename.pdf"
```

## Folder Structure

```
File Management/
├── triage/           # Drop files here
├── .filemanager/     # App files (hidden)
│   ├── index.md      # Log of all filed documents
│   ├── process_and_respond.sh
│   └── SaveAttachmentAndReply.scpt
└── [categories]/     # Created automatically
```

## Customization

### Seed Categories

Create folders to guide organization:
```bash
mkdir medical taxes receipts
```

Claude will use existing folders when appropriate and create new ones when needed.

### View Filing History

```bash
cat .filemanager/index.md
```

## Troubleshooting

**"claude: command not found"**
- Install: `npm install -g @anthropic-ai/claude-code`
- Or add to PATH: `export PATH="$HOME/.local/bin:$PATH"`

**Permission errors on Desktop**
- System Settings → Privacy & Security → Full Disk Access → Add Terminal

**Email rule not auto-triggering**
- Known Apple Mail/IMAP issue
- Workaround: Select emails → Message → Apply Rules

## License

MIT
