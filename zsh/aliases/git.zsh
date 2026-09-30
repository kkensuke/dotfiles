alias g='git'
alias ga='git add'
alias gb='git branch'
alias gcm='git commit'
alias gcmm='git commit -m'
alias gch='git checkout'
alias gchm='git checkout main'
alias gcl='git clone'
alias gd='git diff'
alias gf='git fetch'
alias gin='git init'
alias gm='git merge'
alias gpl='git pull'
alias gps='git push'
alias gpo='git push origin'
alias gpom='git push origin main'
alias gst='git status'

# Open the current repository in the browser
alias repo='gh repo view --web'

# EMOJI-LOG (https://github.com/ahmadawais/Emoji-Log)
# See more in .gitmessage
gacpm() { git add -A && git commit -m "$1" && git push origin main }
gacp() { git add -A && git commit -m "$2" && git push origin "$1" }

gnew() { gacpm "✨ NEW: $@" }
gimp() { gacpm "👌 IMPROVE: $@" }
gprg() { gacpm "🚧 PROGRESS: $@" }

gmtn() { gacpm "🔧 MAINTAIN: $@" }
gfix() { gacpm "🐛 FIX: $@" }
ghot() { gacpm "🚑 HOTFIX: $@" }
gbrk() { gacpm "‼️ BREAKING: $@" }
grem() { gacpm "🗑️ REMOVE: $@" }

gmrg() { gacpm "🔀 MERGE: $@" }
gref() { gacpm "♻️ REFACTOR: $@" }
gtst() { gacpm "🧪 TEST: $@" }
gdoc() { gacpm "📚 DOC: $@" }
grls() { gacpm "🚀 RELEASE: $@" }
gsec() { gacpm "👮 SECURITY: $@" }

# Show commit type
gty() {
NORMAL='\033[0;39m'
GREEN='\033[0;32m'
echo "$GREEN gnew$NORMAL — ✨ NEW
$GREEN gimp$NORMAL — 👌 IMPROVE
$GREEN gprg$NORMAL — 🚧 PROGRESS
$GREEN gmtn$NORMAL — 🔧 MAINTAIN
$GREEN gfix$NORMAL — 🐛 FIX
$GREEN ghot$NORMAL — 🚑 HOTFIX
$GREEN gbrk$NORMAL — ‼️  BREAKING
$GREEN grem$NORMAL — 🗑️  REMOVE
$GREEN gmrg$NORMAL — 🔀 MERGE
$GREEN gref$NORMAL — ♻️  REFACTOR
$GREEN gtst$NORMAL — 🧪 TEST
$GREEN gdoc$NORMAL — 📚 DOC
$GREEN grls$NORMAL — 🚀 RELEASE
$GREEN gsec$NORMAL — 👮 SECURITY"
}


# make a new repository based on the current directory
# $1 = private or public
ginit() {
    git init
    git add .
    git commit -m "🎉 Initial commit"
    gh repo create --"$1" --source=. --push
}

# gitignore.io
function gi() { curl -sLw n https://www.toptal.com/developers/gitignore/api/$@ ;}

# make a branch and checkout to it
gcb() { git checkout -b "$1"; git push origin "$1" }



check-repo-status() {
  emulate -L zsh

  local root="${1:-.}" gitpath repo branch upstream state
  local -i total=0 ok=0 dirty ahead behind

  while IFS= read -r -d '' gitpath; do
    repo="${gitpath:h}"
    (( total++ ))

    branch=$(git -C "$repo" symbolic-ref --short -q HEAD 2>/dev/null) ||
      branch=DETACHED
    upstream=$(git -C "$repo" rev-parse --abbrev-ref '@{u}' 2>/dev/null)

    dirty=$(git -C "$repo" status --porcelain 2>/dev/null | wc -l)
    state=""
    (( dirty )) && state="✚$dirty"

    if [[ -z "$upstream" ]]; then
      state+="${state:+,}NO-UPSTREAM"
    else
      read behind ahead <<< "$(
        git -C "$repo" rev-list --left-right --count "$upstream...HEAD"
      )"
      (( ahead ))  && state+="${state:+,}↑$ahead"
      (( behind )) && state+="${state:+,}↓$behind"
    fi

    [[ -n "$state" ]] &&
      print -r -- "${repo/#$HOME/~} % ($branch|$state)" ||
      (( ok++ ))
  done < <(
    find "$root" \
      \( -name .git -o -name node_modules -o -name .venv \) \
      -prune -name .git -print0
  )

  print "\n✔ $ok / $total"
}

crs() {
  check-repo-status ~/github
}