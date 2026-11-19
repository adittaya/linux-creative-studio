# digiKam — application notes

**Purpose.** Photo management, cataloguing, RAW editing and face/object tagging
**Suitable tasks.** Photo management, cataloguing, RAW editing and face/object tagging
**Capabilities.** photo-library, raw-development, photo-editing, batch-processing, metadata, color-management
**Formats.** jpg, raw, dng, tif, png, xmp, db
**Install methods.** distribution-package, flatpak
**Runtime dependencies.** qt5-or-qt6, kf5, libraw, exiv2, opencv, mariadb-or-sqlite
**Hardware.** CPU-only capable; GPU acceleration optional where supported
**Offline.** Yes; install-time network: False; online activation: False
**License.** GPL-2.0-or-later
**Executable (manifest canonical path).** `packages/2d-image/digikam/active/bin/digikam`
**Launch.** `studioctl launch digikam` (prepend `--dry-run` to inspect)
**Verify.** `studioctl verify --id digikam`
**Verification status.** `not-tested`

## Integration
This application is indexed in `registry/applications.json` and the capability index.
Use `studioctl plan --task "..."` to obtain a reasoned toolchain.

## Known limitations
No additional limitations recorded. Hardware/GPU support must be tested on the target host.
