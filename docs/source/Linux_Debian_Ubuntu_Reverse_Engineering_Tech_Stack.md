# Linux Reverse-Engineering & Reconstruction Technology Stack
## Full package and platform documentary for Debian and Ubuntu

**Research snapshot:** 21 November 2026  
**Target operating systems:** Debian GNU/Linux and Ubuntu only  
**Target architecture:** x86-64 first; ARM64 where upstream wheels and model builds are available  
**Scope:** production-grade forensic reverse engineering of 2D, 2.5D, true 3D, composited, procedural, typographic, UI, live-action and hybrid motion graphics from video and supplied media packages.

---

## Executive summary

This document specifies a Linux software stack for an advanced local reverse-engineering system. Its objective is not merely to detect objects in a video or generate plausible animation code. It is to recover the best-supported explanation of how a reference visual was constructed, preserve its timing and evidence, rebuild it in an editable representation, render it deterministically, quantify the differences, and package a reproducible result.

The stack is deliberately broader than a single Python environment. It combines:

1. **Native media infrastructure:** FFmpeg, PyAV, GStreamer, image codecs and metadata tools.
2. **Forensic computer vision:** OpenCV, segmentation, object detection, tracking, optical flow, feature matching, depth and camera estimation.
3. **2D graphics and typography:** SVG/vector tools, font shaping, OCR, raster processing and 2D animation applications.
4. **2.5D and 3D reconstruction:** Blender, COLMAP, OpenMVG/OpenMVS, AliceVision/Meshroom, Open3D, Gaussian splatting and NeRF tooling.
5. **VFX and interchange:** OpenUSD, MaterialX, OpenColorIO, OpenImageIO, OpenEXR, OpenVDB, Alembic and OpenTimelineIO.
6. **Browser-based reconstruction:** HTML, CSS, SVG, Canvas, WebGL/WebGPU, Three.js, PixiJS, GSAP, Playwright and optionally HyperFrames.
7. **Quantitative validation:** pixel, structure, perceptual, geometry, motion, timing and temporal-continuity metrics.
8. **Production engineering:** isolated environments, reproducible dependency locks, model provenance, tests, experiment records, security and archive validation.

### Recommended core architecture

Use **Blender as the primary general-purpose 3D reconstruction and look-development environment**, not as a replacement for all other renderers. Use **OpenCV + PyAV as the deterministic media/measurement base**, and **PyTorch-based models as evidence-producing specialists**. Use **Three.js/WebGL or DOM/SVG/Canvas to deliver genuinely editable browser animation**. Use **COLMAP/pycolmap and depth/point-tracking tools when 3D structure is supported by evidence**. Keep all neural model stacks isolated by compatibility profile.

### Essential warning

There is no single `pip install everything` command that safely installs all of these tools. GPU runtimes, PyTorch builds, CUDA/ROCm, compiled extensions, Blender's bundled Python, OCR engines and Node/browser packages have independent compatibility constraints. A production install should be assembled from the profiles in this document and tested on the actual host.

---

# 1. Scope, assumptions and relationship to Agent 2

This documentary expands the existing **Agent 2 — Forensic Segment Motion Reconstruction & Preset Engineering** workflow (V5.1.0-beta.3 and the subsequent V5.2 advanced specification). The original purpose and final output contract remain authoritative:

- One supplied segment/package per run.
- Phase 1A: global technical and canonical-asset scouting before committing to a renderer.
- Phase 1B: strictly chronological, one-segment-relative-second reconstruction and validation.
- Six synchronized render layers: L0 camera/post-FX, L1 environment/background, L2 lighting/atmosphere, L3 hero geometry/type, L4 dynamics/particles, L5 foreground UI/morphs.
- Five separate style-analysis dimensions: art direction, motion language, animation mechanics, production method/dimensionality, and sonic language.
- Persistent element identity and evidence provenance.
- Source PTS and rational timebases as canonical timing.
- A deterministic absolute-time `renderAt(t)` function.
- Phase 2 extracts a reusable preset only after Phase 1 has passed its acceptance gate.
- The eventual Agent 2 ZIP still contains exactly `index.html` and `preset.md` at its root.

This document is the **Linux platform and package companion**, not a change to Agent 2's assignment. Tool outputs, scene reconstructions and intermediate caches belong in the working area and must never leak into the final two-file ZIP.

## 1.1 What counts as reverse engineering

The intended system must be capable of investigating and reconstructing:

- **2D:** typography, logos, vector graphics, masks, shape animation, UI, charts, illustration, linework, flat compositing, colour fields and text choreography.
- **2.5D:** layered image planes, depth-aware parallax, camera moves over planes, depth maps, billboarded particles, pseudo-volume, shallow perspective, multi-plane composites and 2D artwork placed in a 3D camera.
- **True 3D:** camera and object transforms, mesh geometry, PBR materials, lights, shadows, reflections, volumetric effects, particles, cloth/liquid/rig dynamics, perspective changes and rendered 3D assets.
- **Video-derived 3D:** camera calibration, structure from motion, multi-view stereo, depth estimation, point clouds, meshes, radiance fields and 3D Gaussian splats.
- **Hybrid/live action:** rotoscoped masks, tracked overlays, text over footage, clean plates, inpainting, lens effects, optical flow, grading and compositing.
- **Temporal/audio evidence:** word-level speech alignment, beat/onset cues, SFX timing and audiovisual event correspondence where relevant. Audio analysis does not require audio playback in the visual-accuracy deliverable.

The system must not infer a 3D scene merely because an animation looks dimensional. It must compare competing hypotheses: flat 2D transform, nested 2D transforms, depth-layer parallax, planar homography, perspective camera, true 3D object rotation, or pre-rendered 3D plate.

## 1.2 Non-goals

- Replacing the upstream segmentation agent.
- Silently rewriting the transcript or changing time origins.
- Stitching an entire video from unrelated segments.
- Treating an AI vision model's description as ground truth.
- Using generated or interpolated frames as evidence of source detail.
- Delivering a full-frame raster slideshow or an MP4 disguised as an editable HTML implementation.
- Requiring every advanced package for every segment.

---

# 2. Linux baseline and supported platform policy

## 2.1 OS recommendation as of 21 November 2026

| Distribution | Current state | Recommendation |
|---|---|---|
| Debian 13 “Trixie” 13.7 | Current Debian stable | **Primary production choice** for a stable workstation or render host |
| Ubuntu 26.04 LTS “Resolute Raccoon” | Current LTS; standard support listed through May 2031 | **Primary production choice** where GPU vendor/application docs target Ubuntu first |
| Ubuntu 24.04 LTS “Noble Numbat” | Mature LTS; ecosystem compatibility is broad | Strong compatibility fallback for packages whose 26.04 support lags |
| Ubuntu 26.10 “Stonking Stingray” | Interim release; shorter support window | Use for test/development only, not the default long-lived production host |
| Debian 12 “Bookworm” | Oldstable, in LTS phase | Keep only for legacy compatibility; do not start a new long-lived workstation here without a dependency reason |

Debian reports 13.7 as current stable (released 12 September 2026). Ubuntu 26.04 LTS was released on 23 April 2026; Ubuntu 26.10 is an interim release. Playwright currently documents support for Debian 12/13 and Ubuntu 22.04/24.04/26.04, which is one reason not to assume its official compatibility extends to Ubuntu 26.10 yet. [R1–R4]

### Practical selection

- **New workstation / local production:** Debian 13.7 or Ubuntu 26.04 LTS.
- **NVIDIA GPU workstation:** Ubuntu 26.04 LTS is usually the least-friction starting point when the selected CUDA/PyTorch project explicitly lists it. Debian 13 is also in the current CUDA support matrix.
- **AMD GPU workstation:** inspect the exact ROCm matrix for GPU family, kernel and distro before choosing the OS. ROCm 10.2 lists Debian 13 and Ubuntu 26.04.1 for relevant platforms, but the exact GPU architecture and kernel tuple matters. [R5–R6]
- **Older commercial/VFX dependencies:** use an isolated container or compatibility environment instead of downgrading the host OS unless the vendor explicitly requires it.

## 2.2 Architecture

- **x86-64 / amd64:** recommended. It has the broadest coverage for CUDA, compiled extensions, model wheels, COLMAP, Blender and browser automation.
- **ARM64 / aarch64:** viable for many CPU and general-purpose tools, but verify every Python wheel, GPU framework, point-cloud library and model extension separately. Do not assume an x86-64 model environment will translate.
- **Mixed GPU systems:** do not assume a single model process can use CUDA and ROCm interchangeably. Treat CUDA, ROCm, Intel XPU and CPU as separate runtime targets.

## 2.3 Linux desktop and headless modes

The workstation may be a desktop system or a headless renderer. Both are useful:

- Desktop: Blender UI, Krita, Inkscape, MeshLab/CloudCompare, annotation and manual forensic review.
- Headless: Blender `-b`, FFmpeg, COLMAP CLI, model inference, Playwright headless browser and CI tests.
- Headless OpenGL/WebGL requires a properly supported EGL/OSMesa/software-render path or a virtual display where the chosen app requires one. Do not assume `DISPLAY` is available on a server.
- Keep the GUI and compute drivers supplied by the distro/vendor. Install only the required developer toolkit in the model environment.

---

# 3. Installation philosophy: separate host, environments, models and renderers

## 3.1 Four installation layers

| Layer | Install mechanism | Contents |
|---|---|---|
| Host OS | APT / vendor repository | compiler, codecs, system libraries, GPU driver, fonts, browser dependencies |
| Python environments | `uv`, `venv`, or `micromamba` | PyAV, OpenCV, PyTorch, OCR, tracking, metrics, orchestration |
| JavaScript environment | Node LTS + npm/pnpm | Three.js, PixiJS, GSAP, Vite, HyperFrames, Playwright JS if used |
| Large model/application assets | official model repositories/releases | SAM checkpoints, depth checkpoints, OCR weights, Blender, COLMAP data and fonts |

Model weights must be inventoried separately from Python packages. A `pip freeze` file does not capture the provenance or licensing of a 2–30 GB checkpoint.

## 3.2 Python: do not modify Debian/Ubuntu's system interpreter

Debian follows PEP 668: the distro-managed Python environment is marked externally managed, and `pip` should not install packages directly into it. Use APT for OS-managed Python packages, `venv`/`uv` for project libraries, and `pipx` for standalone Python command-line applications. Never use `--break-system-packages` as the default. [R7]

Recommended choices:

- **uv:** preferred default for Python interpreter installation, virtual environments, dependency resolution and reproducible lockfiles.
- **micromamba:** best where native compiled libraries and conda-forge packages must be solved together; particularly useful for research stacks with CUDA/C++ extensions.
- **Pixi:** good for a project that needs conda-forge native packages plus PyPI dependencies and one committed environment lock.
- **pipx:** standalone tools such as `pre-commit`, `ruff`, `httpie` or selected CLIs.
- **Conda/Miniforge:** acceptable where an upstream research repo explicitly targets Conda; choose one environment manager for each environment.

Do not mix `apt install python3-opencv`, `opencv-python`, `opencv-contrib-python`, and source-built OpenCV inside one Python import path without deliberately controlling the ABI. Use one OpenCV provider per environment.

## 3.3 Environment isolation policy

At minimum create these environments or containers:

1. `media-core`: PyAV, PySceneDetect, OpenCV, NumPy, SciPy, scikit-image, Pydantic, JSON Schema.
2. `vision-torch`: one pinned PyTorch + torchvision build, Transformers, Grounding DINO, SAM 3.x/SAM 2.x, optical flow, depth and feature tracking. Split further if upstream packages conflict.
3. `ocr-typography`: PaddleOCR/PaddlePaddle or an OCR alternative, FontTools, HarfBuzz bindings, font analysis.
4. `reconstruction-3d`: COLMAP/pycolmap, Open3D, hloc/LightGlue, mesh tooling; compiled CUDA or HIP extensions isolated.
5. `inpainting-restoration`: ProPainter, Real-ESRGAN, RIFE and model-specific runtime.
6. `audio-analysis`: librosa, Essentia, faster-whisper, pyannote.audio and their model weights.
7. `qa-browser`: Playwright, pytest, browser binaries, screenshot comparison and HTML offline audit.
8. `blender`: use the Python bundled with the selected Blender binary for `bpy`; do not install `bpy` into the primary Python environment and expect it to match Blender's ABI.
9. `web-render`: Node.js 26 LTS with pinned npm/pnpm dependencies.

Avoid a monolithic environment. Torch, Paddle, OpenCV, VTK, Qt/PySide, CUDA extensions and browser test tools are common sources of binary dependency conflicts.

## 3.4 Reproducibility requirements

For every accepted environment capture:

- OS release, architecture, kernel, glibc and compiler version.
- GPU model, driver, CUDA/ROCm runtime and device capability.
- Python and Node versions.
- Exact package lockfile and installation source/index.
- Git commit or release tag for source installs.
- Model repository, revision, filename, SHA-256, license and access terms.
- Blender version/build hash and render engine settings.
- Browser version and Playwright version.
- Fonts and OCIO configuration checksums.

