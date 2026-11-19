# Chromium (Remotion runtime) — application notes

**Purpose.** Headless browser used by Remotion Renderer
**Suitable tasks.** Headless browser used by Remotion Renderer
**Capabilities.** browser-runtime, programmatic-video, headless-rendering, web-animation
**Formats.** html, js, webm, mp4
**Install methods.** remotion-browser-download, distribution-package
**Runtime dependencies.** libnss3, libatk, libgbm, libasound2, fonts
**Hardware.** CPU-only capable; GPU acceleration optional where supported
**Offline.** Yes; install-time network: False; online activation: False
**License.** BSD-3-Clause and third-party
**Executable (manifest canonical path).** `packages/motion/chromium/active/chrome/chrome`
**Launch.** `studioctl launch chromium` (prepend `--dry-run` to inspect)
**Verify.** `studioctl verify --id chromium`
**Verification status.** `not-tested`

## Integration
This application is indexed in `registry/applications.json` and the capability index.
Use `studioctl plan --task "..."` to obtain a reasoned toolchain.

## Known limitations
Remotion downloads a pinned Chrome Headless Shell. Cache it explicitly with `npx remotion browser ensure` on a connected preparation machine.
