# Material Maker — application notes

**Purpose.** Procedural PBR material authoring using node graphs
**Suitable tasks.** Procedural PBR material authoring using node graphs
**Capabilities.** procedural-texturing, pbr-materials, texture-generation, node-graph
**Formats.** material, png, jpg, exr, json
**Install methods.** official-portable-archive, source-build
**Runtime dependencies.** godot-runtime, opengl
**Hardware.** CPU-only capable; GPU acceleration optional where supported
**Offline.** Yes; install-time network: False; online activation: False
**License.** MIT
**Executable (manifest canonical path).** `packages/3d/material-maker/active/bin/material-maker`
**Launch.** `studioctl launch material-maker` (prepend `--dry-run` to inspect)
**Verify.** `studioctl verify --id material-maker`
**Verification status.** `unavailable`

## Integration
This application is indexed in `registry/applications.json` and the capability index.
Use `studioctl plan --task "..."` to obtain a reasoned toolchain.

## Known limitations
No current official Linux binary verified; use Blender shader nodes or source build.
