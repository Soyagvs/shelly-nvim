local registered

package.preload["nvim-web-devicons"] = function()
  return {
    set_icon = function(icons)
      registered = icons
    end,
  }
end

vim.g.loaded_shelly_lsp = nil
dofile("plugin/shelly-lsp.lua")
vim.wait(100, function()
  return registered ~= nil
end)

assert(registered and registered.shelly, "Shelly icon was not registered")
assert(registered.shelly.color == "#c084fc", "Shelly icon must be purple")
assert(registered.shelly.cterm_color == "13", "Shelly icon must use the purple terminal color")
