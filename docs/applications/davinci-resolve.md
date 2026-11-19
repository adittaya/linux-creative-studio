# DaVinci Resolve (optional) — application notes

**Purpose.** Proprietary professional NLE and color grading suite
**Suitable tasks.** Proprietary professional NLE and color grading suite
**Capabilities.** color-grading, video-editing, fairlight-audio, fusion-vfx, hdr-grading
**Formats.** drp, mp4, mov, exr, dpx, braw
**Install methods.** vendor-official-installer
**Runtime dependencies.** proprietary-driver-stack, ffmpeg, opencl-or-cuda
**Hardware.** Vendor GPU/VRAM requirements apply; check official release notes
**Offline.** No / restricted; install-time network: True; online activation: True
**License.** proprietary-redistribution-restricted
**Executable (manifest canonical path).** `packages/color/davinci-resolve/active/bin/resolve`
**Launch.** `studioctl launch davinci-resolve` (prepend `--dry-run` to inspect)
**Verify.** `studioctl verify --id davinci-resolve`
**Verification status.** `not-redistributable`

## Integration
This application is indexed in `registry/applications.json` and the capability index.
Use `studioctl plan --task "..."` to obtain a reasoned toolchain.

## Known limitations
Optional commercial package. Do NOT redistribute. Separate acquisition procedure in installers/optional-commercial/.
