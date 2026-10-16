<img width="2056" height="765" alt="Shelly_ Cuervo Neón para Neovim" src="https://github.com/user-attachments/assets/ad2e24e4-f726-4f7c-af2e-cbb0f38c7b86" />

[![Release](https://img.shields.io/endpoint?url=https://raw.githubusercontent.com/Soyagvs/shelly-nvim/main/.github/badges/release.json&style=flat-square)](https://github.com/Soyagvs/shelly-nvim/releases)

# shelly-nvim

Neovim support for [Shelly](https://github.com/Soyagvs/shelly), including filetype support and Shelly Language Server integration.

For canonical helper and date-format details, see the [helper documentation](https://github.com/Soyagvs/shelly/blob/main/docs/helpers.md) and [date-formatting documentation](https://github.com/Soyagvs/shelly/blob/main/docs/date-formatting.md).

## Quick path: Lazy.nvim

1. Install Shelly separately by downloading and installing its release archive from the [Shelly releases](https://github.com/Soyagvs/shelly/releases) page.
2. Make sure both `shelly` and `shelly-lsp` are available on your `PATH`.
3. Add this plugin specification to your Lazy.nvim plugin list:

```lua
{
  "Soyagvs/shelly-nvim",
  lazy = false,
}
```

`lazy = false` is intentional: the plugin must load at startup so Neovim can detect Shelly filetypes.

4. Restart Neovim and open a Shelly file.

You do not need to configure [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig). `shelly-nvim` handles the Shelly LSP integration when `shelly-lsp` is available on `PATH`.

## Verify the installation

Inside Neovim, check the filetype and recent messages:

```vim
:set filetype?
:messages
```

The filetype should be set for an open Shelly file. To verify the language server executable outside Neovim, run:

```sh
shelly-lsp
```

The command should start the server and wait for input; stop it with `Ctrl-C` if you run it interactively. If Neovim cannot start the server, confirm that your shell can find both commands:

```sh
command -v shelly
command -v shelly-lsp
```

## Troubleshooting

- **The filetype is empty or incorrect:** confirm that the plugin is loaded at startup (`lazy = false`), then reopen the file and inspect `:messages`.
- **The language server does not start:** run `command -v shelly-lsp` and `shelly-lsp` in the same environment that launches Neovim. Fix `PATH` before changing Neovim configuration.
- **Shelly or the LSP is outdated:** Shelly updates both components with one command:

  ```sh
  shelly update
  ```

- **You installed a new release but Neovim still uses the old one:** restart Neovim after updating and check the resolved executable with `command -v`.

For Shelly-specific behavior and LSP details, see the [Shelly documentation](https://github.com/Soyagvs/shelly) and the [LSP guide](https://github.com/Soyagvs/shelly/blob/main/docs/lsp.md).

## Manual installation with Neovim's native package loader

If you do not use a plugin manager, clone the repository into Neovim's `start` package directory:

```sh
git clone https://github.com/Soyagvs/shelly-nvim.git ~/.config/nvim/pack/shelly/start/shelly-nvim
```

Then restart Neovim. The same Shelly prerequisite applies: install Shelly's release archive separately and put both `shelly` and `shelly-lsp` on `PATH`.

## Optional icons

`shelly-nvim` does not bundle an SVG, icon font, or icon set. If you already use an icon provider, configure it separately according to that provider's documentation:

- [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons) can be installed and configured through its normal `setup()` call.
- [mini.icons](https://github.com/echasnovski/mini.icons) can be installed and configured through `require("mini.icons").setup()`.

Icons are optional and are not required for filetype detection or the LSP.

## Features

- Shelly filetype detection and syntax support in Neovim.
- Shelly Language Server integration through `shelly-lsp`.
- Works with Lazy.nvim or Neovim's native package loader.

## Requirements

- Neovim with support for the plugin's runtime features.
- Git, when using the manual installation command.
- Shelly installed separately from its release archive.
- Both `shelly` and `shelly-lsp` available on `PATH`.

## License

`shelly-nvim` is free software licensed under the [GNU General Public License v3.0](LICENSE). See [LICENSE](LICENSE) for the full text.
