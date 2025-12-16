# Repository Guidelines

## Project Structure & Module Organization
- `recipes/recipe.yml`: Main BlueBuild recipe (base image, repos, packages, modules).
- `files/system/`: System overlays copied into the image root. Dconf defaults live under `etc/dconf/db/local.d/`.
- `files/scripts/`: Build-time scripts invoked from the recipe (e.g., `update-dconf.sh`).
- `modules/`: Reserved for additional BlueBuild modules (currently empty).
- `recipes/`: Contains the primary recipe; keep new recipes here if you add variants.

## Build & Development Commands
- Build image locally: `bluebuild build recipes/recipe.yml` (produces OCI/ostree image).
- Validate recipe schema: `yq eval . recipes/recipe.yml >/dev/null` or open with YAML LSP.
- Rebase to latest build (from README): `rpm-ostree rebase ostree-image-signed:docker://ghcr.io/boo15mario/access-os:latest`.

## Coding Style & Naming Conventions
- YAML: two-space indent; keep lists compact and sorted when practical.
- Scripts: bash with `set -oue pipefail`; prefer lowercase, hyphenated filenames (e.g., `update-dconf.sh`).
- Paths: keep system overlays under `files/system` matching target paths (e.g., `files/system/etc/...`).

## Testing Guidelines
- No automated tests are defined. For changes to the recipe, run a local `bluebuild build` when possible.
- For dconf or file overlays, ensure target paths exist in the image; add `dconf update` in scripts when adding new keys.

## Commit & Pull Request Guidelines
- Commits: short, imperative subject lines (e.g., “Add Samba packages”, “Set Breeze-Dark as default theme”).
- Group related changes together (recipe edits + scripts + overlays).
- PRs: include what changed, why, and any build/test output (link to GitHub Actions run). Mention image tag impacts if applicable.

## Security & Configuration Tips
- Repos: keep third-party repo URLs explicit in `repos:`; prefer HTTPS.
- Packages: avoid leaving orphaned RPMs; remove unused installer URLs to keep builds clean.
- Credentials: do not commit secrets; dconf and configs should be safe defaults only.
