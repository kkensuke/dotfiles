# macOS Initial Setup Instructions

## 1. Account and Cloud Setup
1. Sign in to **iCloud**.
2. Install **Google Chrome** via Safari.
3. Install **Google Drive**.
   * Note: It may be preferable to use **iCloud Drive** instead of Google Drive for better system integration.
4. Register and set up **Gmail**.

## 2. Development Environment Setup
1. Execute `xcode.sh` to install Xcode command line tools (`xcode-select --install`).
2. Execute `brew.sh` for Homebrew package installations.
3. Execute `mac.sh` and `lns.sh`.

## 3. System Preferences
* **Dock:** Adjust according to preference.
* **Trackpad:** Set tracking speed to maximum.
* **Keyboard:**
  * Set input source to **only** `Japanese - Romaji`.
  * Map the `¥` (Yen) key to backslash (`\`).

## 4. Zsh Configuration
Occasionally, the following error may occur when initializing `zsh`:
```
zsh compinit: insecure directories, run compaudit for list.
Ignore insecure directories and continue [y] or abort compinit [n]? compauditcompinit: initialization aborted
```

Resolution:
1. Run:`compaudit` to list directories in problems.
2. For each directory listed, update permissions. For example:
   ```bash
   chmod 755 /opt/homebrew/share
   ```