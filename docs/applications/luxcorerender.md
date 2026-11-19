# LuxCoreRender — application notes

**Purpose.** Physically based unbiased/hybrid rendering engine with Blender integration
**Suitable tasks.** Physically based unbiased/hybrid rendering engine with Blender integration
**Capabilities.** rendering, gpu-rendering, path-tracing, hdr-support
**Formats.** lxs, scn, exr, png, hdr
**Install methods.** portable-archive, source-build, blender-addon
**Runtime dependencies.** opencl-or-cuda, boost
**Hardware.** CPU-only capable; GPU acceleration optional where supported
**Offline.** Yes; install-time network: False; online activation: False
**License.** Apache-2.0
**Executable (manifest canonical path).** `packages/3d/luxcorerender/active/bin/luxconsole`
**Launch.** `studioctl launch luxcorerender` (prepend `--dry-run` to inspect)
**Verify.** `studioctl verify --id luxcorerender`
**Verification status.** `unavailable`

## Integration
This application is indexed in `registry/applications.json` and the capability index.
Use `studioctl plan --task "..."` to obtain a reasoned toolchain.

## Known limitations
Linux builds/add-on compatibility varies by Blender version; verify current release before use.
