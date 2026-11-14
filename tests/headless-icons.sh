#!/bin/sh
set -eu
exec nvim --headless -u NONE -c 'set rtp^=.' -c 'luafile tests/icons.lua' -c 'qa!'
