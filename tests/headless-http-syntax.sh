#!/bin/sh
set -eu
exec nvim --headless -u NONE -c 'luafile tests/http-syntax.lua'
