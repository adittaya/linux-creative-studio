# Compatibility matrix and policy

Detection is not proof. Every entry below is **untested** until a log exists in `logs/`.

## Priority targets

| Target | Architecture | Status | Preferred method |
|---|---|---|---|
| Debian stable | x86_64 | planned, untested | distribution packages + portable/AppImage |
| Debian stable | aarch64 | partial upstream coverage | distribution packages where available |
| Ubuntu LTS | x86_64 | planned, untested | apt snapshot + portable/AppImage/Flatpak |
| Ubuntu LTS | aarch64 | partial upstream coverage | distribution packages; check Blender/Krita upstream builds |
| Linux Mint | x86_64 | derived from Ubuntu | same as Ubuntu LTS of matching base |
| Other Debian/Ubuntu derivatives | x86_64/aarch64 | only where demonstrated | portable archives preferred |

## Per-application caveats (from the registry)

| ID | Architecture | Status | Caveat |
|---|---|---|---|
| blender | x86_64, aarch64 | not-tested | portable build carries own Python; verify glibc baseline |
| gimp | x86_64, aarch64 | not-tested | GTK version varies by 3.2.x; AppImage may bundle its own |
| krita | x86_64, aarch64 | not-tested | 5.3 = Qt5, 6.0 = Qt6; choose intentionally |
| shotcut | x86_64, aarch64* | not-tested | AppImage primary; *ARM64 availability must be confirmed upstream |
| kdenlive | x86_64, aarch64 | not-tested | KDE/Qt stack version coupling |
| remotion | x86_64, aarch64 | not-tested | Node LTS + pinned Chrome Headless Shell required |
| chromium | x86_64, aarch64 | not-tested | Remotion-pinned build; system browser is not a substitute |
| tahoma2d | x86_64 | not-tested | no verified ARM64 upstream build |
| opentoonz | x86_64 | not-tested | no verified ARM64 upstream build |
| meshlab | x86_64 | not-tested | OpenGL required |
| meshroom | x86_64 | unavailable | version-specific Linux builds; CUDA-oriented |
| material-maker | x86_64 | unavailable | no current verified Linux binary |
| luxcorerender | x86_64 | unavailable | Blender add-on compatibility varies |
| natron | x86_64 | not-tested | pin to matching OCIO config |
| displaycal | x86_64 | unavailable | upstream dormant; use Argyll CMS CLI |
| davinci-resolve | x86_64 | not-redistributable | vendor GPU requirements, licence/account |
| reaper | x86_64, aarch64* | not-redistributable | commercial evaluation terms; *check vendor build |

Full machine-readable matrix: `registry/compatibility.json`.

## Detection performed by scripts

`scripts/detect-system.sh`: distro ID/version/codename, package manager, kernel, glibc, CPU arch,
available tools, and whether the target is in the supported set.

`scripts/detect-hardware.sh`: logical cores, RAM, GPU vendor IDs (NVIDIA 0x10de, AMD 0x1002,
Intel 0x8086), kernel drivers, OpenGL/Vulkan availability, /dev/dri, free disk, suggested profile.

## Rules when a package is incompatible

1. Do not force installation. Do not disable security, mix Debian/Ubuntu packages, or replace
   glibc/system Python/graphics drivers.
2. Search for an official compatible version or packaging method (often Flatpak or a portable build).
3. Offer a clearly labelled alternative: e.g. Blender Grease Pencil for Tahoma2D on ARM64,
   Argyll CMS CLI for DisplayCAL, Blender shader nodes for Material Maker,
   Kdenlive/Shotcut for DaVinci Resolve.
4. Record the limitation in `registry/compatibility.json` and the application's `metadata/compatibility.json`.

## GPU policy

NVIDIA, AMD, Intel and CPU-only paths are *detected*, never auto-installed. Proprietary drivers require
user approval and are outside the offline studio bundle. GPU acceleration is optional for most tasks;
Cycles/Eevee/OIDN performance is hardware-dependent.