Never rely on `latest`, a moving `main` branch or a mutable Hugging Face revision for a production reproduction without recording the resolved commit and checkpoint hash.

---

# 4. GPU, driver and acceleration matrix

## 4.1 NVIDIA CUDA

Recommended if using a CUDA-first computer-vision stack.

- Install the NVIDIA kernel driver using the supported distro/vendor package-manager route.
- Install CUDA Toolkit only when compiling CUDA extensions or using tools that explicitly require `nvcc`.
- Prefer framework-provided CUDA runtime wheels for standard PyTorch use; do not assume the system toolkit must match the wheel's bundled runtime.
- `nvidia-smi` reports the driver and the maximum CUDA API level it supports; it does not prove that the full CUDA Toolkit/compiler is installed.
- Avoid combining NVIDIA's `.run` driver installer with APT-managed NVIDIA packages on the same host.
- For containers, install the NVIDIA Container Toolkit after the host driver; the container exposes devices/runtime components but does not replace the host driver. [R5, R8]

As checked in this research snapshot, NVIDIA's CUDA 13.4 Linux guide lists Debian 12/13 and Ubuntu 22.04/24.04/26.04 for amd64. Always check the driver/toolkit support table for the exact release and GPU before installing. [R5]

### Typical NVIDIA verification

```bash
nvidia-smi
which nvcc || true
nvcc --version || true
python - <<'PY'
import torch
print('torch:', torch.__version__)
print('cuda available:', torch.cuda.is_available())
print('torch CUDA runtime:', torch.version.cuda)
if torch.cuda.is_available():
    print('device:', torch.cuda.get_device_name(0))
    print('capability:', torch.cuda.get_device_capability(0))
PY
```

## 4.2 AMD ROCm / HIP

Use when the exact AMD GPU is listed in the current ROCm compatibility matrix and the selected model framework supports ROCm.

- Install AMDGPU/ROCm using AMD's currently supported installation instructions.
- Check the ROCm version, GPU architecture (`gfx*`), kernel and OS as a tuple.
- Do not infer ROCm support merely because Blender or the desktop driver supports the GPU.
- Some research code assumes CUDA-only extensions or CUDA-specific kernels; these require a supported ROCm port or a different backend.
- ROCm can be a viable PyTorch platform, but project-specific model availability remains independent.

ROCm 10.2's release notes list Debian 13 and Ubuntu 26.04.1 in supported operating-system tables, while the compatibility matrix warns that actual support varies by GPU/APU and kernel. [R6]

### Typical AMD verification

```bash
rocminfo | head -80
rocm-smi || amd-smi || true
python - <<'PY'
import torch
print('torch:', torch.__version__)
print('hip:', torch.version.hip)
print('cuda api:', torch.cuda.is_available()) # PyTorch uses this namespace on ROCm too
if torch.cuda.is_available():
    print(torch.cuda.get_device_name(0))
PY
```

## 4.3 Intel GPUs

Treat Intel acceleration as an additional optional route:

- Intel oneAPI / Level Zero / SYCL stack where supported.
- PyTorch XPU builds for supported Intel devices.
- OpenVINO for Intel-optimized inference and CPU/iGPU deployments.
- Vulkan compute only for applications with a maintained Vulkan backend.

Do not choose Intel acceleration as the baseline for a model until the exact model, operators, precision and memory path have been validated. It is useful for selected inference and display tasks but is not a universal CUDA replacement.

## 4.4 CPU-only operation

A CPU profile remains mandatory for portability and debugging. Keep classical CV, timeline analysis, metadata parsing, PTS handling, SVG/vector reconstruction, geometry fitting and QA runnable on CPU. Neural models may use reduced-size weights or be disabled with an explicit `capability_unavailable` record.

---

# 5. Native APT packages for Debian and Ubuntu

The APT names below are a starting inventory, not a promise that every package is in every configured component or release. Package availability and library ABI change. Check each machine with `apt-cache policy PACKAGE` before building a script around it. Prefer distro packages for host libraries; use upstream distributions when the repo version is too old or omits a needed build feature.

## 5.1 General workstation and build tools

**Recommended base:**

```bash
sudo apt update
sudo apt install -y \
  build-essential gcc g++ clang lld lldb gdb cmake ninja-build meson pkg-config \
  git git-lfs curl wget ca-certificates gnupg jq ripgrep fd-find \
  unzip zip p7zip-full xz-utils zstd rsync parallel \
  python3 python3-full python3-dev python3-venv python3-pip pipx \
  sqlite3 ffmpeg mediainfo exiftool imagemagick \
  libgl1 libegl1 libglib2.0-0 libsm6 libxext6 libxrender1 \
  libfontconfig1 libfreetype6 libharfbuzz0b libxkbcommon0 libnss3 libgbm1
```

Notes:

- `fd-find` may install the command as `fdfind` on Debian/Ubuntu; set an alias if desired.
- `libasound2` versus `libasound2t64` differs across distribution generations. Let Playwright install browser dependencies or check the actual package name instead of hard-coding it across all OS releases.
- Install `python-is-python3` only if scripts require `python` to resolve to Python 3; use `python3` explicitly in robust scripts.
- `ffmpeg` in the distro repository may be built with a different codec/filter set from a custom upstream build. Check `ffmpeg -buildconf` and `ffmpeg -filters`.
- Do not add third-party multimedia repositories solely to obtain one codec without evaluating trust, update and licensing implications.

## 5.2 Native computer-vision and scientific build libraries

Optional native-build layer:

```bash
sudo apt install -y \
  libopencv-dev libeigen3-dev libtbb-dev libopenblas-dev liblapack-dev \
  libsuitesparse-dev libceres-dev libmetis-dev libgoogle-glog-dev libgflags-dev \
  libboost-all-dev libsqlite3-dev libglew-dev libglfw3-dev \
  libavcodec-dev libavformat-dev libavutil-dev libswscale-dev \
  libswresample-dev libavfilter-dev libavdevice-dev \
  libjpeg-dev libpng-dev libtiff-dev libwebp-dev libopenjp2-7-dev \
  libraw-dev libheif-dev libvips-dev
```

Use only if compiling OpenCV, COLMAP, custom decoders, image tools or model extensions. The runtime does not require every development header.

## 5.3 VFX, colour, font and graphics libraries

Check availability in the selected distro first:

```bash
sudo apt install -y \
  libopenexr-dev libopenimageio-dev libopencolorio-dev libopenvdb-dev \
  libopensubdiv-dev libfontconfig1-dev libfreetype6-dev libharfbuzz-dev \
  libfribidi-dev libcairo2-dev librsvg2-dev libpango1.0-dev \
  libvulkan-dev vulkan-tools mesa-vulkan-drivers glslang-tools spirv-tools
```

MaterialX, newer OpenUSD and some VFX dependencies may need their upstream release or a source build when the distro version lags. OpenUSD requires a C++ compiler, CMake and TBB; imaging components can optionally integrate OpenSubdiv, OpenEXR, OpenImageIO, OpenColorIO, OSL and Ptex. [R9]

## 5.4 COLMAP / MVS native dependencies

COLMAP's current Debian/Ubuntu build instructions include CMake/Ninja, Boost, Eigen, OpenImageIO, METIS, glog, gtest/gmock, SQLite, GLEW, Qt6, CGAL, Ceres and SuiteSparse. Default distro packages may not enable CUDA or HIP; build from source with the correct backend if GPU SfM/MVS is needed. [R10]

Example dependency group (names can vary by release):

```bash
sudo apt install -y \
  git cmake ninja-build build-essential \
  libboost-program-options-dev libboost-graph-dev libboost-system-dev \
  libeigen3-dev libopenimageio-dev openimageio-tools libmetis-dev \
  libgoogle-glog-dev libgtest-dev libgmock-dev libsqlite3-dev libglew-dev \
  qt6-base-dev libqt6opengl6-dev qt6-svg-dev libcgal-dev libceres-dev \
  libsuitesparse-dev libcurl4-openssl-dev libssl-dev
```

Do not copy an old COLMAP install guide blindly: Qt5/Qt6, compiler, CUDA and CGAL dependencies have changed over time. Follow the current upstream page for the target release.

---

# 6. Media ingest, decoding, metadata and timeline packages

This is the foundational layer. Exact frame identity and presentation timestamps must not depend on OpenCV's generic video reader alone.

| Package / tool | Install form | Role | Priority | Notes |
|---|---|---|---|---|
| **FFmpeg / ffprobe** | APT or verified upstream build | demux, decode, transcode, filters, metadata probe, frame extraction, image sequence assembly | P0 | Inspect build configuration and enabled codecs/filters |
| **PyAV** (`av`) | Python wheel / source | FFmpeg bindings with frame/packet PTS and timebase access | P0 | Use for canonical decoding and timestamp manifests |
| **OpenCV** (`opencv-contrib-python-headless` or system build) | Python wheel / APT/source | image operations, tracking, optical flow, transforms, masks | P0 | Choose one provider per environment; do not mix wheels |
| **PySceneDetect** (`scenedetect`) | Python | candidate cuts, fades and scene boundaries | P1 | A detector proposes boundaries; it does not replace PTS truth |
| **GStreamer** | APT + plugins | streaming media pipeline, hardware codecs and live ingest | P1 | Useful for complex device/stream pipelines; FFmpeg remains primary offline tool |
| **VapourSynth** | Python wheel/source or distro-specific packages | frame-server graph for restoration, filtering and frame-accurate processing | P1 | Plugin availability and Debian packages may need extra attention |
| **OpenTimelineIO** (`opentimelineio`) | Python | editorial timeline interchange and time-domain representation | P1 | Useful for import/export and editorial handoff, not required for `renderAt` |
| **MediaInfo** (`mediainfo`) | APT / official builds | container and stream metadata reporting | P1 | Independent cross-check against ffprobe |
| **ExifTool** (`exiftool`) | APT | image/video metadata and asset provenance | P1 | Useful for asset inventories |
| **imageio / imageio-ffmpeg** | Python | convenient image/video I/O | P2 | Not the canonical PTS source |
| **Decord** | Python/source | random-access video reader for ML datasets | P2 | Validate VFR/PTS semantics before using it in a forensic pipeline |
| **PyTorchVideo** | Python | video dataset transforms and model utilities | P2 | Useful for ML experiments, not exact timeline decoding |
| **zimg** | native library | high-quality pixel-format/colour-space conversion | P1 | Useful with VapourSynth/FFmpeg builds |
| **libplacebo** | FFmpeg/native GPU integration | high-quality GPU shader-based scaling, gamut/tone mapping | P2 | Validate GPU backend and deterministic comparison needs |

### Required decode manifest

For every decoded frame store:

- source SHA-256 and stream index;
- decode index and presentation index;
- integer PTS and rational timebase numerator/denominator;
- DTS when available;
- duration if reliable;
- original frame dimensions and pixel format;
- colour primaries, transfer, matrix, range and chroma location;
- duplicate-frame/hold indicator, if detected;
- decode warnings and discontinuity flags.

Use `frame.pts * frame.time_base` only for conversion/display; the canonical value is the integer PTS plus rational timebase. PyAV documents that timestamps are integer multiples of timebase units and exposes frame/packet PTS and DTS. [R11]

---

# 7. Core Python scientific and image-processing stack

| Package | Role | Priority | Guidance |
|---|---|---|---|
| `numpy` | arrays, vectorized image operations | P0 | Pin with compiled extensions |
| `scipy` | optimization, least squares, filtering, interpolation, spatial data | P0 | Essential for fitting curves, fields and physical models |
| `pandas` | evidence tables and ledgers | P1 | Use for moderate tabular data |
| `polars` | fast tabular processing | P2 | Optional; avoid using both without reason |
| `scikit-image` | SSIM, NRMSE, PSNR, segmentation and image transforms | P0 | Use metrics with correct range/data_range |
| `Pillow` | image conversion, inspection and metadata-adjacent work | P0 | Not a substitute for colour-managed HDR I/O |
| `imageio` | image sequence I/O | P1 | Convenient, not canonical media timing |
| `tifffile` | TIFF/OME data | P2 | Large scientific or high-bit-depth images |
| `pyvips` | large-image operations, streaming pipelines | P1 | Very useful for memory-constrained high-res assets |
| `scikit-learn` | clustering, PCA and classifiers | P1 | Background SVD/PCA, grouping and feature analysis |
| `statsmodels` | statistical models and uncertainty | P2 | Use when confidence intervals/statistical analysis matter |
| `sympy` | symbolic algebra | P2 | Derive/test motion and projection formulas |
| `numba` | JIT accelerated NumPy-style kernels | P2 | Profile first; not all functions benefit |
| `cupy` | CUDA array operations | P2 | NVIDIA-only; only when Python/CUDA array interop pays off |
| `jax` | differentiable numerical modelling | P2 | Separate stack; don't install merely because PyTorch exists |
| `torch` / `torchvision` | deep learning and RAFT model implementations | P0 for AI profile | Install from official selector and pin matching versions |
| `torchmetrics` | model/metric calculations | P1 | Optional metric catalogue |
| `kornia` | differentiable computer vision on PyTorch | P1 | Geometric transforms, feature matching, augmentations |
| `albumentations` | image augmentation | P2 | More relevant for training/robustness testing than inference |
| `einops` | tensor rearrangement | P1 | Common model dependency |
| `safetensors` | safe tensor checkpoint format | P1 | Prefer when model repository supplies it |
| `huggingface_hub` | model repository and checkpoint download | P1 | Pin repository revision and hash model files |
| `transformers` | model loading and multimodal inference | P1 | Version compatibility varies significantly by model |
| `accelerate` | multi-device inference/training helpers | P2 | Optional model orchestration |
| `timm` | vision model backbone library | P2 | Many research repos depend on it |
| `onnx` / `onnxruntime` | portable model graph and inference | P2 | Use GPU provider only when the graph/operators are supported |
| `bitsandbytes` | quantization/memory reduction | P2 | Check accelerator/backend support; don't assume CUDA-only wheels cover ROCm |

