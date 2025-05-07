#!/bin/bash

set -e
set -u



# install git-filter-repo
# brew install git-filter-repo

echo "\n⚠️  Caution: You are going to delete all the history of some files and directories from a repository."

echo "\n⚠️  We recommend merging or closing all open pull requests, and removing the files & directories whose history you are going to delete from a remote repository before executing this."

echo "\nInput your GitHub username: "
read username

echo "\nInput your repository name"
read reponame

git clone https://github.com/$username/$reponame.git
cd $reponame

echo "\nSpecify the location of the files or directories from the root of the repository whose history you want to delete, like path/to/file[dir] or path/to/{file1,file2}"

read paths

git filter-repo --invert-paths --path $paths

git remote add origin https://github.com/$username/$reponame.git

git push origin --force --all
git push origin --force --tags

echo "\n✅  Removed all the history of $paths from $reponame"
