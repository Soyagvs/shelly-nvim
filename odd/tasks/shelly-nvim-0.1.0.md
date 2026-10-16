# shelly-nvim v0.1.0 release

Feature: publish the first stable GitHub release for the standalone Shelly Neovim plugin.

## Decisions

- Release `v0.1.0` from the verified main-equivalent plugin implementation.
- Do not attach binary assets: Neovim plugin managers install the tagged Git repository directly.
- The release establishes a stable version for Lazy.nvim users and activates the release badge.

## Tasks

- [x] Verify the release candidate and repository state.
- [x] Commit release tracking, tag `v0.1.0`, push, and publish the GitHub release.

## Evidence

- `git diff --check` passed; required runtime layout, GPL license, Lazy.nvim setup, and badge workflow/payloads exist.
- Neovim `v0.12.4` headless verification detected a `.shelly` buffer as `filetype=shelly`.
- Published `v0.1.0`: <https://github.com/Soyagvs/shelly-nvim/releases/tag/v0.1.0>; tag resolves to `8835bc4f90be3a8c3fc0b0622fce790428cf7aca`.
- The repaired release-badge workflow ran successfully and updated the release badge to `v0.1.0`.
