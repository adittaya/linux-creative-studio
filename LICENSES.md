# Licensing and redistribution

Open-source and proprietary software are separated by design.

## Distribution rules applied here

- No binaries of any kind are shipped in this scaffold. Manifest `license_type` values are taken from
  upstream documentation and must be re-verified at download time (`registry/license-inventory.json`).
- `offline_available: false`, `requires_online_activation: true` or `license_type` containing
  `restricted` means the item is **not** part of the redistributable offline bundle:
  - `davinci-resolve` — Blackmagic Design proprietary; separate acquisition.
  - `reaper` — Cockos proprietary/evaluation; separate acquisition.
- Remotion licence depends on company size/use case: read <https://remotion.dev/license> before
  production use. The studio only provides a local build environment, not a licence grant.
- Bundled *assets* (fonts, HDRIs, brushes, LUTs, stock media) must each carry source, author,
  licence and attribution. The scaffold ships none.

## Major upstream licences recorded

GPL-2.0/3.0: GIMP, Krita, Inkscape, Blender, Kdenlive, Shotcut, Audacity, Ardour, FFmpeg (GPL builds),
Natron, Synfig, Pencil2D, Darktable, RawTherapee, DigiKam.
LGPL: libvips, MLT, FreeCAD.
BSD/Apache/MIT: OpenColorIO, Assimp, Open Image Denoise, Material Maker, Node.js, React,
TypeScript, ExifTool (Artistic/GPL dual), PipeWire (mixed).
AGPL: Argyll CMS.
CECILL-2.1: G'MIC.
Mixed/verify: FFmpeg (LGPL vs GPL depends on configure flags), LUT collections, plug-in sets,
Shutter Encoder, LuxCoreRender, ACES configs, Chromium (third-party components).

## Procedure for adding an application

1. Confirm upstream licence from the official site and the exact artefact.
2. Record it in `metadata/license.json`, `metadata/sources.json` and `registry/license-inventory.json`.
3. Cache the licence text alongside the artifact if redistribution is permitted.
4. If redistribution is not permitted, set `offline_available: false` and provide an acquisition
   procedure in `installers/optional-commercial/`.
5. Never redistribute modified executables or bypass activation.

See `docs/licensing/` for per-family notes.
