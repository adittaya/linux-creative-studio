# FontForge — application notes

**Purpose.** Font creation and editing with scripting support
**Suitable tasks.** Font creation and editing with scripting support
**Capabilities.** font-design, typography, vector-design, scripting
**Formats.** ttf, otf, woff, woff2, sfd, svg, ufo
**Install methods.** distribution-package, flatpak
**Runtime dependencies.** freetype, fontconfig, python3
**Hardware.** CPU-only capable; GPU acceleration optional where supported
**Offline.** Yes; install-time network: False; online activation: False
**License.** GPL-3.0-or-later
**Executable (manifest canonical path).** `packages/2d-image/fontforge/active/bin/fontforge`
**Launch.** `studioctl launch fontforge` (prepend `--dry-run` to inspect)
**Verify.** `studioctl verify --id fontforge`
**Verification status.** `not-tested`

## Integration
This application is indexed in `registry/applications.json` and the capability index.
Use `studioctl plan --task "..."` to obtain a reasoned toolchain.

## Known limitations
No additional limitations recorded. Hardware/GPU support must be tested on the target host.
