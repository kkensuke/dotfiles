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
# make changes -> gacp <branch> <comment>
# delete a merged local&remote branch
gbd() { gch master; gpl; git branch -d "$1"; git push origin :"$1" }
