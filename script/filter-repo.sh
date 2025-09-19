#!/usr/bin/env bash
set -euo pipefail

# --- Configuration ---
DEFAULT_REPO_URL="" # Leave empty to force user input
DEFAULT_PATHS_TO_REMOVE="" # e.g., "path/to/secret,*.log,folder/**"

# --- Helper Functions ---
print_caution() {
  echo
  echo "-----------------------------------------------------------------------------"
  echo "⚠️  CAUTION: This script irreversibly rewrites Git history!"
  echo "-----------------------------------------------------------------------------"
  echo "‼️  BEFORE YOU RUN THIS SCRIPT, YOU MUST:"
  echo "-----------------------------------------------------------------------------"
  echo "• BACK UP YOUR REPOSITORY: Create a full backup mirror to a SEPARATE remote."
  echo "  (e.g., git push --mirror git@backupserver:user/repo-backup.git)"
  echo "• NOTIFY COLLABORATORS: Instruct everyone to push all their current work"
  echo "  (branches, tags) and then PAUSE ALL COMMITS AND PUSHES until the"
  echo "  rewrite is complete and they finish updating their local repositories."
  echo

  echo "-----------------------------------------------------------------------------"
  echo "⚙️  HOW THIS SCRIPT WORKS & RECOMMENDED USAGE:"
  echo "-----------------------------------------------------------------------------"
  echo "• CLONES FRESHLY: It operates on a fresh '--mirror' clone to ensure all"
  echo "  refs (branches, tags, notes) are included in the rewrite."
  echo "• OFFERS DRY-RUN: It will offer a '--dry-run' to preview changes"
  echo "  before any irreversible modifications are made."
  echo "  (This script will prompt you for this)."
  echo

  echo "-----------------------------------------------------------------------------"
  echo "✅ AFTER THE REWRITE IS COMPLETE AND PUSHED:"
  echo "-----------------------------------------------------------------------------"
  echo "• NOTIFY COLLABORATORS AGAIN: Inform them the rewrite is done."
  echo "• INSTRUCT COLLABORATORS TO UPDATE THEIR LOCAL REPOS:"
  echo "  The safest way for collaborators to update is to re-clone the repository."
  echo "  Alternatively, for those comfortable with more advanced Git operations:"
  echo "    1. Fetch all updated refs: git fetch origin --prune"
  echo "    2. Reset their local main/master branch:"
  echo "       git checkout main # (or your default branch)"
  echo "       git reset --hard origin/main"
  echo "    3. Rebase any local feature branches onto the new main/master:"
  echo "       git checkout my-feature-branch"
  echo "       git rebase main # (or origin/main)"
  echo "    4. Force-push rebased feature branches if they were previously pushed:"
  echo "       git push --force-with-lease origin my-feature-branch"
  echo "• PROTECT THE MAIN BRANCH: Consider temporarily protecting your main branch"
  echo "  on the remote to prevent accidental pushes of old history if someone misses"
  echo "  the notification."
  echo "-----------------------------------------------------------------------------"
  echo
}

cleanup() {
  if [[ -n "${WORK_DIR:-}" && -d "$WORK_DIR" ]]; then
    echo "Cleaning up temporary directory: $WORK_DIR"
    rm -rf "$WORK_DIR"
  fi
}

