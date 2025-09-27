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
you() {
  if [ $# -lt 1 ]; then
    echo "Usage: you [lang] URL"
    echo "  lang: en|ja|no|auto (default: auto)"
    return 2
  fi

  # If only one argument, treat it as URL with auto language
  if [ $# -eq 1 ]; then
    lang="auto"
    url="$1"
  else
    # Two or more arguments: first is language, rest is URL
    lang="$1"; shift
    url="$*"
  fi

  cd ~/Desktop
  source ~/venv_ytdlp/bin/activate || { echo "activating venv failed"; return 1; }

  case "$lang" in
    en) opts=(--summary-lang en) ;;
    ja) opts=(--summary-lang ja) ;;
    no) opts=(--no-summary) ;;
    auto) opts=(--summary-lang auto) ;;
    *) echo "Unknown option: $lang"; echo "Usage: you [lang] URL"; echo "  lang: en|ja|no|auto (default: auto)"; deac; return 2 ;;
  esac

  python ~/github/tools/yt_dlp_transcript/all.py "$url" "${opts[@]}"
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
