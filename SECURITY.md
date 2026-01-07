# Security Considerations

## Data Retention

This tool sends file contents to Anthropic's Claude API for processing.

### What happens to your data:

| Aspect | Status |
|--------|--------|
| Training | **Never** - API data is not used for model training |
| Retention | **7 days** - API logs deleted after 7 days (standard plan) |
| Storage | Files stay local - only content sent for analysis |

### Zero Data Retention (ZDR)

For stricter compliance, Anthropic offers ZDR agreements where:
- Logs processed for real-time abuse detection only
- Immediately discarded after processing
- No content, metadata, or request details persisted

**ZDR requires:**
- Enterprise/Business API account
- ZDR addendum agreement with Anthropic
- Contact: https://www.anthropic.com/contact-sales

## Sensitive Files

Some files should NOT be processed through this system:

- Passports, government IDs
- Social Security cards/numbers
- Tax returns with full SSN
- Bank account statements with full account numbers
- Medical records (unless HIPAA BAA in place)
- Passwords, private keys, credentials

### Auto-Skip List

Files matching these patterns are automatically moved to `manual-review/` instead of being processed:

```
*passport*
*ssn*
*social_security*
*tax_return*
*w2*
*1099*
*bank_statement*
*private_key*
*credentials*
*.pem
*.key
```

## Local Security

### Recommended:

1. **Enable FileVault** - Full disk encryption (macOS)
   - System Settings → Privacy & Security → FileVault

2. **Restrict folder permissions**
   ```bash
   chmod 700 ~/Desktop/"File Management Clean"
   ```

3. **Don't commit sensitive files** - `.gitignore` excludes user data

### Email Integration

If using email integration:
- Attachments transit through your email provider (Gmail, etc.)
- Use a dedicated triage email, not your primary
- Consider: email contents are not encrypted in transit unless using S/MIME

## Compliance Notes

- **HIPAA**: Requires BAA with Anthropic + ZDR
- **SOC 2**: Anthropic is SOC 2 Type II certified
- **GDPR**: Review Anthropic's DPA for EU data

## Questions?

- Anthropic Privacy Center: https://privacy.anthropic.com
- Claude Code Data Usage: https://docs.anthropic.com/claude-code/docs/data-usage
