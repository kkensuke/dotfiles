#!/bin/bash
#  <xbar.title>Mail</xbar.title>
#  <xbar.desc>Show unread count from Mail.app in menubar (with Open Mail option)</xbar.desc>
#  <xbar.dependencies>bash,osascript,open</xbar.dependencies>
set -e

# get unread count (fall back to 0 if empty)
OUTPUT=$(osascript -e 'tell application "Mail"' -e 'unread count of inbox' -e 'end tell')
OUTPUT=${OUTPUT:-0}

echo -n "📥"
echo " ${OUTPUT}"

echo "---"

if [[ $OUTPUT -gt 0 ]]
then
  echo "Open Mail | bash=/usr/bin/open param1=-a param2=Mail terminal=false"
else
  echo "No unread mail"
fi