# Builds the argument list for git-filter-repo
# Usage: build_filter_repo_args "path1,path2,*.log"
# Populates the global array FILTER_REPO_ARGS
build_filter_repo_args() {
  local raw_paths_str="$1"
  local -a items
  IFS=',' read -ra items <<< "$raw_paths_str"

  FILTER_REPO_ARGS=(--invert-paths) # Reset and initialize
  if ((${#items[@]} == 0)); then
    echo "❌ No paths provided for filtering." >&2
    return 1
  fi

  for p in "${items[@]}"; do
    # Trim whitespace (if any, though IFS should handle most)
    p_trimmed=$(echo "$p" | xargs) # Simple trim
    if [[ -z "$p_trimmed" ]]; then
      continue # Skip empty paths that might result from ",," or trailing comma
    fi
    if [[ "$p_trimmed" == *"*"* || "$p_trimmed" == *"{"* || "$p_trimmed" == *"?"* ]]; then
      FILTER_REPO_ARGS+=(--path-glob "$p_trimmed")
    else
      FILTER_REPO_ARGS+=(--path "$p_trimmed")
    fi
  done
  return 0
}

# --- Main Script ---
trap cleanup EXIT SIGINT SIGTERM

print_caution

# 1. Check prerequisites
if ! command -v git-filter-repo >/dev/null 2>&1; then
  echo "❌ git-filter-repo not found. Install it first (e.g., using pip, brew, etc.)."
  echo "   See: https://github.com/newren/git-filter-repo/#how-do-i-install-it"
  exit 1
fi

# 2. Gather user input (with defaults or command-line overrides)
REPO_URL="${1:-$DEFAULT_REPO_URL}"
PATHS_TO_REMOVE="${2:-$DEFAULT_PATHS_TO_REMOVE}" # Comma-separated

if [[ -z "$REPO_URL" ]]; then
  read -rp "Enter the full Git repository URL (e.g., https://github.com/user/repo.git): " REPO_URL
fi
if [[ -z "$REPO_URL" ]]; then
  echo "❌ Repository URL cannot be empty. Exiting."
  exit 1
fi

# Extract repo name for directory, more robustly
REPO_BASENAME=$(basename "$REPO_URL" .git)

if [[ -z "$PATHS_TO_REMOVE" ]]; then
  echo
  echo "Enter files or directories to remove (comma-separated):"
  echo "  e.g. 'path/to/secret,*.log,folder/**'"
  read -rp "> " PATHS_TO_REMOVE
fi
if [[ -z "$PATHS_TO_REMOVE" ]]; then
  echo "❌ No paths provided to remove. Exiting."
  exit 1
fi

# 3. Create a temporary working directory and clone mirror
WORK_DIR=$(mktemp -d -t git-filter-repo-XXXXXX)
echo
echo "Created temporary working directory: $WORK_DIR"
CLONE_DIR="${WORK_DIR}/${REPO_BASENAME}.git"

echo "Cloning repository '$REPO_URL' as a mirror into '$CLONE_DIR'…"
if ! git clone --mirror "$REPO_URL" "$CLONE_DIR"; then
  echo "❌ Failed to clone repository. Check URL and permissions."
  exit 1
fi
cd "$CLONE_DIR"

# 4. Build filter-repo args (for dry-run and actual run)
declare -a FILTER_REPO_ARGS # Ensure it's an array
if ! build_filter_repo_args "$PATHS_TO_REMOVE"; then
  exit 1 # build_filter_repo_args would have printed an error
fi

# 5. Offer a dry-run first
echo
echo "Running a dry-run to preview changes with args: ${FILTER_REPO_ARGS[*]}"
echo "Command: git filter-repo --dry-run ${FILTER_REPO_ARGS[*]}"
if ! git filter-repo --dry-run "${FILTER_REPO_ARGS[@]}"; then
  echo "❌ Dry-run failed. Please check the paths and error messages."
  # Consider not exiting here, let user decide if they saw enough or want to proceed with caution
  read -rp "Dry-run encountered issues. Continue with irreversible rewrite anyway? [y/N]: " confirm_risky
  if [[ "$confirm_risky" != "y" ]]; then
    echo "Aborting due to dry-run issues."
    exit 1
  fi
else
  echo "✅ Dry-run completed. Review the output above."
fi


echo
read -rp "Proceed with irreversible rewrite of '$REPO_URL'? [y/N]: " confirm
if [[ "$confirm" != "y" ]]; then
  echo "Aborting without changes."
  exit 0 # Clean exit, cleanup trap will run
fi

# 6. Run filter-repo
echo
echo "Running git filter-repo ${FILTER_REPO_ARGS[*]} …"
if ! git filter-repo "${FILTER_REPO_ARGS[@]}"; then
  echo "❌ git-filter-repo command failed. History not rewritten."
  exit 1
fi

# 7. Push rewritten history back
echo
echo "Force-pushing new history to origin (source: '$REPO_URL')..."
# Note: 'origin' is the default remote name set up by 'git clone --mirror'
if ! git push --force --tags origin 'refs/*:refs/*'; then
  echo "❌ Failed to push rewritten history. The local mirror clone at '$CLONE_DIR' has been rewritten,"
  echo "   but the remote '$REPO_URL' has NOT been updated."
  echo "   You may need to resolve this manually (e.g., check permissions, network, or remote state)."
  exit 1
fi

echo
echo "✅ Successfully removed paths matching [${PATHS_TO_REMOVE}] from history of '$REPO_URL'"
echo "   and force-pushed to origin."
echo "   Temporary directory '$WORK_DIR' will be cleaned up."

# Cleanup will be handled by the trap
exit 0