### Recommended metric package set

- `scikit-image`: MSE, NRMSE, PSNR, SSIM, Hausdorff and segmentation measures.
- `lpips`: deep-feature perceptual similarity for image/ROI comparison.
- `torchmetrics`: a consistent metric interface when already in PyTorch.
- `vmaf` / `libvmaf`: video quality for delivered compressed-video comparisons, not the primary measure of editable HTML animation fidelity.
- Custom NumPy/OpenCV routines: mask IoU, contour overlap, centroid/box error, text region geometry, trajectory RMSE, velocity/acceleration error, event-time offset and temporal flicker.

`scikit-image` documents structural similarity, normalized RMSE and PSNR; Netflix VMAF includes PSNR/SSIM-family metrics and introduced an HDR VMAF-v1 model in October 2026. [R12–R13]

---

# 8. Detection, segmentation, persistent object identity and tracking

This subsystem discovers elements, produces masks/tracklets and reconciles temporary model identities into stable `EL-ID`s.

## 8.1 Open-vocabulary detection and visual understanding

| Package/model | Function | Priority | Caveat / use |
|---|---|---|---|
| **Grounding DINO** | phrase-conditioned object localization | P1 | Use to propose boxes/regions; not a persistent tracker |
| **Florence-2** | image understanding, grounding, OCR-related tasks | P1 | Model/task support and weight license must be checked per checkpoint |
| **OWLv2** | open-vocabulary object detection | P2 | Alternative detector; compare on actual motion graphics |
| **DINOv3** | strong general visual features | P2 | Feature backbone/descriptor, not a ready-to-use tracker by itself |
| **DETR / RT-DETR family** | object detection | P2 | Useful for known object categories; not ideal for abstract graphic elements without tuning |
| **MMDetection** | modular detector ecosystem | P2 | Strong research toolkit; MMCV/torch wheel compatibility is nontrivial |
| **Detectron2** | detection/segmentation research framework | P2 | Build from source often needed; confirm current PyTorch compatibility |
| **Ultralytics** | YOLO detectors, segmentation, pose | P2 | AGPL-3.0 applies to code and trained models under its published licensing guidance; commercial/proprietary usage may require a separate license |

Grounding DINO's official repo: `IDEA-Research/GroundingDINO`. MMDetection and Detectron2 are useful framework ecosystems, but install from their current source instructions rather than copying old version-specific commands. Ultralytics' licensing page must be reviewed before use in private/commercial systems. [R14–R16]

## 8.2 Video segmentation

| Package/model | Role | Priority | Recommendation |
|---|---|---|---|
| **SAM 3.1** | text/visual promptable segmentation and multi-object video tracking | P1 / advanced | First candidate where hardware, access and license permit |
| **SAM 2.1** | video mask propagation and object segmentation | P1 fallback | Mature fallback and benchmark alternative |
| **Grounded SAM pipeline** | combine text detector and SAM-family masks | P1 | Useful for prompt-to-instance workflows |
| **MobileSAM / FastSAM** | lighter promptable segmentation | P2 | Speed fallback; quality must be verified |
| **Mask2Former / Detectron2 models** | semantic/instance segmentation | P2 | For known dataset-style segmentation, not universal motion graphic masks |

### SAM 3.1 compatibility and access note

The official SAM 3 repo documents Python 3.12+, PyTorch 2.7+ and a CUDA-capable GPU with CUDA 12.6+; its example install pins a specific PyTorch/torchvision and CUDA wheel combination. SAM 3.1 weights are published through the Meta Hugging Face model repository, where model access requires acceptance of terms and sharing Hugging Face account information. The code repository and checkpoint terms must both be reviewed. Keep it in a separate environment and do not assume the model is Apache/MIT merely because surrounding tooling is open source. [R17–R18]

### Why SAM 2 remains in the catalogue

SAM 2's official install requires Linux, Python 3.10+, PyTorch 2.5.1+ and a matching torchvision, with CUDA toolkit matching the PyTorch build when compiling its extension. It can skip compiling the custom CUDA extension for some workflows. Use SAM 2.1 as a separate tested profile, not as an automatic import into the SAM 3 environment. [R19]

## 8.3 Identity and multi-object tracking

| Tool | Role | Priority |
|---|---|---|
| SAM 3.1 Object Multiplex | joint multi-object mask propagation | P1 |
| SAM 2 video predictor | mask-based temporal propagation | P1 |
| CoTracker 3 | dense/sparse point tracks on video | P1 |
| TAPIR / TAPNet | point tracking across occlusion and reappearance | P1 |
| OpenCV KLT / pyramidal Lucas–Kanade | lightweight point tracking | P0 classical |
| OpenCV CSRT/KCF/MOSSE (where built) | object box tracking | P2 |
| ByteTrack | associate detections to tracklets | P2 |
| BoT-SORT | tracking-by-detection with camera-motion compensation | P2 |
| Norfair | configurable point/object tracker | P2 |
| `motmetrics` | evaluate tracking metrics | P2 |
| `lap` / SciPy assignment | data association assignment | P1 |
| `filterpy` | Kalman filtering | P1 |

CoTracker 3 tracks points selected by a user or sampled over a grid. TAPIR provides point tracking with matching and refinement stages. These are different from mask segmentation: use them to preserve local landmarks, motion vectors and correspondences, then reconcile identities with geometry, appearance and scene structure. [R20–R21]

### Persistent identity rules

A model's `track_id` is a temporary `TRK-ID`, not an element identity. Reconcile candidate identity using:

- temporal position and velocity continuity;
- mask/contour IoU after motion compensation;
- appearance descriptor similarity;
- shape, colour and internal landmark configuration;
- known parent-child/group relationships;
- occlusion ordering and plausible re-entry location;
- scene cuts and explicit animation resets;
- detector confidence and segmentation stability.

Store merge/split/re-id decisions with evidence and alternatives. Do not silently merge two visually identical circles if their motion paths show they are separate entities.

---

# 9. Motion estimation, optical flow and geometry tracking

## 9.1 Optical-flow hierarchy

| Method | Package | Best use | Priority |
|---|---|---|---|
| DIS optical flow | OpenCV | fast, classical dense flow | P0 |
| Farnebäck | OpenCV | classical dense flow, smooth motion | P0 fallback |
| Lucas–Kanade | OpenCV | sparse points and local trajectories | P0 |
| RAFT small/large | Torchvision | learned dense optical flow for hard cases | P1 |
| GMFlow | research package | global matching optical flow | P2 |
| FlowFormer/FlowFormer++ | research package | challenging dense flow | P2 |
| CoTracker 3 | PyTorch | long-range point trajectories | P1 |
| TAPIR | PyTorch/JAX implementations | point tracks under occlusion | P1 |

Use DIS/LK for low-cost, explainable measurements. Escalate to RAFT or a point tracker only when the classical residual or track confidence falls below a measured threshold. Torchvision publishes `raft_small` and `raft_large` builders with pretrained weights. [R22]

## 9.2 Geometric estimation

- OpenCV: affine transforms, homography, feature detection, contours, phase correlation, robust estimation, camera motion compensation.
- `scipy.optimize`: fit transforms, trajectories, blur, colour fields and physical parameters.
- `shapely`: planar geometry, intersections, containment and masks.
- `svgpathtools` / `svgpathtools`-style path libraries: path parsing, geometric measurement and Bézier evaluation.
- `pyclipper`: polygon offsets and clipping.
- `filterpy`: Kalman filters where appropriate.
- `sklearn`: PCA, clustering and descriptors.

Separate coordinate spaces explicitly: source pixels, stage/logical coordinates, normalized coordinates, camera coordinates, local element coordinates, parent coordinates and clip/mask coordinates.

---

# 10. Depth, camera reconstruction, SfM, MVS and 3D-from-video

This is the bridge from a flat motion graphic to 2.5D/3D reconstruction. Do not activate these tools for a simple title card.

## 10.1 Monocular and video depth

| Package/model | Role | Priority | Limitation |
|---|---|---|---|
| Depth Anything V2 | single-image relative depth | P1 |
| Video Depth Anything | temporally consistent depth over long videos | P1 |
| Metric Video Depth Anything | metric-depth variant where supported | P2 |
| UniDepth / UniDepthV2 | metric monocular depth estimation | P2 |
| Depth Pro | sharp metric depth estimation | P2 |
| MoGe / MoGe-2 | geometry/depth estimation | P2 |
| DSINE / normal estimators | surface normal cues | P2 |
| MiDaS | established relative-depth baseline | P2 legacy baseline |

Video Depth Anything publishes small/base/large relative and metric variants and supports long videos; it requires its own checkpoints and repository environment. Use estimated depth for relative ordering and parallax hypotheses unless the model supplies calibrated metric depth and calibration assumptions are documented. [R23]

## 10.2 Photogrammetry and structure from motion

| Package | Role | Priority | Notes |
|---|---|---|---|
| **COLMAP** | feature extraction/matching, SfM, MVS, camera and sparse/dense reconstruction | P1 |
| `pycolmap` | Python API to COLMAP | P1 |
| **OpenMVG** | SfM and camera reconstruction | P2 alternative |
| **OpenMVS** | dense point cloud, mesh and texture reconstruction | P2 companion to OpenMVG/COLMAP |
| **AliceVision** | photogrammetry framework | P2 |
| **Meshroom** | node-based GUI workflow on AliceVision | P2 |
| **hloc** | hierarchical localization with learned local features | P2 |
| **LightGlue** | learned feature matching | P2 |
| SuperPoint / DISK / ALIKED / LoFTR | feature detection/matching families | P2 |
| OpenCV calibration | lens/camera calibration, planar tracking | P0 |

COLMAP is a strong default for multi-view reconstruction, but default distribution packages may lack CUDA or HIP; upstream's current Debian/Ubuntu build guide describes CUDA/HIP source-build options. Meshroom uses AliceVision binaries and optional model assets; it has its own Qt/PySide and binary dependencies. [R10, R24–R25]

### Video-to-3D workflow

1. Detect shots and choose a sufficiently textured/static or slowly moving scene.
2. Identify motion blur, rolling shutter, zoom changes, focus changes and moving objects.
3. Calibrate or estimate camera intrinsics; use fixed-camera assumptions only if evidenced.
4. Extract keyframes/frames with original PTS records, plus image files for SfM.
5. Run feature detection and matching; inspect inlier distribution.
6. Estimate camera poses and sparse points.
7. Run dense MVS only when the clip has enough baseline/parallax and static scene content.
8. Segment moving foreground and mask it from static-scene camera solve when required.
9. Import cameras/points/meshes into Blender; preserve world scale, camera intrinsics and coordinate conversion metadata.
10. Compare projected landmarks and reprojection residuals against the original frames.

## 10.3 Point clouds and mesh processing

| Package | Role | Priority |
|---|---|---|
| Open3D | point cloud, registration, ICP, TSDF, mesh and RGB-D processing | P1 |
| CloudCompare | manual point-cloud inspection/registration/measurement | P1 desktop |
| MeshLab / PyMeshLab | mesh clean-up, normals, decimation and filtering | P1 |
| `trimesh` | Python mesh/scene loading and analysis | P1 |
| `meshio` | mesh interchange | P2 |
| `pyvista` / VTK | mesh, volume and scientific 3D visualization | P2 |
| `pymeshlab` | MeshLab filters in Python | P2 |
| `manifold3d` | robust mesh booleans | P2 |
| `libigl` / `igl` | geometry processing algorithms | P2 |
| CGAL | robust computational geometry and meshing | P2 native |
| `pyrender` | basic Python rendering and visualization | P2 |

Open3D distributes Python packages and supports Ubuntu 22.04+; the standard x86-64 Linux wheel includes CUDA support in current docs, while CPU-only wheels are also available. Verify exact wheel and Python compatibility; if Debian is not explicitly listed for your chosen build, use source build or CPU wheel rather than assuming support. [R26]

---

# 11. Blender: primary 3D and 2.5D workhorse

**Recommendation: make Blender a first-class component of the stack.** It is not merely a final renderer: it can be used to investigate camera motion, recreate geometry, place 2D layers in 3D space, build procedural systems, render comparison passes, import reconstructed assets and script repeatable scenes.

