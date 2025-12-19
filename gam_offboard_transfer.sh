#!/usr/bin/env bash
set -euo pipefail

if [[ $# -lt 3 ]]; then
  echo "Usage: $0 departing_user@domain.com manager@domain.com 'TempPassw0rd!' [target_folder_name]"
  echo "Example: $0 jdoe@acme.com manager@acme.com 'TempPassw0rd!'"
  exit 1
fi

DEPARTING="$1"
MANAGER="$2"
TEMP_PASS="$3"
TARGET_FOLDER_NAME="${4:-}"

TS="$(date +"%Y%m%d-%H%M%S")"
LOG_DIR="./gam_offboarding_logs"
mkdir -p "$LOG_DIR"
LOG_FILE="$LOG_DIR/offboard_${DEPARTING}_${TS}.log"

exec > >(tee -a "$LOG_FILE") 2>&1

echo "== Offboarding started =="
echo "Departing: $DEPARTING"
echo "Manager:   $MANAGER"
echo "Log:       $LOG_FILE"
echo

# 1) Reset password + force change on next login
# Force change documented: gam update user <email> changepassword on :contentReference[oaicite:8]{index=8}
echo "==> Resetting password + forcing change on next login..."
gam update user "$DEPARTING" password "$TEMP_PASS"
gam update user "$DEPARTING" changepassword on

# 2) Delegate mailbox access to manager
# Documented: gam user departing add delegate manager :contentReference[oaicite:9]{index=9}
echo "==> Adding Gmail delegate (manager gets mailbox access)..."
gam user "$DEPARTING" add delegate "$MANAGER"

# 3) Transfer Drive files to manager
# Documented: Users Drive Transfer supports targetfoldername and default "#user# old files" :contentReference[oaicite:10]{index=10}
echo "==> Transferring Drive files to manager..."
if [[ -n "$TARGET_FOLDER_NAME" ]]; then
  gam user "$DEPARTING" transfer drive "$MANAGER" targetfoldername "$TARGET_FOLDER_NAME"
else
  # Uses default folder naming (#user# old files) if not specified. :contentReference[oaicite:11]{index=11}
  gam user "$DEPARTING" transfer drive "$MANAGER"
fi

echo
echo "== Offboarding transfer complete =="
echo "Next checks you should do:"
echo "  - Confirm manager can access delegated mailbox (Gmail UI / account selection). Delegation must be enabled in OU settings. :contentReference[oaicite:12]{index=12}"
echo "  - Confirm Drive files show up under the manager's Drive in the created folder. :contentReference[oaicite:13]{index=13}"
