# Editor documentation consistency

## Scope

Keep the Neovim documentation aligned with the shared Shelly editor integrations without changing runtime or release metadata.

## Neovim documentation

- Link from the Neovim README to the [Shelly VS Code integration](https://github.com/Soyagvs/shelly-vscode), alongside the Shelly runtime and LSP documentation links.
- Describe only the shared `shelly-lsp` capabilities verified for this integration: diagnostics, completion, hover, definition, references, document symbols, workspace symbols, and conservative rename.
- Retain the existing note that recursive `**` glob validation is provided by the server and is not expanded by the plugin.

## Boundaries

This consistency update is documentation-only. It does not change runtime/plugin code, source tests, generated files, or release version claims.