## 11.1 Why Blender belongs in Agent 2

Blender provides, within one application:

- mesh and curve modelling;
- camera and object tracking tools;
- animation/action system and constraints;
- rigging, armatures and skinning;
- Geometry Nodes for procedural geometry and particle-like systems;
- Grease Pencil for 2D drawing/animation in a 3D scene;
- EEVEE for real-time rendering;
- Cycles for path-traced rendering;
- shader/material nodes;
- compositor node graph;
- video sequence editor;
- Python API (`bpy`, `mathutils`, `bmesh`, `gpu`);
- import/export and pipeline formats including USD, Alembic, glTF and image sequences.

Blender 5.3.0 was released 10 November 2026. Its 5.3 release adds native import and render support for 3D Gaussian Splats from PLY/SPZ (and glTF support in the release information), point-cloud/Geometry Nodes integration, compositor effect stacks, improvements to USD and Alembic I/O, and OpenTimelineIO support work in the Video Sequencer. [R27–R30]

## 11.2 Recommended Blender installation on Debian/Ubuntu

For current production features, prefer the official Blender Linux release archive or the official distribution channel and pin the exact version. The distro APT package can be behind the current upstream release. Blender's current requirements list Linux glibc 2.28+, a 64-bit CPU with SSE4.2, and GPU/display requirements; verify the exact 5.3 requirement page before deployment. [R31]

Recommended policy:

- Keep one known-good production Blender version.
- Test new Blender releases in a separate directory/profile before promoting.
- Use the Blender binary's own Python for all `bpy` work.
- Record `bpy.app.version_string`, build hash, render engine, GPU backend and OCIO config.
- Use `blender -b file.blend --python script.py` for deterministic headless scene generation/rendering.
- Use EXR or another high-bit-depth intermediate for analysis when appropriate; convert to the target display space explicitly.

Example headless commands:

```bash
# Inspect version
blender --version

# Execute an analysis/reconstruction script without opening the UI
blender -b --python scripts/analyse_scene.py -- input.mp4

# Open a .blend and render frames 1..120 in background
blender -b reconstructed_scene.blend -s 1 -e 120 -a

# Render one frame to OpenEXR
blender -b reconstructed_scene.blend -o //renders/frame_##### -F OPEN_EXR -f 24
```

Blender documents background rendering with `-b`, single-frame `-f`, animation `-a`, frame range flags and OpenEXR output. [R32]

## 11.3 Blender workflow by dimensionality

### 2D reconstruction

Use Blender when the source has camera-space or layered depth effects, but prefer DOM/SVG/Canvas for primarily 2D typography and UI. Blender Grease Pencil and curves can help inspect and rebuild shapes, paths and hand-drawn animation. For clean vector type, keep original fonts/SVG paths in the browser implementation where possible.

### 2.5D reconstruction

- Create depth cards/planes with measured transforms.
- Parent each plane to a camera or local group deliberately.
- Reconstruct camera pan/zoom/orbit from tracks rather than keying by eye.
- Use alpha planes and shadow-catching surfaces for composited elements.
- Export glTF or USD only if the final runtime needs a portable 3D model.
- For browser delivery, include the 3D asset as embedded glTF/GLB data and drive it from a deterministic master timeline; otherwise use a documented bounded render plate only when unavoidable.

### True 3D reconstruction

- Recover camera intrinsics/extrinsics from the footage where possible.
- Use measured silhouette, landmarks, perspective lines, reflections and shadow vectors to fit geometry and camera.
- Build procedural systems with Geometry Nodes where the source indicates procedural dynamics.
- Reconstruct materials in linear colour space; record roughness/metallic/IOR/emission assumptions and confidence.
- Use EEVEE for rapid iteration and Cycles for reference/diagnostic renders where path tracing materially improves comparison.
- Render separate passes (diffuse, specular, emission, normal, depth, cryptomatte/object masks) to diagnose residual errors.

### 3D Gaussian splats and NeRFs

Blender 5.3's initial Gaussian-splat support makes it a strong inspection and compositing endpoint for video-derived 3D captures. Use COLMAP/gsplat/Nerfstudio to reconstruct/train splats where appropriate, then import PLY/SPZ into Blender. A Gaussian cloud is not a watertight mesh; it may not support conventional modelling, collision, UV or topology workflows. Blender's own 5.3 announcement describes these as soft transparent Gaussian blobs/point-cloud data. [R27–R29]

## 11.4 Blender package and integration inventory

| Tool / package | Role | Priority |
|---|---|---|
| Blender 5.3 | primary 3D/2.5D workbench | P0 for 3D-capable production |
| `bpy` | Blender Python API | P0 inside Blender only |
| Geometry Nodes | procedural modelling and motion | P1 |
| Blender Tracking / Movie Clip Editor | 2D/3D tracking and camera solve | P1 |
| Blender Compositor | node compositing and output passes | P1 |
| Cycles / EEVEE | physically based / real-time render | P1 |
| Grease Pencil | 2D-in-3D drawing and animation | P2 |
| Blender VSE | editorial reference / test assembly | P2 |
| Blender Extensions | extension distribution mechanism | P2 |
| OpenTimelineIO | timeline interchange | P2 |
| glTF / GLB | browser-ready 3D assets | P1 |
| USD | large-scene interchange | P1 |
| Alembic | animated geometry/cache interchange | P2 |

---

# 12. 3D neural reconstruction: NeRFs and Gaussian splatting

| Package | Role | Priority | Deployment note |
|---|---|---|---|
| **Nerfstudio** | NeRF and radiance-field research/workflow framework | P1 advanced |
| **gsplat** | CUDA-accelerated Gaussian splat rasterization/training | P1 advanced |
| **nerfacc** | efficient occupancy-grid/volume rendering accelerations | P2 |
| **instant-ngp** | fast neural graphics primitives / NeRF-like workflows | P2 |
| Original 3D Gaussian Splatting code | baseline research implementation | P2 |
| Blender native splat support | import/inspect/edit/render splats | P1 if Blender 5.3+ |
| `nerfstudio` methods (e.g. Splatfacto) | train/evaluate scene representations | P1 |

Nerfstudio is explicitly oriented to Linux and recommends Conda-style environments. `gsplat` depends on PyTorch and may compile CUDA code on first use; prebuilt wheels only cover specified combinations of Python, PyTorch and CUDA. [R33–R34]

### When to choose what

- **COLMAP:** camera poses and explicit sparse/dense geometry from photographs/video with sufficient parallax.
- **OpenMVS:** dense surface reconstruction/mesh/texture after SfM.
- **Video Depth Anything:** continuous monocular depth maps when video is the input and parallax is limited.
- **Nerfstudio / gsplat:** view synthesis and radiance-field reconstruction where novel-view appearance matters more than editable polygon topology.
- **Blender:** inspection, look-development, composition, relighting, camera alignment, asset cleanup and final rendering.
- **Three.js:** runtime rendering in the final HTML if 3D remains part of the editable output.

For a 2D motion graphic with an artificial camera move, COLMAP/NeRF may be completely unnecessary. Do not invoke a reconstruction class without an evidence reason.

---

# 13. 2D graphics, raster reconstruction, vectors and typography

## 13.1 Applications

| Application | Main role | Priority |
|---|---|---|
| **Krita** | raster painting, frame-by-frame animation, paint/cleanup | P1 desktop |
| **Inkscape** | SVG authoring, vector path inspection and export | P1 desktop |
| **GIMP** | raster retouching, masks and image cleanup | P1 desktop |
| **ImageMagick** | CLI image manipulation, montages and conversion | P1 |
| **Pencil2D** | lightweight hand-drawn animation | P2 |
| **Tahoma2D** | 2D and stop-motion animation, cut-out and FX nodes | P2 |
| **OpenToonz** | full-featured 2D animation pipeline | P2 |
| **Synfig Studio** | vector/bitmap tween-based 2D animation | P2 |
| **Natron** | node-based compositing with OpenFX | P2; validate project activity and plugin compatibility |

Krita's official download currently lists Linux 64-bit AppImage and Flatpak distribution. Tahoma2D lists Linux builds and current release information; Pencil2D provides Linux builds and Debian/Ubuntu installation paths; Synfig is an open-source 2D vector/bitmap animation program; OpenToonz has Linux build and distribution paths. [R35–R39]

## 13.2 Python/C++ image and vector libraries

| Package | Role | Priority |
|---|---|---|
| OpenCV | image transforms, masks, contours, compositing | P0 |
| Pillow | raster manipulation | P0 |
| `pyvips` | streaming large image pipelines | P1 |
| `skia-python` | high-quality 2D raster/vector rendering | P1 |
| Cairo / `pycairo` | 2D paths, text and raster surfaces | P1 |
| Pango / `pangocffi` | layout/shaping with system text stack | P2 |
| CairoSVG | SVG to PNG/PDF/PS conversion | P1 |
| `resvg` CLI/library | SVG rasterization | P2 |
| `svgpathtools` | SVG path geometry | P1 |
| `svgwrite` | SVG generation | P2 |
| `svgelements` | SVG parsing and geometry | P2 |
| `Shapely` | planar geometry/boolean logic | P1 |
| `pyclipper` | polygon clipping/offset | P2 |
| VTracer | raster-to-vector tracing | P1 conditional |
| Potrace | bitmap-to-vector path tracing | P2 conditional |
| `fontTools` | font tables, glyph outlines and metadata | P1 |
| `uharfbuzz` | HarfBuzz text shaping from Python | P1 |
| FreeType | glyph rasterization | P1 native |
| Fontconfig | font discovery and substitution | P1 native |
| FriBidi / `python-bidi` | bidirectional text handling | P1 for RTL |

CairoSVG supports Linux and exposes both a command line and Python API. `skia-python` has Linux x86-64 and ARM64 wheels and requires OpenGL/fontconfig libraries on Linux. HarfBuzz is the shaping engine; FontTools exposes OpenType/TrueType font data. [R40–R42]

## 13.3 Typography forensics workflow

1. OCR identifies the string and text region; use the reference image as evidence, not transcript text.
2. Estimate line boxes, baseline, cap height, x-height, tracking and inter-line spacing.
3. Search candidate font files using Fontconfig (`fc-match`) and FontTools metadata.
4. Shape exact Unicode text using HarfBuzz with the correct script/language/direction/features.
5. Compare glyph IDs, advances, offsets, kerning, ligatures and cluster boundaries.
6. If font recovery is strong, keep text editable as text in the implementation.
7. If font is unavailable or logo geometry is custom, extract/trace glyph outlines and keep paths separate by glyph or semantic shape.
8. Use OCR disagreement, glyph contour residual and layout geometry as separate QA signals.
9. For Bengali, Devanagari, Arabic and other complex scripts, verify shaping with the correct fonts, language tags, Unicode normalization and bidi ordering. Do not assume character count equals glyph count.

## 13.4 Raster tracing policy

Use VTracer/Potrace only for flat, logo-like, high-contrast artwork. Do not trace blurred video edges and call the result exact vector geometry. Sample/average canonical frames, subtract local background, estimate alpha and validate the output path against the original mask. Keep photographic detail as raster or 3D texture when vector tracing would invent structure.

---

# 14. Video inpainting, restoration, interpolation and super-resolution

These are specialist tools, not default steps. They can reduce artifacts or fill occlusions, but may hallucinate detail and alter the original.

| Tool/model | Role | Priority | Correct use |
|---|---|---|---|
| **ProPainter** | video inpainting and object removal | P1 conditional | clean-plate recovery across time |
| **E2FGVI / E2FGVI-HQ** | flow-guided video inpainting | P2 alternative | compare temporal coherence and artifacts |
| **LaMa** | still-image inpainting | P2 | single-frame repair only, not a video solution |
| MAT / other image inpainting | high-res still repair | P2 | only when supported by source evidence |
| **Real-ESRGAN** | image/video frame super-resolution | P2 | visual inspection or texture upscaling; not evidence restoration |
| SwinIR | restoration/denoising/super-resolution | P2 | test for ringing/edge changes |
| RIFE | frame interpolation | P2 | visualization aid only; never use interpolated frames as source evidence |
| FILM | frame interpolation | P2 | same restriction |
| BasicVSR++ | video restoration | P2 | experimental restoration branch |
| VapourSynth plugin ecosystem | frame filtering, denoise, resize | P1 |

ProPainter and E2FGVI are research implementations with their own model/runtime requirements. Every generated fill must carry `synthetic_inpaint` provenance and must not be used as direct evidence of original geometry. [R43–R44]

**Licensing, memory and age warning:** ProPainter's upstream README states that code and models are licensed for non-commercial use only under the NTU S-Lab License 1.0; obtain permission before commercial use. [R43] Its published memory table reports roughly 19 GB VRAM for 720p/50-frame FP16 inference and 28 GB for FP32 on the authors' tested setup; actual usage varies with GPU, precision, resolution and sub-video settings, so profile your own workload. [R43] E2FGVI's published setup targets an older Python/PyTorch/CUDA/MMCV stack, so treat it as a legacy research worker in a pinned container rather than forcing its dependencies into the current media or vision environments. [R44] LaMa's upstream setup examples also rely on older PyTorch-era dependencies; isolate it and validate compatibility before use. [R72]

