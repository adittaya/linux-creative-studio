#!/usr/bin/env bash
# Detect CPU, memory, GPU, storage and graphics stack. Emits JSON on stdout.
set -euo pipefail

cpus=$( (command -v nproc >/dev/null && nproc) || grep -c '^processor' /proc/cpuinfo || echo 0 )
mem_kb=$(awk '/^MemTotal:/ {print $2}' /proc/meminfo 2>/dev/null || echo 0)
mem_gb=$(python3 -c "print(round($mem_kb/1048576,2))")

gpu_vendors=()
for p in /sys/class/drm/card*/device/vendor; do
  [[ -r "$p" ]] || continue
  v=$(cat "$p")
  case "$v" in
    0x10de) gpu_vendors+=("nvidia") ;;
    0x1002) gpu_vendors+=("amd") ;;
    0x8086) gpu_vendors+=("intel") ;;
    *) gpu_vendors+=("unknown:$v") ;;
  esac
done

drivers=()
for p in /sys/class/drm/card*/device/driver; do
  [[ -e "$p" ]] && drivers+=("$(basename "$(readlink -f "$p")")")
done

glx="unavailable"; vulkan="unavailable"; vaapi="unavailable"
command -v glxinfo >/dev/null 2>&1 && glx=$(glxinfo -B 2>/dev/null | grep -m1 'OpenGL version' || true)
command -v vulkaninfo >/dev/null 2>&1 && vulkan=$(vulkaninfo --summary 2>/dev/null | grep -m1 'driverName' || true)
[[ -d /dev/dri ]] && vaapi="device-nodes-present"

root_free_gb=$(df -Pm / | awk 'NR==2 {printf "%.1f", $4/1024}')

python3 - "$cpus" "$mem_gb" "$root_free_gb" "${gpu_vendors[@]:-none}" "--" "${drivers[@]:-none}" "$glx" "$vulkan" "$vaapi" <<'PY'
import json, sys
a = sys.argv[1:]
cpus, mem_gb, root_free_gb = a[0], a[1], a[2]
rest = a[3:]
gpu = [x for x in rest[:rest.index("--")] if x and x != "none"] if "--" in rest else []
tail = rest[rest.index("--")+1:] if "--" in rest else []
drivers = [x for x in tail[:-3] if x and x != "none"]
glx, vulkan, vaapi = (tail[-3:] + ["", "", ""])[:3]
profile = "standard"
if float(mem_gb) < 8: profile = "minimal"
elif float(mem_gb) >= 32 and gpu: profile = "full-studio-or-rendering-workstation"
print(json.dumps({
    "cpu": {"logical_cores": int(cpus)},
    "memory_gb": float(mem_gb),
    "gpu": {"vendors": sorted(set(gpu)), "kernel_drivers": sorted(set(drivers)),
            "opengl": glx, "vulkan": vulkan, "video_decode_encode": vaapi},
    "storage": {"root_free_gb": float(root_free_gb)},
    "suggested_install_profile": profile,
    "estimates": {"minimal_gb": 4, "standard_gb": 25, "full_studio_gb": 90,
                  "rendering_workstation_gb": 120},
    "warnings": [
        "GPU/vendor detection is advisory. Do not auto-install proprietary drivers.",
        "Check ~/.local/share and vendor docs for Vulkan/VA-API support before GPU-accelerated rendering."
    ],
}, indent=2))
PY
