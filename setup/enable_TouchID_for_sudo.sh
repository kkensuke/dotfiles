#!/bin/sh

#　Enable TouchID for sudo

cd /etc/pam.d

sudo tee -a sudo_local >/dev/null <<'EOF'
# sudo_local: local config file which survives system update and is included for sudo
# uncomment following line to enable Touch ID for sudo
auth       sufficient     pam_tid.so
EOF