### Evidence-safe policy

- Preserve the unmodified original frame.
- Compute masks against original data.
- Store inpainted outputs as alternative hypotheses.
- Compare temporal flicker, edge consistency and known clean regions.
- Do not overwrite source-derived pixels in the evidence ledger.
- If inpainting produces the only plausible clean plate, mark it as inferred and lower confidence.

---

# 15. Colour science, compositing and VFX interchange

## 15.1 Essential standards and libraries

| Standard/library | Role | Priority |
|---|---|---|
| **OpenColorIO (OCIO)** | colour management and view/display transforms | P1 / production essential |
| **ACES** | scene-referred colour pipeline/configuration | P1 where applicable |
| **OpenImageIO (OIIO)** | high-bit-depth image I/O, metadata, texture processing | P1 |
| **OpenEXR** | HDR/high-dynamic-range image and multi-layer render interchange | P1 |
| **OpenVDB** | sparse volumetric data | P2 |
| **OpenSubdiv** | subdivision surfaces | P2 |
| **MaterialX** | material/look-development interchange | P2 |
| **Alembic** | baked animated geometry caches | P2 |
| **OpenUSD** | scalable scene description/interchange | P1 for multi-app 3D |
| **OpenTimelineIO** | editorial timeline interchange | P1 |
| **OpenFX** | plugin API used by compositors | P2 |
| **OpenColorIO configs** | named transform/view definitions | P1 |
| `colour-science` | Python colour calculations and transforms | P1 |
| `colour-demosaicing` | raw demosaicing analysis | P2 |

OpenColorIO is supported across major VFX applications including Blender. MaterialX is an open standard for platform-independent material/look-development content. OpenUSD is time-sampled scene description intended for scalable interchange. [R9, R45–R47]

## 15.2 Colour pipeline for comparison

1. Probe the source's primaries, transfer, matrix, range, bit depth, chroma subsampling, alpha and HDR metadata.
2. Decode with explicit pixel-format handling; do not assume 8-bit full-range sRGB.
3. Choose a declared working space (often scene-linear for compositing/lighting work).
4. Convert browser screenshots and Blender renders into a comparable space with a named OCIO/view transform.
5. Compare linear-light compositing and encoded delivery pixels separately.
6. Track tone mapping, gamut mapping, alpha premultiplication, dithering and display transform as distinct operations.
7. Use VMAF only for compressed-video delivery quality; not as the only frame-level visual similarity metric.
8. Store OCIO config path and SHA-256, transform names and output display profile in each validation run.

## 15.3 Compositing

- **Blender Compositor:** primary open-source node compositing tool.
- **Natron:** optional node compositor for OpenFX workflows; check version, plugin ABI and release activity before adopting.
- **FFmpeg filters:** image/video assembly, overlays, keying, denoise, scaling, zscale, libplacebo and VMAF where compiled.
- **VapourSynth:** scriptable frame-level processing graph.
- **OpenFX plugins:** only after testing ABI compatibility and redistribution rights.

---

# 16. Browser/runtime technology for editable reconstruction

The final Agent 2 artefact is still an offline single-file `index.html`. A browser renderer is therefore a first-class target, not just a preview.

## 16.1 Renderer selection matrix

| Source visual | Preferred output implementation | Tools |
|---|---|---|
| Text-heavy 2D / UI | DOM + CSS + SVG | browser native, GSAP/WAAPI |
| Logo / typography / vector shapes | SVG paths + DOM | SVG, FontTools-derived paths, GSAP |
| High-volume 2D shapes/sprites | Canvas 2D or WebGL sprites | PixiJS, Canvas |
| Shader/gradient/particle field | WebGL2 / GLSL | Three.js shader material, raw WebGL, PixiJS custom filter |
| 2.5D planes/parallax | Three.js scene with explicit camera/planes | Three.js, glTF |
| True 3D model/material/lighting | Three.js/WebGL runtime or embedded GLB | Three.js, glTF, custom shader |
| Complex 3D offline lookdev | Blender, then rebuild/embed required model logic in browser | Blender + GLB/USD conversion |
| Motion-design authoring | GSAP timeline or custom deterministic timeline | GSAP, Theatre.js, Motion Canvas |
| HTML-to-MP4 rendering | HyperFrames / Remotion / Playwright+FFmpeg | Optional export lane, not evidence engine |

## 16.2 Packages

| Package | Role | Priority | Notes |
|---|---|---|---|
| **Three.js** | WebGL 3D runtime, camera, geometry, shaders, GLTF | P1 |
| **PixiJS** | accelerated 2D graphics/sprites; WebGL/WebGPU renderer | P1 for 2D-heavy motion |
| **Babylon.js** | full 3D engine, WebGL/WebGPU, materials and scene tooling | P2 alternative |
| **GSAP** | timeline, easing, stagger and animation controls | P0 |
| Web Animations API | native browser animation primitives | P0 browser native |
| Anime.js | compact animation/tween library | P2 alternative |
| Motion One | lightweight browser motion tools | P2 alternative |
| Theatre.js | keyframe/timeline authoring and exported project state | P2 |
| Motion Canvas | TypeScript/React-like motion graphics and FFmpeg export | P2 |
| Remotion | React programmatic video composition | P2; review commercial licensing for team/automation |
| HyperFrames | agent-native HTML-to-video rendering | P1 if MP4 export is required |
| Lottie Web | render Lottie JSON animations | P2 for existing animation assets |
| Vite | development/bundling | P1 |
| `vite-plugin-singlefile` | inline HTML/CSS/JS bundle | P1 build helper; still audit all assets |
| Playwright | deterministic browser automation and screenshot validation | P0 |
| Puppeteer | Chrome automation alternative | P2 if Node-only pipeline |
| Chromium | browser rendering engine | P0 |

PixiJS docs describe WebGL/WebGL2 as stable/recommended and WebGPU as still maturing; treat WebGPU as a tested opt-in, not a guaranteed production baseline. Playwright documents Debian 12/13 and Ubuntu 22.04/24.04/26.04 as supported Linux targets, and it installs matching browser binaries plus system dependencies. [R48–R50]

## 16.3 HyperFrames, Remotion and Motion Canvas

- **HyperFrames:** relevant to the earlier research and a natural local HTML-to-video workflow. Current project materials describe an open-source, agent-native HTML-to-video system using browser code, timing attributes and Node/FFmpeg; use the locally runnable CLI path only after pinning Node and FFmpeg versions. It is a rendering/export layer, not a forensic measurement framework. [R51]
- **Remotion:** good when the output itself is React-based video. It has a more explicit commercial licensing model for larger teams and video automation; read the current licence/pricing terms before commercial use. [R52]
- **Motion Canvas:** a TypeScript motion graphics framework with an FFmpeg exporter; its documentation describes the exporter as relatively new. Useful for authored vector/UI motion, but the existing Agent 2 `index.html` requirement may make it a development method rather than the final runtime. [R53]
- **Theatre.js:** useful for keyframe authoring and storing timeline state as JSON. Ensure the final production render uses an absolute time input rather than editor-local playback state. [R54]

## 16.4 Single-file build warning

`vite-plugin-singlefile` inlines recognized bundles but does not guarantee all static assets are embedded; public-folder files and SVG handling have caveats, and unrecognized files may remain external. Final packaging must parse the HTML, scan URLs and network requests, open via `file://`, and verify that there are exactly two files in the Agent 2 ZIP. [R55]

## 16.5 Deterministic browser animation contract

Every animated property must be a function of absolute segment time:

```js
function renderAt(t) {
  const time = clamp(t, 0, duration);
  setCamera(cameraAt(time));
  setBackground(backgroundAt(time));
  setLighting(lightingAt(time));
  setHeroElements(heroStateAt(time));
  setParticles(particleStateAt(time, seed));
  setForeground(foregroundStateAt(time));
  renderFrame();
}
```

No animation may depend on accumulated delta time, previous frame state, unseeded random calls or browser CSS transitions. For a particle, use an analytic `state(seed, t)` function or a precomputed deterministic table. Verify non-monotonic seeking by rendering times in different orders and comparing the identical timestamp outputs.

---

# 17. OCR, local vision-language models and agentic analysis

AI vision is an interpretation layer. It must be paired with measurable outputs and must never replace the original frame or evidence ledger.

## 17.1 OCR and text extraction

| Tool | Role | Priority | Notes |
|---|---|---|---|
| **PaddleOCR 3.x** | text detection/recognition and structured OCR | P1 |
| **Tesseract 5** | traditional OCR baseline | P0 fallback |
| EasyOCR | multi-language OCR alternative | P2 |
| docTR | OCR pipeline alternative | P2 |
| Transformers OCR models | task-specific OCR/visual-language | P2 |
| FontTools + HarfBuzz | typography reconstruction after recognition | P1 |

PaddleOCR 3.x supports PaddlePaddle and Transformers inference paths. Its official install guide warns that GPU installation depends on CUDA/driver compatibility; install the correct PaddlePaddle build first, then PaddleOCR, in an isolated environment. [R56–R57]

## 17.2 Local vision-language models

| Framework/model family | Role | Priority | Use |
|---|---|---|---|
| Hugging Face Transformers | local vision-language and multimodal model loading | P1 |
| Qwen3-VL family | visual reasoning, image/video understanding, spatial/video interpretation | P1 conditional |
| Florence-2 | grounded visual tasks and OCR-adjacent tasks | P1 |
| vLLM | high-throughput local GPU model serving | P2, server/multi-user |
| llama.cpp | local CPU/GPU quantized model inference | P2 |
| Ollama | simple local model serving | P2 |
| OpenVINO | Intel inference optimisation | P2 |
| ONNX Runtime | cross-platform model inference | P2 |

Use a vision-language model to propose hypotheses: “this layer seems to rotate,” “the logo has three independent pieces,” or “there is a masked wipe.” Then verify with image measurements, tracking, frame comparison and human review. Do not ask a VLM to estimate a 1.5-pixel movement when OpenCV can measure it.

vLLM's Qwen3-VL recipe documents local serving and notes the flagship 235B MoE variant needs multiple high-memory GPUs; choose model size based on actual hardware rather than treating the largest model as a standard dependency. [R58]

## 17.3 Model serving architecture

- For a single workstation: direct Python inference in a dedicated environment is simplest.
- For reusable local services: use a local process/API with pinned model worker; maintain request/result schemas.
- For multiple jobs/users: vLLM or a managed worker queue can serve a shared model.
- For lightweight local assistants: Ollama or llama.cpp may be convenient, but validate multimodal support and GPU backend for the specific model.
- Model outputs must include model ID, revision, prompt/template version, input frame IDs, inference settings and confidence/uncertainty.

---

# 18. Audio and temporal cue analysis (optional for visual reconstruction)

Audio analysis can reveal cut points, impacts, whooshes, beat synchronization, speech boundaries and motion accents. The visual-accuracy HTML deliverable may still omit audio playback, as defined by Agent 2.

| Tool | Role | Priority |
|---|---|---|
| FFmpeg / PyAV | decode audio streams and preserve timing | P0 |
| librosa | onset, tempo, spectral features, beat tracking | P1 |
| Essentia | C++/Python audio and music information retrieval | P1 |
| faster-whisper | local speech transcription/alignment | P1 |
| WhisperX | word alignment and speaker-related workflow | P2 |
| pyannote.audio | speaker diarization and speech activity | P2 |
| torchaudio | PyTorch audio I/O/transforms | P2 |
| aubio | onset/pitch/tempo utilities | P2 |
| Rhubarb Lip Sync | mouth cue generation from speech | P2 |
| Demucs | source separation | P2 conditional |

Essentia is a C++ audio analysis/MIR library with Python and JavaScript bindings, but it is AGPLv3 unless commercially licensed; check this carefully for proprietary deployment. faster-whisper uses CTranslate2 and PyAV; its current GPU README specifies cuBLAS for CUDA 12 and cuDNN 9 requirements. pyannote.audio uses PyTorch models and may require gated model access. [R59–R62]

---

# 19. Dataset curation, annotation and human-in-the-loop inspection

| Tool | Role | Priority |
|---|---|---|
| **FiftyOne** | dataset/frame/sample inspection, model evaluation and visual search | P1 |
| **CVAT** | video/image annotation, masks, boxes, tracks | P1 |
| **Label Studio** | flexible human annotation and review | P2 |
| **napari** | n-dimensional image/mask/label inspection | P1 |
| CloudCompare | point-cloud inspection and manual annotation | P2 |
| MeshLab | mesh review and manual cleanup | P2 |

Use a human review UI to resolve uncertain IDs, occlusions, text reading and camera hypotheses. Keep reviewer decisions as explicit evidence records, not hidden edits to model outputs. CVAT and Label Studio are useful when a project has repeated datasets or multiple reviewers; they are not mandatory for every one-segment reverse-engineering job. Label Studio documents pip, Docker and Ubuntu installation paths and recommends a clean environment. [R63]

