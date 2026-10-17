# Contributing to shelly-nvim

A short path for changes to Shelly's Neovim filetype support, syntax highlighting, and language-server integration.

## Quick path

1. Install Neovim and Git. Install Shelly separately when testing the language server.
2. Clone this repository and add it to Neovim's runtime path, or load it with your usual plugin manager.
3. Make the smallest change in the matching runtime area below.
4. Run the automated headless check.
5. Complete the manual checklist before opening a pull request.

## Scope map

| Path | Owns | Change it when |
| --- | --- | --- |
| `ftdetect/` | Detects `*.shelly` buffers and assigns the `shelly` filetype. | Filetype detection or filename patterns change. |
| `ftplugin/` | Buffer-local Shelly editing behavior, including comments, keywords, and suffixes. | Editing defaults change. |
| `syntax/` | Shelly syntax regions, tokens, and highlight links. | Shelly grammar or highlighting changes. |
| `lua/` | Optional integrations, such as icon-provider helpers. | Lua APIs or optional integration behavior changes. |
| `plugin/` | Startup-loaded plugin behavior, including Shelly LSP attachment. | The plugin's global startup or LSP behavior changes. |

Keep changes in the narrowest applicable area. Coordinate language or protocol changes with the [Shelly repository](https://github.com/Soyagvs/shelly); this plugin does not define the Shelly language or language-server protocol.

## Prerequisites

- Neovim
- Git (for cloning or manual installation)
- Shelly installed separately when testing LSP behavior
- Both `shelly` and `shelly-lsp` on `PATH` for end-to-end LSP verification

The optional icon integrations are not required for filetype, syntax, or LSP work.

## Setup

Use your normal plugin manager, or install with Neovim's native package loader:

```sh
git clone https://github.com/Soyagvs/shelly-nvim.git ~/.config/nvim/pack/shelly/start/shelly-nvim
```

Restart Neovim after setup. For a local checkout, run the automated check from the repository root.

## Verification

### Automated: headless syntax check

Run this from the repository root:

```sh
nvim --headless -u NONE -c 'set rtp^=.' -c 'syntax on' -c 'new' -c 'set ft=shelly' -c 'qa'
```

A successful run exits without output or an error. This checks that Neovim can load the plugin runtime and Shelly syntax in a headless session; it does not start the language server.

### Manual: practical checklist

Use a real `*.shelly` file in a normal Neovim session:

- [ ] **Filetype:** run `:set filetype?`; it reports `filetype=shelly`.
- [ ] **Syntax:** run `:syntax list`; expected Shelly groups are present and representative keywords, strings, comments, variables, and numbers are highlighted.
- [ ] **LSP:** with `shelly-lsp` on `PATH`, open the file and confirm the expected client attaches. Check the client/status UI provided by your Neovim setup and exercise a basic language-server action when available.
- [ ] **Messages:** run `:messages`; there are no unexpected plugin or LSP startup errors.
- [ ] **Regression:** reopen the file after changing buffers and confirm filetype, syntax, and LSP behavior remain stable.

If `shelly-lsp` is unavailable, report that limitation rather than treating LSP verification as complete. Confirm executable resolution with:

```sh
command -v shelly
command -v shelly-lsp
```

## Cross-repository compatibility

Shelly syntax and the Shelly language server are maintained in the [Shelly repository](https://github.com/Soyagvs/shelly). When a change depends on a language or protocol change:

- identify the corresponding Shelly version or change;
- test the plugin against the intended Shelly release;
- keep syntax and LSP behavior aligned with the same contract; and
- link the related Shelly issue or pull request.

Do not silently introduce plugin assumptions that only work with an unreleased Shelly change.

## Issue and pull-request checklist

- [ ] Explain the user-visible behavior and the smallest affected scope.
- [ ] Identify the relevant path area (`ftdetect`, `ftplugin`, `syntax`, `lua`, or `plugin`).
- [ ] Include a minimal Shelly example or reproduction when behavior is syntax-related.
- [ ] State whether automated and manual checks were run; include limitations.
- [ ] For LSP changes, include the Shelly version and `shelly-lsp` availability.
- [ ] Keep unrelated formatting, runtime, workflow, and documentation changes out of the patch.

## Maintainer-only release boundary

Contributors may propose and review changes, but release operations are maintainer-only. Maintainers decide release versions and perform release preparation, tagging, and publishing. Do not create tags or publish releases from a contribution branch.

## License

Contributions to `shelly-nvim` are made under the [GNU General Public License v3.0 or later](LICENSE) (`GPL-3.0-or-later`).
