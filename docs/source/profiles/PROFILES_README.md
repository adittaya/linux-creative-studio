# Python environment profiles

These `.in` files are dependency inventories, not frozen lockfiles. Create one isolated environment per profile with `uv` or micromamba, install the matching GPU framework first where noted, then resolve, test and commit a lockfile for the exact Debian/Ubuntu version, CPU architecture and accelerator backend.

Suggested order:

1. `00-media-core.in` — baseline frame/media forensics.
2. `50-browser-qa.in` — browser capture/regression.
3. `10-vision-torch.in` — install only after selecting the GPU-specific PyTorch build.
4. `11-segmentation-tracking.in` — upstream repositories/checkpoints must be pinned separately.
5. `20-ocr-typography.in` — install Tesseract and/or PaddlePaddle engine first as required.
6. `30-3d-reconstruction.in` — 3D Python libraries only; Blender remains its own application/Python runtime.
7. `40-audio-analysis.in` — optional audio analysis.
8. `60-vfx-pipeline.in` — optional and may need ABI-matched native dependencies.

Do not install every profile into one environment. Legacy/research packages should get their own container or virtual environment and must not be upgraded blindly.
