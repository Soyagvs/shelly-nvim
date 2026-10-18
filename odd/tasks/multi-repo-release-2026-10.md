# shelly-nvim v0.1.2 release

Feature: document the approved `v0.1.2` release for the Shelly Neovim plugin.

## Decisions

- Release `v0.1.2` from the current main branch.
- Preserve the existing README guidance for `shelly-lsp` and recursive `**` file globs.
- Do not attach binary assets: Neovim plugin managers install the tagged Git repository directly.
- Publish the release from the current `main` branch without binary assets; plugin managers install the tagged repository directly.

## User-facing changes

- Shelly regex literals are highlighted as strings.
- The `matches` predicate is highlighted as a Shelly predicate.
- README guidance clarifies that recursive file-glob diagnostics, completion, and validation come from `shelly-lsp`.

## Tasks

- [x] Add the `v0.1.2` changelog entry.
- [x] Preserve and review the existing README release guidance.
- [x] Tag `v0.1.2`, push `main`, and publish the GitHub release.

## Evidence

- Committed on `main`: `60889f7` (`feat(syntax): highlight regex predicates`).
- Published release on 2026-10-18: https://github.com/Soyagvs/shelly-nvim/releases/tag/v0.1.2
