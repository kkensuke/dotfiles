alias python='python3' # for git_super_status
alias wpy='which python3'

alias pip='pip3'
alias pin='pip install'
alias puin='pip uninstall'
alias pf='pip list --format=freeze'
alias pfr='pip list --format=freeze > requirements.txt'

# venv
alias acv='source ~/venv/bin/activate'
alias deac='deactivate'


mkuv() {
    if [ -z "$1" ]; then
        echo "Usage: mkuv <project_name>"
        return 1
    fi
    
    local project_name="$1"
    local venv_dir="$HOME/venvs/$project_name"
    local project_dir="./$project_name"
    
    # Check if project directory already exists
    if [ -d "$project_dir" ]; then
        echo "Error: Directory '$project_dir' already exists."
        return 1
    fi
    
    # Check if venv directory already exists
    if [ -d "$venv_dir" ]; then
        echo "Error: venv directory '$venv_dir' already exists."
        return 1
    fi
    
    # Create ~/venvs/ directory if it doesn't exist
    mkdir -p "$HOME/venvs"
    
    # Create venv
    echo "Creating venv at $venv_dir..."
    uv venv "$venv_dir"
    
    # Create project (directory is automatically created)
    echo "Initializing uv project..."
    uv init "$project_name"
    
    # Move to project directory
    cd "$project_name"
    
    # Create symlink
    echo "Creating symlink to venv..."
    ln -s "$venv_dir" .venv
    
    mkdir -p notebooks
    
    echo "✓ Project '$project_name' created successfully!"
    echo "  - venv: $venv_dir"
    echo "  - project: $PWD"
}


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
  source ~/venvs/yt_dlp/bin/activate || { echo "activating venv failed"; return 1; }

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