---

# 20. Storage, caching, orchestration and experiment management

## 20.1 Local-first data storage

| Tool | Role | Priority |
|---|---|---|
| SQLite | job manifest, run metadata and small relational data | P0 |
| DuckDB | analytical SQL over metrics and Parquet | P1 |
| Parquet / PyArrow | columnar metric and event ledger storage | P1 |
| Zarr | chunked arrays, image volumes and large intermediate data | P1 |
| HDF5 / h5py | scientific arrays and model outputs | P2 |
| NumPy `.npy` / `.npz` | compact intermediate measurements | P0 |
| Git + Git LFS | source and selected large asset versioning | P1 |
| DVC | versioned datasets, model artifacts and reproducible pipelines | P1 |
| DataLad / git-annex | managing large distributed datasets | P2 |

Use content-addressable storage for extracted frames, masks and model outputs. Store hashes and references in the ledger rather than copying identical assets into every run.

## 20.2 Workflow orchestration

| Tool | Role | Recommendation |
|---|---|---|
| Plain Python CLI + Make | single-user linear pipeline | best initial production baseline |
| Prefect | Python flow orchestration, retries, observability | P1 when pipelines become multi-step/recoverable |
| Dagster | asset-centric data/ML pipelines | P2 for team/data platform |
| Ray | distributed inference/parallel jobs/multi-GPU workloads | P2; use only after profiling |
| Celery + Redis/RabbitMQ | asynchronous worker queues | P2 service architecture |
| FastAPI | local API around analysis/render workers | P1 if UI or agent integration needs an API |
| MLflow | run/parameter/metric/model tracking | P1 |
| DVC | data and pipeline reproducibility | P1 |

MLflow can track runs locally using a SQLite-backed tracking server; DVC versions datasets and pipelines while relying on Git plus an external data cache. [R64–R65]

### Orchestration rule

The original sequential per-second reconstruction gate must remain logically sequential. Parallelize independent frame decoding, detector inference or asset analysis, but do not let `S(n+1)` be accepted before `S(n)` and its required boundary regressions pass.

---

# 21. Browser QA, unit tests, performance and observability

## 21.1 Core tests

| Package | Job | Priority |
|---|---|---|
| pytest | Python test runner | P0 |
| Hypothesis | property-based tests | P1 |
| pytest-xdist | parallel independent tests | P2 |
| pytest-cov / coverage | coverage | P1 |
| Ruff | lint/format/import hygiene | P1 |
| mypy / Pyright | type checking | P1 |
| pre-commit | automated quality hooks | P1 |
| JSON Schema validator | Scene IR contract checks | P0 |
| Playwright | real Chromium screenshots and seek tests | P0 |
| pixelmatch / resemble-style diff | browser image diff | P2 |
| `pytest-playwright` | browser fixtures and test integration | P1 |

Playwright's browser binaries are tied to Playwright releases; update the browser install after updating Playwright. Its documentation provides `playwright install --with-deps chromium` for browser/system dependencies and lists the Debian/Ubuntu target versions. [R49–R50]

## 21.2 Deterministic seek torture test

For a set of times such as `0`, `0.2`, `1.0`, `3.25`, `D-1/frame_rate`, and `D`, render in this order:

`0 → D → 0.72D → 0.15D → 3.25 → 0 → D`

Render a target time (for example 3.25 seconds) from different previous times and compare the pixels. Identical inputs at the same time and seed must be pixel-identical within the declared browser/GPU tolerance. If GPU shader nondeterminism is present, document the tolerance and test repeated renders on the same hardware/runtime.

## 21.3 Performance and profiling tools

| Tool | Role |
|---|---|
| `perf` | Linux CPU counters and profiling |
| `py-spy` | Python sampling profiler |
| Scalene | CPU/GPU/memory profiling |
| Memray | Python/native memory profiling |
| Nsight Systems | NVIDIA system-wide profiling |
| Nsight Compute | CUDA kernel profiling |
| `rocprof` / ROCm profiling tools | AMD GPU profiling |
| `nvtop` / `btop` / `htop` | live resource monitoring |
| RenderDoc | graphics API frame capture |
| apitrace | OpenGL trace/replay diagnostics |
| Tracy | low-level CPU/GPU frame profiling |
| Blender profiling tools | render/scene performance |

## 21.4 Visual QA metric groups

Never reduce all quality to one scalar score. Keep these separate:

1. Pixel: MAE, MSE, RMSE, NRMSE, PSNR.
2. Structure: SSIM/MS-SSIM.
3. Perceptual: LPIPS / VMAF for suitable use cases.
4. Geometry: mask IoU, contour overlap, centroid and bounding-box deltas, Hausdorff distance.
5. Typography: OCR string agreement, line boxes, baseline, glyph silhouette, word/glyph spacing.
6. Motion: trajectory error, velocity/acceleration mismatch, optical-flow residual.
7. Timing: event onset/offset error in PTS, hold duration and beat alignment.
8. Temporal: flicker, frame-to-frame residual, transition continuity and seek consistency.
9. Colour: colour-managed regional error, hue/chroma/lightness difference and HDR handling.
10. Evidence confidence: observed vs derived vs inferred, model disagreements and sampling adequacy.

Thresholds must be calibrated to source resolution, codec, bit depth, antialiasing, renderer and content class. A single universal RMSE/IoU threshold is not valid for a photographic plate, crisp text, motion blur and procedural gradient simultaneously.

---

# 22. Containers, deployment and system services

## 22.1 Container recommendations

- **Docker Engine:** broad ecosystem; GPU access via NVIDIA Container Toolkit where applicable.
- **Podman:** rootless-friendly alternative; validate NVIDIA/ROCm GPU access on the actual host.
- **Apptainer/Singularity:** useful on HPC/cluster systems and shared compute.
- **NVIDIA Container Toolkit:** exposes host NVIDIA GPUs to container workloads.

Docker documents installation support for Debian 12/13 and Ubuntu 22.04/24.04/26.04/26.10. NVIDIA's toolkit install guide supports APT-based Ubuntu/Debian host setup. [R8, R66–R67]

### Container boundary rule

The host owns the kernel, GPU driver and device nodes. Containers own userland libraries and model environments. Do not install a second kernel driver inside a container. Keep CUDA/ROCm images matched to the supported host driver and GPU path.

## 22.2 Production service building blocks (only if needed)

- FastAPI for internal endpoints.
- PostgreSQL for team metadata; SQLite for single-user local runs.
- Redis/RabbitMQ only if using async distributed workers.
- MinIO/S3-compatible object storage only when asset volume or multi-host coordination demands it.
- Prometheus/Grafana/OpenTelemetry when operating a long-running service, not necessary for a single-user local tool.
- systemd user/system services for model workers and API services.

Do not introduce Kubernetes for a single workstation. Docker Compose is generally sufficient for a local multi-service deployment.

---

# 23. APT package profiles and what not to install together

## 23.1 Suggested profiles

| Profile | Native host packages | Python/model layer | Use case |
|---|---|---|---|
| **Minimal forensic workstation** | core tools, FFmpeg, fonts, browser deps | media-core | PTS, metadata, frame analysis and measurements |
| **CV production** | OpenCV/native libs, compiler, FFmpeg | PyTorch + OpenCV + tracking | segmentation, tracking, flow, detections |
| **Typography/2D** | fontconfig, FreeType, HarfBuzz, Cairo/Pango, Inkscape/Krita | FontTools, uharfbuzz, OCR | text/vector reconstruction |
| **3D reconstruction** | Blender, COLMAP dependencies, OpenEXR/OIIO/OCIO, Vulkan/OpenGL | pycolmap, Open3D, hloc/LightGlue, depth | SfM/MVS, depth, 3D layout and lookdev |
| **Neural rendering** | CUDA or ROCm host stack | gsplat/Nerfstudio/selected Torch profile | NeRF/3DGS training and rendering |
| **Browser rendering** | Chromium dependencies, FFmpeg | Playwright + Node LTS | exact-time screenshots and HTML export |
| **Audio analysis** | FFmpeg and audio libs | librosa/Essentia/Whisper | audio cue evidence |

## 23.2 Avoid these environment mistakes

- Installing multiple OpenCV Python wheels in one environment.
- Mixing APT Python packages and pip wheels without controlling interpreter paths.
- Installing CUDA Toolkit from a `.run` file over APT driver packages.
- Mixing CUDA and ROCm extensions in one environment.
- Using one Python environment for SAM 3, SAM 2, PaddlePaddle, Open3D, VTK and Blender scripting.
- Running Blender's `bpy` with a different system Python ABI.
- Installing every optional plugin for VapourSynth/FFmpeg.
- Using `pip install -U` in a frozen production environment.
- Using editable Git main branches in a released pipeline.
- Adding all assets into the final HTML build without measuring file size and browser decode cost.
- Treating a package name as proof that its model weights are licensed for the target use.

---

# 24. Recommended production stack: what I would actually standardize

This is the high-capability stack I recommend as the default design for a serious Linux workstation. It is not a claim that every optional package must be enabled at once.

## 24.1 Core foundation — always installed

- Debian 13.7 or Ubuntu 26.04 LTS.
- APT build tools: GCC/G++, CMake, Ninja, pkg-config, Git, Git LFS.
- FFmpeg/ffprobe, MediaInfo, ExifTool.
- Python via `uv` or micromamba; no system-Python pip writes.
- PyAV, NumPy, SciPy, OpenCV, PySceneDetect, Pillow, scikit-image.
- Pydantic + JSON Schema for the canonical Scene IR.
- SQLite and Parquet/PyArrow for provenance/measurement data.
- Playwright + Chromium, pytest, Hypothesis.
- Node.js 26 LTS and a pinned npm/pnpm lockfile for browser components.
- Blender 5.3.x installed side-by-side with a pinned build for 3D-capable reconstruction.

## 24.2 Visual AI — install as isolated workers

- PyTorch + torchvision from the official selector.
- SAM 3.1 as primary candidate after license/access and GPU qualification.
- SAM 2.1 as separately pinned fallback.
- Grounding DINO for text-guided detections.
- CoTracker 3 or TAPIR for point trajectories.
- Torchvision RAFT for high-quality optical flow fallback.
- Video Depth Anything for temporal depth.
- Florence-2 or Qwen3-VL for high-level visual interpretation.
- PaddleOCR plus Tesseract as independent OCR engines.

## 24.3 3D reconstruction and rendering

- Blender 5.3.x as main 3D/2.5D authoring, camera, Geometry Nodes, compositing and rendering engine.
- COLMAP + pycolmap as main SfM/camera-reconstruction stack.
- OpenMVS/OpenMVG/AliceVision when the task requires a different MVS/SfM route.
- Open3D + CloudCompare/MeshLab for point clouds/mesh inspection.
- gsplat + Nerfstudio for Gaussian splatting/NeRF research workflows.
- OpenUSD, OpenColorIO, OpenImageIO, OpenEXR, MaterialX and Alembic for interchange and VFX pipeline.

## 24.4 Browser implementation

- DOM/CSS/SVG for typography and UI.
- GSAP for deterministic animation curves only if its state is controlled by `renderAt(t)`.
- Three.js for 2.5D/3D models and shaders.
- PixiJS for dense 2D sprites/particles.
- Vite + single-file bundling as a build tool, then explicit audit of every asset.
- Playwright screenshot/seek tests.
- HyperFrames as optional MP4 export layer where local HTML-to-video workflow is useful.

## 24.5 Optional advanced stacks

- ProPainter / E2FGVI for temporally coherent clean-plate work.
- LaMa for one-frame patch repair.
- LPIPS and VMAF for complementary perceptual QA.
- OpenColorIO + ACES transforms for colour-managed evaluation.
- OpenTimelineIO when receiving/exporting editorial sequences.
- Librosa / Essentia / faster-whisper / pyannote for audio and speech evidence.
- FiftyOne / CVAT / Label Studio / napari for human review and annotation.
- MLflow / DVC / Prefect / Ray when experiment/data scale justifies them.

---

# 25. Installation sequence and reproducible setup examples

These commands illustrate a safe order. Verify version-specific instructions before deploying a new model or GPU stack.

## 25.1 Host preparation

```bash
sudo apt update
sudo apt full-upgrade -y
sudo apt install -y \
  build-essential gcc g++ clang cmake ninja-build meson pkg-config \
  git git-lfs curl wget ca-certificates gnupg jq ripgrep \
  unzip zip p7zip-full xz-utils zstd rsync \
  python3 python3-full python3-dev python3-venv python3-pip pipx \
  ffmpeg mediainfo exiftool imagemagick \
  libgl1 libegl1 libglib2.0-0 libsm6 libxext6 libxrender1 \
  libfontconfig1 libfreetype6 libharfbuzz0b libxkbcommon0 libnss3 libgbm1
```

Install GPU driver separately using the vendor's supported instructions. Reboot if a kernel/driver update requires it, then verify the GPU before installing ML frameworks.

## 25.2 Install uv and create an isolated media-core environment

