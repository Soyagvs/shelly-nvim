# shelly-nvim v0.1.2 release

Feature: document the approved `v0.1.2` release for the Shelly Neovim plugin.

## Decisions

- Release `v0.1.2` from the current main branch.
- Preserve the existing README guidance for `shelly-lsp` and recursive `**` file globs.
- Do not attach binary assets: Neovim plugin managers install the tagged Git repository directly.
- Keep release operations separate from this documentation change; tagging, publishing, and pushing are not performed here.

## User-facing changes

- Shelly regex literals are highlighted as strings.
- The `matches` predicate is highlighted as a Shelly predicate.
- README guidance clarifies that recursive file-glob diagnostics, completion, and validation come from `shelly-lsp`.

## Tasks

- [x] Add the `v0.1.2` changelog entry.
- [x] Preserve and review the existing README release guidance.
- [ ] Tag `v0.1.2` and publish the GitHub release separately.
