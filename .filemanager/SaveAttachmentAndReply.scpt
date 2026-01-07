-- AppleScript for Apple Mail
-- Saves attachments to triage folder and replies with Claude's response
--
-- Setup:
-- 1. Copy to ~/Library/Application Scripts/com.apple.mail/
-- 2. Create Mail rule: Run AppleScript → SaveAttachmentAndReply.scpt

using terms from application "Mail"
    on perform mail action with messages theMessages for rule theRule
        -- Get paths relative to user's home
        set homeFolder to POSIX path of (path to home folder)
        set baseDir to homeFolder & "Desktop/File Management Clean/"
        set triageFolder to baseDir & "triage/"
        set processScript to baseDir & ".filemanager/process_and_respond.sh"

        repeat with theMessage in theMessages
            set responseText to ""

            set theAttachments to mail attachments of theMessage
            if (count of theAttachments) > 0 then
                repeat with theAttachment in theAttachments
                    set attachmentName to name of theAttachment
                    set attachmentPath to triageFolder & attachmentName

                    try
                        save theAttachment in POSIX file attachmentPath
                        set shellCmd to "'" & processScript & "' '" & attachmentName & "'"
                        set claudeResponse to do shell script shellCmd
                        set responseText to responseText & claudeResponse & return & return
                    on error errMsg
                        set responseText to responseText & "Error: " & errMsg & return & return
                    end try
                end repeat

                set replyMessage to reply theMessage with opening window
                set content of replyMessage to responseText & "---" & return & "File Management System"
                send replyMessage
            end if
        end repeat
    end perform mail action with messages
end using terms from