Follow the current uv installation page. Example shell bootstrap (verify the downloaded installer/source as part of your organization's policy):

```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
uv python install 3.12
mkdir -p ~/work/agent2-linux
cd ~/work/agent2-linux
uv init --python 3.12
uv add av numpy scipy opencv-contrib-python-headless \
  pillow scikit-image scenedetect pydantic jsonschema \
  pandas pyarrow duckdb
uv lock
uv sync --frozen
```

If installing the OpenCV contrib wheel, do not also install `opencv-python` or `opencv-python-headless` in that same environment. The project lockfile is the reproducibility anchor.

## 25.3 Install PyTorch for the selected GPU

Use the official PyTorch install selector for Linux + pip + Python + the compute platform that matches the driver/runtime. Do not copy a CUDA command from an unrelated blog. The PyTorch docs state that the current stable build has a minimum Python requirement and list supported CUDA/ROCm choices dynamically. [R68]

After PyTorch, install only the packages needed for that worker. For example:

```bash
uv venv --python 3.12 .venv-vision
source .venv-vision/bin/activate
# Install torch/torchvision using the exact command produced by pytorch.org first.
# Then install the selected model repository requirements and pin them.
```

## 25.4 SAM 3.1 as a separate model worker

The official repo currently documents Python 3.12+, PyTorch 2.7+ and CUDA 12.6+; the example install is pinned to a specific torch build/CUDA wheel. Follow the current upstream repository and checkpoint access requirements exactly. [R17–R18]

Do not combine SAM 3.1 and SAM 2.1 into one environment without proving dependency compatibility. A separate venv/container per major model generation is acceptable and usually cheaper than debugging dependency contamination.

## 25.5 Browser automation

```bash
uv add playwright pytest-playwright
uv run playwright install --with-deps chromium
```

For Node-based tests, use Node 26 LTS and the Node Playwright package. Keep the Node and Python Playwright browser binaries/version expectations separate.

## 25.6 Blender

Download the pinned Linux release from Blender's official download page, verify the archive/checksum where provided, extract under a versioned directory such as `/opt/blender-5.3.0`, then add a controlled symlink or wrapper. Keep old builds until the project is verified against the new one.

```bash
/opt/blender-5.3.0/blender --version
/opt/blender-5.3.0/blender -b --python-expr "import bpy; print(bpy.app.version_string)"
```

## 25.7 COLMAP

Install dependencies from the current COLMAP Debian/Ubuntu guide. If GPU SfM/MVS is needed, build from the COLMAP source with the correct CUDA/HIP support. The APT package may be useful for CPU/CLI testing, but do not assume it includes GPU support. [R10]

---

# 26. Hardware sizing and performance policy

Actual requirements depend on source resolution, clip duration, number of simultaneous model workers, 3D reconstruction and checkpoint size. These are planning tiers, not hard minimums.

| Tier | CPU | RAM | GPU | Storage | Suitable tasks |
|---|---|---|---|---|---|
| Entry / CPU-first | 8 modern cores | 32 GB | optional / 8 GB VRAM if present | 1 TB NVMe | 2D, OCR, OpenCV, browser QA, smaller models |
| Strong workstation | 16–24 cores | 64 GB | 16–24 GB VRAM | 2 TB NVMe + archive storage | SAM, detection, flow, Blender scenes, moderate 3D |
| Advanced workstation | 24–48 cores | 128 GB | 24–48 GB VRAM | 4 TB NVMe + large source cache | large models, high-res segmentation, SfM/MVS, NeRF/3DGS |
| Studio / multi-GPU | 48+ cores | 256 GB+ | multi-GPU / 48 GB+ total VRAM | NVMe scratch + network/object storage | parallel inference, large reconstructions, team services |

### Bottleneck guidance

- **VRAM:** often the limiting resource for segmentation, VLMs, depth models, 3DGS and NeRF.
- **System RAM:** large decoded frame batches, MVS, point clouds, image sequences and Blender scenes.
- **NVMe:** random access to frame caches, datasets, model weights and intermediate EXR data.
- **CPU:** decoding, image pre/post-processing, feature extraction and many geometry operations.
- **GPU bandwidth/compute:** model inference, optical flow, rasterization, denoising and neural rendering.
- **Network:** only relevant for remote models/storage; keep source media local if privacy requires it.

Use adaptive sampling and ROI escalation. Do not feed every 4K frame through every large model at every stage. First build the PTS index, global signal scan and keyframe candidates; then escalate to denser samples around motion, occlusion and uncertainty.

---

# 27. Security, licensing, model provenance and compliance

## 27.1 Input/archive security

- Treat ZIP contents and metadata as untrusted data.
- Reject path traversal, symlinks escaping the extraction root, oversized expansion ratios and suspicious nested archives.
- Never execute scripts/binaries from supplied media packages.
- Disable automatic network access from model workers unless downloads are explicitly approved.
- Keep private reference media local; do not upload to third-party model services by default.
- Use read-only input mounts and separate writable work/output directories.
- Record archive inventory and SHA-256 hashes.

## 27.2 Package, code and weight licensing

Review three independent things:

1. License of the code package.
2. License/terms of model weights/checkpoints.
3. License of input assets, fonts, textures, datasets and generated content.

Examples of important caveats:

- Ultralytics states that its YOLO code and trained models are AGPL-3.0 by default and that proprietary/commercial scenarios may require an Enterprise licence. [R16]
- SAM 3.1 checkpoint access uses a separate model card with `other` licence metadata and gated terms; read the actual checkpoint license before use. [R18]
- Essentia is AGPLv3 with a proprietary licensing option. [R59]
- Remotion's licensing page distinguishes individual/small-company use, larger-company creator licences and automated render use. [R52]
- Fonts are not automatically redistributable just because the system can load them. Do not embed proprietary font files into `index.html` without permission.

Do not provide blanket legal conclusions. Maintain a per-dependency SBOM/notice inventory and obtain legal review for commercial distribution.

## 27.3 Supply-chain integrity

Recommended tools:

- `pip-audit` for known Python package vulnerabilities.
- `osv-scanner` for dependency vulnerability checks.
- `trivy` for container/filesystem scan.
- `syft` for SBOM generation.
- `cosign` for artifact signing where needed.
- `sha256sum` for models and outputs.
- Git commit/tag pinning for source builds.

Only add these tools to a production release process once their outputs and allow/deny policy are defined.

---

# 28. Integration plan for the Agent 2 reconstruction loop

Map package outputs to the preserved phases rather than changing the workflow.

| Agent 2 stage | Main packages | Evidence written to Scene IR |
|---|---|---|
| Intake and package audit | Python stdlib, `zipfile`, `hashlib`, FFmpeg, PyAV, ExifTool | source assets, hashes, stream metadata, transcript origin |
| PTS/frame ledger | PyAV, FFmpeg | frame IDs, integer PTS, timebase, colour metadata |
| Global scene/motion scan | OpenCV, PySceneDetect, NumPy/SciPy | cuts, beat curves, BG/FG motion, canonical frame candidates |
| Visual element discovery | Grounding DINO, Florence/Qwen VLM, SAM 3.1/SAM 2.1 | candidate elements, prompts, boxes, masks, tracklets |
| Identity reconciliation | SAM, CoTracker, TAPIR, OpenCV, SciPy assignment | stable EL-ID relations, occlusion and re-entry evidence |
| Typography | OCR, FontTools, HarfBuzz, OpenCV | text strings, glyph geometry, shaping and font candidates |
| Background reconstruction | OpenCV, SciPy, ProPainter (conditional) | plate models, masks, field coefficients and confidence |
| Camera / 3D | COLMAP, Open3D, depth models, Blender | cameras, coordinate systems, points, meshes, depth and reprojection error |
| 3D asset/lighting | Blender, OpenUSD, MaterialX, OCIO | mesh/material/camera records and render passes |
| 2D/2.5D/3D browser implementation | DOM/SVG/Canvas, GSAP, Three.js, PixiJS | renderer architecture, object mapping and deterministic timeline |
| Exact-time render capture | Playwright/Chromium or Blender offline render | VAL-ID, exact timestamp, rendered image hash |
| Visual correction | scikit-image, LPIPS, OpenCV, SciPy | ROI errors, metric vectors, correction attempts and residuals |
| Preset extraction | Pydantic/JSON Schema, frozen HTML audit | exact public parameter → implementation mapping |
| Release | pytest, Playwright, ZIP audit, SHA256 | PASS/CONDITIONAL PASS/NOT ACCEPTED |

## 28.1 Adaptive capability routing

Every specialist must declare:

- input data contract;
- software/model version and checkpoint hash;
- supported OS/GPU/backend;
- preconditions;
- outputs and coordinate/time basis;
- confidence and residual metrics;
- fallback package;
- failure code and retry policy;
- estimated cost (CPU/GPU/RAM/VRAM/time).

Activate the lightest method that can answer the current question. Escalate only on measured ambiguity, model disagreement or unacceptable residual. Never run all 88 specialist domains indiscriminately.

## 28.2 Keep the six render layers

The software list supports, but does not replace, the original six layers:

- L0 Camera & Post-FX.
- L1 Environment / Background.
- L2 Lighting & Atmosphere.
- L3 Hero Geometry & Typography.
- L4 Dynamics & Particles.
- L5 Foreground UI & Morphs.

Every reconstructed component must have a declared layer, coordinate space, parent, timing model, renderer and evidence provenance.

---

# 29. Automated acceptance and benchmark gates

## 29.1 Environment smoke test

- OS and kernel identified.
- `ffmpeg -version`, `ffprobe -version` and codec/filter inventory captured.
- PyAV decodes known sample with PTS/timebase intact.
- OpenCV imports and reports build configuration.
- Selected GPU backend passes a tensor inference test.
- Blender background mode imports `bpy` and renders a calibration scene.
- COLMAP/pycolmap can open and process a tiny synthetic fixture.
- OCR returns a known fixture's exact test string.
- Playwright launches Chromium and captures a screenshot.
- Offline HTML has no network dependencies.

## 29.2 Forensic benchmark fixtures

Maintain controlled clips for:

1. Static title with subpixel drift.
2. Text reveal with blur/alpha ramp.
3. Hard cut versus crossfade.
4. Moving flat gradient with foreground overlay.
5. Two visually similar objects crossing and occluding.
6. Parent camera transform versus local element transform.
7. True 3D object rotation with specular highlight movement.
8. Planar homography/perspective.
9. Depth-layer parallax.
10. Particle emitter with fixed seed and arbitrary seeking.
11. VFR clip with non-zero PTS start and duplicate frames.
12. HDR/limited-range video and alpha compositing.
13. Multilingual/Bengali, Devanagari, Arabic and Latin text shaping.
14. Photographic clean-plate removal.
15. Browser output with non-monotonic time seeks.

## 29.3 Gate definitions

- **Environment PASS:** all required tools for the selected route pass smoke tests; non-selected optional tools are not blockers.
- **Forensic PASS:** every source frame is indexed/accounted for, timebase and colour metadata preserved, and major elements/evidence have valid identities and records.
- **Implementation PASS:** deterministic `renderAt(t)`, no missing visible elements, and all required time windows rendered/tested.
- **Fidelity PASS:** content-specific thresholds met or explicitly calibrated; no universal one-number score.
- **Preset PASS:** every implementation claim maps to the frozen HTML or is marked as an adaptation/proposal.
- **Delivery PASS:** `file://` works, no network access is needed, archive contains exactly `index.html` and `preset.md`.

---

# 30. Package decision matrix (quick selection)

| Problem | Start here | Escalate to | Avoid doing by default |
|---|---|---|---|
| Exact frame decoding/time | PyAV + ffprobe | custom FFmpeg/PyAV decode path | OpenCV VideoCapture as only clock |
| Scene cuts | PySceneDetect + frame-diff | model-assisted shot detection | assuming transcript sentence boundaries are cuts |
| Text recognition | PaddleOCR + Tesseract | VLM OCR or custom detector | trusting transcript for on-screen text |
| Flat vector objects | OpenCV contours + SVG | VTracer + manual path correction | hallucinating vector geometry from blurred frames |
| Moving object masks | SAM 3.1/SAM 2.1 | manual mask correction / specialised segmentation | box detector alone as alpha mask |
| Identity through occlusion | SAM video + CoTracker/TAPIR + appearance | manual reviewer adjudication | treating tracker IDs as permanent element IDs |
| Easy motion | DIS/LK + SciPy | RAFT/FlowFormer/CoTracker | RAFT on every frame |
| 2D camera motion | OpenCV affine/homography | Blender camera tracking / COLMAP if 3D evidence | solving a full 3D camera for a simple crop/zoom |
| Depth/parallax | Video Depth Anything | COLMAP or neural reconstruction | treating monocular depth as metric truth |
| 3D reconstruction | COLMAP + Blender | OpenMVS/AliceVision/Nerfstudio/gsplat | assuming one keyframe yields a reliable mesh |
| 3D lookdev | Blender | USD/MaterialX pipeline | building everything from custom GLSL without need |
| Browser 2D graphics | SVG/DOM/Canvas + GSAP | PixiJS | WebGL for simple text/UI |
| Browser 3D graphics | Three.js + GLB | custom shaders / Babylon | embedding full-frame renders as a slideshow |
| Background clean plate | OpenCV + field fitting | ProPainter, then manual review | inpainting a smooth gradient |
| Typography | fontTools + HarfBuzz + exact fonts | glyph vector extraction | system fallback font for a logo/title |
| Colour comparison | OCIO + scikit-image | OpenImageIO/EXR/VMAF | raw screenshot RGB diff without colour management |
| Reproducible experiments | lockfiles + Git + hashes | DVC/MLflow | relying on `latest` and untracked checkpoints |

---

# 31. Current package shortlist by priority

This condensed list is the recommended decision set after considering the whole catalogue.

## P0 — Foundations

- FFmpeg / ffprobe
- PyAV
- OpenCV (one controlled build)
- NumPy, SciPy, Pillow, scikit-image
- PySceneDetect
- Pydantic, JSON Schema
- Python 3.12+ through uv/micromamba as the project requires
- Git, Git LFS, CMake, Ninja, compiler toolchain
- Blender if 3D/2.5D is within scope
- Playwright + Chromium
- pytest
- Node LTS for browser bundles

## P1 — Production capability

- PyTorch + torchvision
- Grounding DINO
- SAM 3.1 (after terms/access/hardware review)
- SAM 2.1 fallback (isolated)
- CoTracker 3 or TAPIR
- RAFT
- Video Depth Anything
- PaddleOCR + Tesseract
- FontTools + HarfBuzz
- COLMAP + pycolmap
- Open3D
- Blender 5.3+
- OpenColorIO + OpenEXR + OpenImageIO
- OpenUSD / MaterialX when interchange demands it
- Three.js + GSAP + PixiJS as renderer selection requires
- Playwright screenshot/seek validation
- DVC / MLflow when evidence/asset versioning scales

## P2 — Advanced specialists

- ProPainter / E2FGVI / LaMa
- Real-ESRGAN / SwinIR / RIFE
- Nerfstudio / gsplat / instant-ngp / nerfacc
- OpenMVG / OpenMVS / AliceVision/Meshroom
- LightGlue / hloc / LoFTR / SuperPoint / ALIKED
- Mitsuba 3 / differentiable rendering
- PyVista / VTK / CGAL / libigl / manifold3d
- Natron / OpenFX plugins
- Motion Canvas / Remotion / Theatre.js / HyperFrames
- Essentia / librosa / faster-whisper / pyannote.audio
- FiftyOne / CVAT / Label Studio / napari
- Ray / Prefect / Dagster / FastAPI / Redis, as architecture demands

---

# 32. Upstream references and research links

All links below point to upstream project documentation, official release notices or primary repositories. Version-specific details should be rechecked before a deployment because model APIs, hardware support matrices and installation indexes change frequently.

## Operating systems, runtime and GPU

- [R1] [Debian Releases](https://www.debian.org/releases/index.html)
- [R2] [Debian 13.7 release notice](https://www.debian.org/News/2026/20260912)
- [R3] [Ubuntu release list](https://wiki.ubuntu.com/Releases)
- [R4] [Playwright Python system requirements](https://playwright.dev/python/docs/intro)
- [R5] [NVIDIA CUDA Installation Guide for Linux 13.4](https://docs.nvidia.com/cuda/cuda-installation-guide-linux/)
- [R6] [AMD ROCm 10.2 release notes and OS support](https://rocm.docs.amd.com/en/develop/about/release-notes.html)
- [R7] [Python externally managed environments / PEP 668](https://packaging.python.org/en/latest/specifications/externally-managed-environments/)
- [R8] [NVIDIA Container Toolkit installation](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html)
- [R66] [Docker Engine on Ubuntu](https://docs.docker.com/engine/install/ubuntu/)
- [R67] [Docker Engine on Debian](https://docs.docker.com/engine/install/debian/)
- [R68] [PyTorch local installation selector](https://pytorch.org/get-started/locally/)
- [R69] [Node.js release schedule](https://nodejs.org/en/about/previous-releases)
- [R70] [uv documentation](https://docs.astral.sh/uv/)
- [R71] [micromamba installation](https://mamba.readthedocs.io/en/latest/installation/micromamba-installation.html)

## Core media, CV and model packages

- [R11] [PyAV time and PTS/timebase documentation](https://pyav.org/docs/stable/api/time.html)
- [R12] [scikit-image image metrics](https://scikit-image.org/docs/stable/api/skimage.metrics.html)
- [R13] [Netflix VMAF / libvmaf](https://github.com/Netflix/vmaf)
- [R14] [Grounding DINO repository](https://github.com/IDEA-Research/GroundingDINO)
- [R15] [MMDetection documentation](https://mmdetection.readthedocs.io/)
- [R16] [Ultralytics licensing](https://www.ultralytics.com/license)
- [R17] [Meta SAM 3 repository and installation](https://github.com/facebookresearch/sam3)
- [R18] [Meta SAM 3.1 model card](https://huggingface.co/facebook/sam3.1)
- [R19] [Meta SAM 2 installation](https://github.com/facebookresearch/sam2/blob/main/INSTALL.md)
- [R20] [CoTracker repository](https://github.com/facebookresearch/co-tracker)
- [R21] [Google DeepMind TAPNet / TAPIR](https://github.com/google-deepmind/tapnet)
- [R22] [Torchvision RAFT documentation](https://docs.pytorch.org/vision/stable/models/raft.html)
- [R23] [Video Depth Anything repository](https://github.com/DepthAnything/Video-Depth-Anything)
- [R24] [COLMAP installation](https://colmap.github.io/install.html)
- [R25] [Meshroom installation and requirements](https://meshroom.readthedocs.io/en/latest/install.html)
- [R26] [Open3D getting started](https://www.open3d.org/docs/latest/getting_started.html)
- [R33] [Nerfstudio installation](https://docs.nerf.studio/quickstart/installation.html)
- [R34] [gsplat installation and project](https://github.com/nerfstudio-project/gsplat)

## Blender, VFX, 2D and browser

- [R27] [Blender 5.3 release](https://www.blender.org/press/blender-5-3-release/)
- [R28] [Blender 5.3 Gaussian splat release notes](https://developer.blender.org/docs/release_notes/5.3/rendering/)
- [R29] [Blender 5.3 Gaussian splat developer article](https://code.blender.org/2026/10/splatting-the-gaussians-into-blender/)
- [R30] [Blender 5.3 pipeline and I/O release notes](https://developer.blender.org/docs/release_notes/5.3/pipeline_io/)
- [R31] [Blender system requirements](https://www.blender.org/download/requirements/)
- [R32] [Blender command-line rendering](https://docs.blender.org/manual/en/latest/advanced/command_line/render.html)
- [R9] [OpenUSD repository and build requirements](https://github.com/PixarAnimationStudios/OpenUSD)
- [R10] [COLMAP installation and Debian/Ubuntu build guide](https://colmap.github.io/install.html)
- [R45] [OpenColorIO](https://opencolorio.org/)
- [R46] [MaterialX](https://materialx.org/docs/api/)
- [R47] [OpenColorIO installation guide](https://opencolorio.readthedocs.io/en/latest/quick_start/installation.html)
- [R35] [Krita Linux downloads](https://krita.org/en/download/)
- [R36] [Tahoma2D Linux downloads](https://tahoma2d.org/download.html)
- [R37] [Pencil2D downloads](https://www.pencil2d.org/download/)
- [R38] [Synfig official site](https://www.synfig.org/)
- [R39] [OpenToonz repository](https://github.com/opentoonz/opentoonz)
- [R40] [CairoSVG documentation](https://cairosvg.org/documentation/)
- [R41] [Skia documentation](https://skia.org/docs/)
- [R42] [skia-python install guide](https://github.com/skia-python/skia-python/blob/main/docs/install.rst)
- [R48] [PixiJS rendering backends](https://pixijs.com/guides/components/renderers/)
- [R49] [Playwright Python browser installation](https://playwright.dev/python/docs/browsers)
- [R50] [Playwright Python introduction/system requirements](https://playwright.dev/python/docs/intro)
- [R51] [HyperFrames repository](https://github.com/hyperframes/hyperframes)
- [R52] [Remotion licensing and pricing](https://www.remotion.dev/docs/license/pricing)
- [R53] [Motion Canvas FFmpeg exporter](https://motioncanvas.io/docs/rendering/video/)
- [R54] [Theatre.js project state](https://www.theatrejs.com/docs/latest/manual/projects)
- [R55] [vite-plugin-singlefile caveats](https://www.npmjs.com/package/vite-plugin-singlefile)

## Restoration and inpainting

- [R43] [ProPainter official repository, installation, model requirements and NTU S-Lab non-commercial licence](https://github.com/sczhou/ProPainter)
- [R44] [E2FGVI official implementation and legacy Python/PyTorch/MMCV setup](https://github.com/MCG-NKU/E2FGVI)
- [R72] [LaMa official repository and environment/model setup](https://github.com/advimman/lama)

## OCR, audio, orchestration and datasets

- [R56] [PaddleOCR quick start](https://www.paddleocr.ai/latest/en/quick_start.html)
- [R57] [PaddlePaddle install / GPU compatibility notes](https://www.paddleocr.ai/latest/en/version3.x/paddlepaddle_installation.html)
- [R58] [vLLM Qwen3-VL recipe](https://docs.vllm.ai/projects/recipes/en/stable/Qwen/Qwen3-VL.html)
- [R59] [Essentia documentation and licensing](https://essentia.upf.edu/documentation.html)
- [R60] [faster-whisper repository](https://github.com/SYSTRAN/faster-whisper)
- [R61] [pyannote.audio repository](https://github.com/pyannote/pyannote-audio)
- [R62] [Librosa documentation](https://librosa.org/doc/latest/index.html)
- [R63] [Label Studio installation](https://labelstud.io/guide/install.html)
- [R64] [MLflow tracking server](https://mlflow.org/docs/latest/tracking/server/)
- [R65] [DVC user guide](https://doc.dvc.org/user-guide)

---

# Appendix A — Package selection record template

For every package used by a production run, create one record:

```yaml
package_id: vision.sam3
name: SAM 3.1
category: video_segmentation
role: promptable segmentation and multi-object tracking
status: enabled                 # enabled | candidate | disabled | blocked
version: "<exact-release-or-commit>"
source: "https://github.com/facebookresearch/sam3"
python: "3.12"
framework:
  torch: "<pinned>"
  torchvision: "<pinned-compatible>"
accelerator:
  backend: cuda                 # cuda | rocm | xpu | cpu
  runtime: "<exact>"
  driver: "<exact>"
weights:
  repository: "facebook/sam3.1"
  revision: "<commit-or-revision>"
  file_sha256: "<sha256>"
  license_review: pending        # approved | pending | rejected
inputs:
  - video_frame_sequence
  - text_or_visual_prompts
outputs:
  - masks
  - temporary_track_ids
  - confidence
fallbacks:
  - sam2.1
  - opencv_classical_mask_tracking
validation:
  fixture: sam_video_occlusion_v1
  metrics:
    - mask_iou
    - track_identity_switches
    - temporal_flicker
    - inference_memory
notes: "Temporary tracker IDs must be reconciled into persistent EL-IDs."
```

# Appendix B — Per-run Scene IR provenance fields

Every source-derived or model-derived property should identify:

- source ID and source frame IDs;
- integer PTS/timebase;
- coordinate space and units;
- extraction package/model and exact version;
- checkpoint hash and prompt/configuration;
- `Observed | Derived | Inferred | Estimated | Unknown | Implementation decision`;
- confidence plus calibration method if probability-like;
- fit residual and uncertainty;
- any correction/human review;
- downstream parameter/element/event affected.

# Appendix C — Final recommendations

1. Make Debian 13.7 or Ubuntu 26.04 LTS the host baseline; use Ubuntu 24.04 LTS as a compatibility alternative where model wheels lag.
2. Keep the Agent 2 original workflow intact. Upgrade the toolchain beneath it, not the assignment.
3. Use PyAV + FFmpeg + OpenCV for canonical media forensics.
4. Use SAM 3.1/SAM 2, Grounding DINO, CoTracker/TAPIR, RAFT and video depth as separate, qualified specialist workers.
5. Use Blender 5.3+ as the primary 3D/2.5D investigation and reconstruction environment; pair it with COLMAP, Open3D and gsplat/Nerfstudio only when the source evidence calls for them.
6. Use OpenUSD, MaterialX, OCIO, OIIO and OpenEXR as the advanced VFX interchange/colour layer.
7. Use HTML/SVG/Canvas/WebGL as the editable output; choose Three.js/PixiJS/GSAP based on scene complexity.
8. Validate with Playwright at exact PTS, multi-dimensional metrics and non-monotonic seek tests.
9. Treat model weights and proprietary fonts as separate licensed assets.
10. Install in profiles, lock them, test them and record what actually worked. A long package list is not proof of a production-ready stack.

**End of documentary.**
