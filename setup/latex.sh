#!/bin/bash

set -e
set -u


mkdir ~/install-latex && cd ~/install-latex

# Download install-tl-unx.tar.gz
curl -OL http://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz

# Open install-tl-unx.tar.gz
tar xvf install-tl-unx.tar.gz

# Install TexLive
cd install-tl-2*
sudo ./install-tl -no-gui -repository http://mirror.ctan.org/systems/texlive/tlnet/

# Add a symbolic link to /usr/local/bin
sudo /usr/local/texlive/????/bin/*/tlmgr path add

rm -rf ~/install-latex