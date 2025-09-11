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
repotext() { python ~/github/tools/repo_to_text/repo_to_text_CJK.py $1 -o ~/Desktop/output.txt}
text() {cd ~/Desktop; acv; python ~/github/tools/yt_dlp_transcript/yt_dlp_transcript.py $1; deac}
textn() {cd ~/Desktop; acv; python ~/github/tools/yt_dlp_transcript/yt_dlp_transcript.py $1  --no-summary; deac}
calc() { python -c "import math; print($*)"}

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
