# Linux Reverse-Engineering Documentation Bundle

Research snapshot: 21 November 2026.

## Contents

- `Linux_Debian_Ubuntu_Reverse_Engineering_Tech_Stack_2026-11-21.md` — full technical documentary (14,800+ words).
- `Package_Registry_Debian_Ubuntu_2026-11-21.yaml` — machine-readable package and capability inventory.
- `apt/00-core-workstation.txt` — base Debian/Ubuntu workstation APT package list.
- `apt/10-native-cv-media-build.txt` — optional native CV/media development headers.
- `apt/20-vfx-colour-font-build.txt` — optional VFX/colour/font/graphics development headers.
- `apt/30-colmap-3d-build.txt` — optional COLMAP/3D reconstruction development dependencies.
- `profiles/*.in` — separate Python dependency inventories for media, vision, tracking, OCR/typography, 3D, audio, browser QA and VFX workers.

## Important

The manifests are inventories, not a one-command installation of every package. Verify each package with `apt-cache policy`, check upstream compatibility for the exact OS/GPU/kernel, and use separate Python/Node/Blender/model environments. Do not run a monolithic `pip install` across all profiles. Model weights, fonts and datasets have separate licenses and checksums.

The original Agent 2 final delivery contract remains unchanged: its result ZIP must contain only `index.html` and `preset.md`. This Linux documentation bundle is a separate engineering reference.

## Safe APT manifest usage

The `apt/*.txt` files are one-package-per-line inventories. Review the exact file first, then install only the profile you need. Example:

```bash
sudo apt update
grep -Ev '^\s*(#|$)' apt/00-core-workstation.txt | xargs -r sudo apt install -y
```

Optional build profiles should be installed separately and only when building those native libraries. Check package availability first with `apt-cache policy <package>`; Debian and Ubuntu release repositories do not always carry identical package versions or names.

## Python profiles

Use each `profiles/*.in` file as a dependency input for its own virtual environment. They are intentionally not pinned lockfiles: first choose the compatible Python + CPU/CUDA/ROCm build, install framework-specific packages from their upstream selector, run the relevant smoke tests, then resolve and commit a lockfile for that exact machine profile.
