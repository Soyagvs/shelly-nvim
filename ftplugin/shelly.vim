" Shelly filetype settings
if exists("b:did_shelly_ftplugin")
  finish
endif
let b:did_shelly_ftplugin = 1

setlocal commentstring=#\ %s\ #
setlocal comments=s1:#,mb:*,ex:#
setlocal iskeyword+=-,>
setlocal suffixesadd=.shelly

let b:undo_ftplugin = "setlocal commentstring< comments< iskeyword< suffixesadd<"
