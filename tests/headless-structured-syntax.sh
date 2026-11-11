#!/bin/sh
set -eu
exec nvim --headless -u NONE -c 'luafile tests/structured-syntax.lua'
