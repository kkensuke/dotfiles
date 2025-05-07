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
