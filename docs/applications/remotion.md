# Remotion — application notes

**Purpose.** Programmatic video generation with React and TypeScript
**Suitable tasks.** Programmatic video generation with React and TypeScript
**Capabilities.** programmatic-video, motion-graphics, template-driven-video, batch-video-generation, react, typescript, parameterized-rendering, scripting
**Formats.** tsx, ts, jsx, js, mp4, webm, gif, png, json
**Install methods.** npm-local-cache, distribution-package
**Runtime dependencies.** nodejs-lts, npm-or-pnpm, react, typescript, chromium, ffmpeg
**Hardware.** CPU rendering works; GPU helps for WebGL effects
**Offline.** Yes; install-time network: False; online activation: False
**License.** see-upstream-license
**Executable (manifest canonical path).** `packages/motion/remotion/active/node_modules/.bin/remotion`
**Launch.** `studioctl launch remotion` (prepend `--dry-run` to inspect)
**Verify.** `studioctl verify --id remotion`
**Verification status.** `not-tested`

## Integration
This application is indexed in `registry/applications.json` and the capability index.
Use `studioctl plan --task "..."` to obtain a reasoned toolchain.

## Known limitations
License terms for Remotion depend on company size/use case. Read https://remotion.dev/license before production use.
