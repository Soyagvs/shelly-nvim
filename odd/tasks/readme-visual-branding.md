# README visual branding

## Scope
- Preserve every existing README image and its source URL.
- Refresh README presentation in `shelly-nvim` with green visual accents.
- Refresh README presentation in `shelly-vscode` with blue visual accents.
- Align release and downloads badge colors with each repository's theme.

## Tasks
- [x] 1. Map the existing visual structure and choose minimal, image-preserving markup.
  - Evidence: retain the hero image; use centered badge/link groups and a text divider. Theme color is carried by badge endpoint JSON.
- [x] 2. Apply the green README and badge treatment to `shelly-nvim`.
  - Evidence: worker structural check passed; hero image and URLs preserved; `#2ea44f` applied to both badges.
- [x] 3. Apply the blue README and badge treatment to `shelly-vscode`.
  - Evidence: worker structural check passed; hero image and URLs preserved; `#2563EB` applied to both badges.
- [x] 4. Structurally verify that images, links, and badge endpoints remain intact.
  - Evidence: independent verifier confirmed both hero images, release/download endpoint URLs, and release links; `git diff --check` passed in both repositories.

## Evidence
- No implementation commits yet (commit/push not requested for this change).
