# Troubleshooting

## `studioctl launch <id>` says not installed

Expected in the scaffold. Run `studioctl info <id> --json` to see accepted installation methods and
`studioctl doctor --json` to see what is present. In this foundation no binaries are bundled.

## Doctor reports missing paths

Run `./scripts/repair.sh --dry-run`, review, then `./scripts/repair.sh`. This regenerates scaffold
metadata only and never removes assets, projects, `active/` directories or cached artifacts.

## Manifest JSON errors

Validate with `python3 -m json.tool registry/applications.json`. If the file was hand-edited, re-run
`python3 scripts/_generate.py` (generated metadata is overwritten; user content is not).

## Download fails with checksum mismatch

Delete the partial file in `cache/downloads/`, re-check the upstream checksum file, and re-pin the
SHA-256 in your artifacts manifest. Never disable checksum verification.

## AppImage will not start

Check FUSE availability (`libfuse2` on older distributions), executable bit, bundled Qt/GTK libraries,
fonts and GPU driver. `scripts/detect-hardware.sh` reports the graphics stack; AppImages do not carry
host drivers.

## Flatpak permission or runtime errors

Check that the matching runtime is present in `offline-repo/flatpak/repository` and that
`flatpak build-update-repo` was run. Do not mix Flatpak versions across distributions without testing.

## Remotion cannot render offline

Confirm the exact pinned `remotion` version in `package-lock.json`, that `npm ci --offline --cache ...`
succeeds, and that the Chrome Headless Shell from `npx remotion browser ensure` was cached in
`runtimes/browsers/`. Verify `ffmpeg` is reachable. Then run the Remotion test in `tests/rendering/`.
Licence conditions are your responsibility (see `LICENSES.md`).

## Audio application sees no devices

Check PipeWire/JACK/ALSA state with `pactl info`, `jack_lsp`, `aplay -l`. GUI DAWs may need the user
in the `audio` group. Never change system-wide audio configuration without approval.

## ARM64 machine lacks a build

Check `registry/compatibility.json`. Where a package is x86_64-only (e.g. Tahoma2D, OpenToonz,
MeshLab), use the recorded alternative in `COMPATIBILITY.md` instead of forcing an install.
