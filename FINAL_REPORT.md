# Final report — Linux Creative Studio offline bundle

Generated: 2026-11-19T06:33:08.041713+00:00

## Summary

- Applications registered: **75** across **9** categories.
- Task profiles: **20**; capabilities indexed: **168**.
- Cached installation artifacts: **1622** (checksummed files); **51** applications have a usable offline artifact.
- This is a **populated offline bundle** for Ubuntu 24.04 noble/amd64. It has not been validated on a clean target host; `offline-verified` is still false.

## Status breakdown (declared, honest)

- `not-redistributable`: 2
- `not-tested`: 69
- `unavailable`: 4

## Installed / smoke-passed on this host

- Executable present: blender, blender-color-management, blender-compositor, ffmpeg, ffprobe, git, jq
- CLI smoke test passed (`--version` style): ffmpeg, ffprobe, git, jq
- Portable Blender 5.3.0 (upstream SHA-256 verified) renders the bundled scene headlessly.
- Remotion renders `templates/remotion/starter` from the local npm cache + pinned browser.
- FFmpeg/FFprobe probe test passes. Other system tools were already present on this host.
- Applications with cached artifacts: alsa, archives, ardour, assimp, audacity, audio-plugins, blender, carla, chromium, darktable, digikam, displaycal, exiftool, ffmpeg, flowblade, fontforge, gimp, git, gmic, gstreamer, handbrake, imagemagick, inkscape, jack, jq, kdenlive, krita, libvips, lmms, lottie, mediainfo, meshlab, mkvtoolnix, mpv, mypaint, nodejs, opencolorio, openscad, openshot, pencil2d, pipewire, python, rawtherapee, react, remotion, scribus, shotcut, svg-tools, synfig, typescript, vlc.

## Unavailable / restricted

- **Material Maker** (`material-maker`) — `unavailable`: No current official Linux binary verified; use Blender shader nodes or source build.
- **Meshroom** (`meshroom`) — `unavailable`: Official Linux builds are version-specific and GPU (CUDA) oriented; verify before acquisition.
- **LuxCoreRender** (`luxcorerender`) — `unavailable`: Linux builds/add-on compatibility varies by Blender version; verify current release before use.
- **DaVinci Resolve (optional)** (`davinci-resolve`) — `not-redistributable`: Optional commercial package. Do NOT redistribute. Separate acquisition procedure in installers/optional-commercial/.
- **DisplayCAL** (`displaycal`) — `unavailable`: Upstream development is dormant; prefer Argyll CMS CLI plus current distro display-calibration tools.
- **REAPER (optional)** (`reaper`) — `not-redistributable`: Optional commercial package. Evaluation license terms apply. Separate acquisition procedure only.

## Tests executed in this environment

- `test-codecs-ffmpeg.json`: **passed**
- `test-codecs-ffprobe.json`: **unknown**
- `test-installation-image-export.json`: **skipped**
- `test-offline.json`: **partially-verified**
- `test-rendering-blender.json`: **passed**
- `test-rendering-remotion.json`: **passed**

## Not verified / outstanding

- No clean, isolated target host was available; all tests ran in the preparation environment.
- No GUI application was launched interactively; GPU/driver paths are untested.
- No AppImage, Flatpak, Python wheel or Debian closure was added for non-Ubuntu targets.
- No offline guarantee is claimed until the full suite passes on an isolated host. `offline-check` report:
  - `artifact-not-cached`: 13
  - `available-locally`: 52
  - `facade`: 4
  - `restricted`: 6

## Deliverables present

- Full directory structure, 75 per-application metadata packages and machine-readable indexes.
- Working `studioctl` CLI with capability search, task planning, launch guards and JSON output.
- 20 task profiles, presets, templates, configuration and documentation.
- 1,615 SHA-256-verified apt packages + local file: repository indexes.
- Portable Blender 5.3.0, npm cache and pinned Chrome Headless Shell.
- Guarded download/install/verify/offline/repair/update/uninstall scripts.
- Test suite, functional-test logs, compatibility/licence/security records and checksums.
- Transfer-ready directory tree (see the generated zip archive).

Upgrade any status to `verified`/`offline-verified` only after running `tests/` on the target machine and storing the corresponding logs in `logs/`.
