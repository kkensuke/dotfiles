#!/usr/bin/env bash
set -euo pipefail

# This script might not be compatible with the Cryptomator GUI app.

# config - adjust these
CLI_BIN="/Applications/cryptomator-cli.app/Contents/MacOS/cryptomator-cli"
MOUNT_POINT="$HOME/cryptomator-mounts"
MOUNTER="org.cryptomator.frontend.fuse.mount.FuseTMountProvider"
VAULT_NAME=$(basename "$VAULT_DIR1")

# Check if vault is already mounted
if [ -d "${MOUNT_POINT}/${VAULT_NAME}" ]; then
    echo "\n✅ Vault is already mounted!\n"
    echo "🚀 Opening vault in VS Code...\n"
    code "${MOUNT_POINT}/${VAULT_NAME}"
    echo "💡 To unmount when done: umount \"${MOUNT_POINT}\""
    exit 0
fi


read -r -s -p "Password: " PASSWORD
export PASSWORD
echo ""

echo "🔓 Mounting vault...\n"
# unlock in background
echo "${PASSWORD}" | "${CLI_BIN}" unlock \
  --password:stdin \
  --mounter="${MOUNTER}" \
  --mountPoint="${MOUNT_POINT}" \
  "${VAULT_DIR1}" &

sleep 1

# Wait for mount to be ready
echo "⏳ Waiting for vault to mount...\n"
for i in {1..10}; do
    if [ -d "${MOUNT_POINT}/${VAULT_NAME}" ]; then
        echo "\n✅ Vault mounted successfully!\n"
        echo "🚀 Opening vault in VS Code...\n"
        code "${MOUNT_POINT}/${VAULT_NAME}"
        echo "💡 Vault is now open. To unmount when done:\n"
        echo "        umount \"${MOUNT_POINT}\""
        exit 0
    fi
    sleep 1
done

unset PASSWORD

echo "❌ Timeout waiting for vault to mount"
exit 1