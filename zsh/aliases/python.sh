alias python='python3' # for git_super_status
alias wpy='which python3'

alias pip='pip3'
alias pin='pip install'
alias puin='pip uninstall'
alias pup='pip install --upgrade pip'
alias pinreq='pip install -r requirements.txt'
alias pf='pip list --format=freeze'
alias pfr='pip list --format=freeze > requirements.txt'

# venv
alias mkv='python3 -m venv venv; source ./venv/bin/activate'
alias acv='source ~/venv/bin/activate'
alias deac='deactivate'

# jupyterlab
alias jl='jupyter-lab'
alias opj='fire ~/My\ Drive/app/github/jupyterbook/myjb/_build/html/index.html'

# tools
calc() { python -c "import math; print($*)"}
repotext() { python ~/github/tools/repo_to_text/repo_to_text_CJK.py $1 -o ~/Desktop/output.txt}
text() {
  if [ $# -lt 2 ]; then
    echo "Usage: text {en|ja|no} URL"
    return 2
  fi

  lang="$1"; shift
  url="$*"

  cd ~/Desktop
  acv || { echo "activating venv failed"; return 1; }

  case "$lang" in
    en) opts=(--summary-lang en) ;;
    ja) opts=(--summary-lang ja) ;;
    no) opts=(--no-summary) ;;
    *) echo "Unknown option: $lang"; echo "Usage: text {en|ja|no} URL"; deac; return 2 ;;
  esac

  python ~/github/tools/yt_dlp_transcript/yt_dlp_transcript.py "$url" "${opts[@]}"
  rc=$?

  deac
  return $rc
}


# build and publish jupyter-book
jbg(){
    cd ~/My\ Drive/app/github/jb-public/"$1"/
    jb build --all .
    gacpm add
    ghp-import -n -p -f _build/html
}


mkpc(){
    mkc "$1"
    mkdir -p {src,data,notebooks,tests,results,docs}
    touch {README.md,.gitignore}
}
