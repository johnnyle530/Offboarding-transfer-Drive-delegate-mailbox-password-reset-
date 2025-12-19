# 🔐 GAM Google Workspace Offboarding Automation Script

## Overview

This script automates **secure user offboarding** in Google Workspace using **GAMADV-XTD3**.

It ensures that when an employee leaves:

* Their data is preserved
* Their manager has access to what they need
* The account is secured immediately

This removes manual steps, reduces risk, and saves IT time.

---

## What This Script Does

* Resets the user’s password
* Forces password change at next login
* Delegates Gmail access to the user’s manager
* Transfers Google Drive files to the manager
* Logs all actions for audit purposes

---

## Why This Matters (Security + Operations)

* Prevents unauthorized access after termination
* Ensures business continuity
* Reduces human error during offboarding
* Creates a **repeatable, auditable process**
* Saves IT bandwidth during high-turnover periods

---

## Requirements

* Google Workspace Admin account
* **GAMADV-XTD3** installed and authenticated
* Gmail delegation enabled for the user’s OU
* Bash shell (macOS or Linux)

---

## How to Run

```bash
chmod +x gam_offboard_transfer.sh
./gam_offboard_transfer.sh departing@company.com manager@company.com 'TempPassw0rd!'
```

Optional custom folder name:

```bash
./gam_offboard_transfer.sh departing@company.com manager@company.com 'TempPassw0rd!' "Former Employee Files"
```

---

## What Gets Logged

All actions are logged to:

```
./gam_offboarding_logs/
```

This is useful for:

* Security audits
* HR documentation
* Compliance reviews
* Incident investigations

---

## Example Use Case

> HR submits a termination ticket.
> IT runs this script and completes offboarding in under 60 seconds without missing a step.

---

## Best Practices

* Run this script **before** suspending or deleting the user
* Confirm Gmail delegation is enabled for the OU
* Rotate temporary passwords after confirmation
* Combine with license removal for full offboarding

---

## Future Enhancements

* Automatically suspend the user after transfer
* Remove licenses post-transfer
* Revoke OAuth tokens
* Notify IT or HR via Slack
* Integrate with Jira or Okta workflows

---

## Key Skills Demonstrated

* Secure offboarding workflows
* Google Workspace administration
* Data ownership transfers
* Automation for compliance
* Real-world IT operations
