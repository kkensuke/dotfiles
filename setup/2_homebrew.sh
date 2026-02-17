#!/bin/bash

set -e
set -u


# Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# reload
exec ${SHELL} -l
