#!/bin/sh
set -eu
exec nvim --headless -u NONE -c 'luafile tests/custom-command.lua'
