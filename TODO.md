# AI File Organizer - Roadmap

## Index & Organization

- [ ] **Changelog-style root index** - High-level folder descriptions + recent activity log instead of flat file list
- [ ] **Per-folder indexes** - Each category folder gets its own `_index.md` that Claude reads/updates
- [ ] **Sub-folder support** - Allow nested organization (e.g., `work/projects/acme-corp/`)
- [ ] **Folder descriptions** - Let users add context to folders that Claude reads when deciding where to file

## Retrieval & Search

- [ ] **File retrieval mode** - Run `claude` in the directory and ask "where's the OpenAI doc?" or "find my lease"
- [ ] **Smart search** - Search by content, date range, or fuzzy description
- [ ] **"Show me recent files"** - Quick view of what was filed in last N days

## Filing Intelligence

- [ ] **Preferences file** - User-defined rules like "invoices always go to finance"
- [ ] **Learn from corrections** - If user moves a file, note the pattern
- [ ] **Confidence threshold** - Ask user when unsure instead of guessing
- [ ] **Duplicate detection** - Warn if similar file already exists

## Email Integration

- [ ] **Auto-trigger fix** - Investigate Gmail IMAP/Mail.app rule issues
- [ ] **Subject line commands** - `[finance]` in subject forces category
- [ ] **Multi-attachment handling** - Better support for emails with many files
- [ ] **Forward with context** - Include email body as metadata

## Platform & Setup

- [ ] **Interactive setup wizard** - Claude-guided configuration on first run
- [ ] **Linux/Windows support** - Alternative to Apple Mail integration
- [ ] **iOS Shortcuts integration** - Share sheet → triage
- [ ] **Telegram bot** - Alternative to email for mobile filing

## Quality of Life

- [ ] **Undo last filing** - Quick way to reverse a decision
- [ ] **Batch processing** - Handle multiple files efficiently
- [ ] **Summary reports** - Weekly digest of what was filed
- [ ] **Rename on file** - Clean up messy filenames during triage
