#!/bin/sh
set -eu
exec nvim --headless -u NONE -c 'luafile tests/archive-syntax.lua'
