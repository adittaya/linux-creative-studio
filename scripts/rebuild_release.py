#!/usr/bin/env python3
"""Rebuild offline package release artifacts and manifests.

Reads package directories from a work layout (default: <work-dir>/pkg/*),
creates package and bundle zip assets, and regenerates release manifests,
checksums, and documentation indexes.
"""

from __future__ import annotations

import argparse
import hashlib
import json
import os
import re
import sys
import zipfile
from pathlib import Path
from typing import Any


def eprint(msg: str) -> None:
    print(msg, file=sys.stderr)


def load_json(path: Path, default: Any) -> Any:
    if not path.exists():
        return default
    with path.open("r", encoding="utf-8") as f:
        return json.load(f)


def dump_json(path: Path, data: Any) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    with path.open("w", encoding="utf-8") as f:
        json.dump(data, f, indent=2, sort_keys=False, ensure_ascii=False)
        f.write("\n")


def sha256_file(path: Path) -> str:
    h = hashlib.sha256()
    with path.open("rb") as f:
        for chunk in iter(lambda: f.read(1024 * 1024), b""):
            h.update(chunk)
    return h.hexdigest()


def safe_slug(value: str) -> str:
    value = value.strip().lower()
    value = re.sub(r"[^a-z0-9._-]+", "-", value)
    value = re.sub(r"-{2,}", "-", value).strip("-._")
    return value or "unknown"


def pick(d: dict[str, Any], *keys: str, default: Any = None) -> Any:
    for k in keys:
        if k in d and d[k] not in (None, ""):
            return d[k]
    return default


def zip_directory(src_dir: Path, zip_path: Path) -> None:
    zip_path.parent.mkdir(parents=True, exist_ok=True)
    if zip_path.exists():
        zip_path.unlink()
    with zipfile.ZipFile(zip_path, "w", compression=zipfile.ZIP_DEFLATED) as zf:
        for root, dirs, files in os.walk(src_dir):
            root_path = Path(root)
            dirs.sort()
            files.sort()
            for name in files:
                full = root_path / name
                arc = full.relative_to(src_dir).as_posix()
                zf.write(full, arc)


def download_url(repo: str, tag: str, asset: str) -> str:
    return f"https://github.com/{repo}/releases/download/{tag}/{asset}"


def build_package_entry(pkg_dir: Path, assets_dir: Path, repo: str, tag: str) -> dict[str, Any] | None:
    meta = load_json(pkg_dir / "metadata.json", {})
    if not isinstance(meta, dict):
        meta = {}
    hashes = load_json(pkg_dir / "artifact_hashes.json", {})
    if not isinstance(hashes, dict):
        hashes = {}

    pkg_id = pick(meta, "id", "package_id", "pkg_id", default=pkg_dir.name)
    name = pick(meta, "name", "title", default=str(pkg_id))
    safe_id = pick(meta, "safe_id", "slug", default=safe_slug(str(pkg_id)))
    safe_id = safe_slug(str(safe_id))

    asset_name = f"pkg-{safe_id}.zip"
    asset_path = assets_dir / asset_name
    zip_directory(pkg_dir, asset_path)

    entry = {
        "kind": "package",
        "id": pkg_id,
        "name": name,
        "safe_id": safe_id,
        "capabilities": pick(meta, "capabilities", default=[]),
        "priority": pick(meta, "priority", default=None),
        "install": pick(meta, "install", "install_method", default=None),
        "role": pick(meta, "role", "description", default=None),
        "url": pick(meta, "url", "homepage", "upstream_url", default=None),
        "license_warning": pick(meta, "license_warning", default=None),
        "caveat": pick(meta, "caveat", default=None),
        "asset": asset_name,
        "asset_sha256": sha256_file(asset_path),
        "asset_size": asset_path.stat().st_size,
        "download_url": download_url(repo, tag, asset_name),
    }

    # Preserve useful extra metadata when present.
    for key in ("version", "source", "artifacts", "files", "notes"):
        if key in meta and key not in entry:
            entry[key] = meta[key]
    if hashes and "artifact_hashes" not in entry:
        entry["artifact_hashes"] = hashes

    return entry


def infer_bundle_type(bundle_dir: Path, meta: dict[str, Any]) -> str:
    btype = pick(meta, "type", "bundle_type")
    if btype:
        return str(btype)
    name = bundle_dir.name.lower()
    if name.startswith("apt-"):
        return "apt-bundle"
    if name.startswith("profile-"):
        return "python-profile"
    if "doc" in name:
        return "docs"
    return "bundle"


def build_bundle_entry(bundle_dir: Path, assets_dir: Path, repo: str, tag: str) -> dict[str, Any] | None:
    meta = load_json(bundle_dir / "metadata.json", {})
    if not isinstance(meta, dict):
        meta = {}
    bundle_id = pick(meta, "id", default=bundle_dir.name)
    name = pick(meta, "name", default=str(bundle_id))
    safe_name = safe_slug(str(pick(meta, "safe_id", "slug", default=name)))
    asset_name = f"bundle-{safe_name}.zip"
    asset_path = assets_dir / asset_name
    zip_directory(bundle_dir, asset_path)

    entry = {
        "kind": "bundle",
        "type": infer_bundle_type(bundle_dir, meta),
        "id": bundle_id,
        "name": name,
        "asset": asset_name,
        "asset_sha256": sha256_file(asset_path),
        "asset_size": asset_path.stat().st_size,
        "download_url": download_url(repo, tag, asset_name),
    }
    for key in ("description", "contents", "files"):
        if key in meta:
            entry[key] = meta[key]
    return entry


def discover_package_dirs(work_dir: Path) -> list[Path]:
    pkg_root = work_dir / "pkg"
    if not pkg_root.is_dir():
        return []
    dirs = [p for p in pkg_root.iterdir() if p.is_dir()]
    return sorted(dirs, key=lambda p: p.name.lower())


def discover_bundle_dirs(bundles_dir: Path) -> list[Path]:
    if not bundles_dir.is_dir():
        return []
    dirs = [p for p in bundles_dir.iterdir() if p.is_dir()]
    return sorted(dirs, key=lambda p: p.name.lower())


def write_sha256sums(assets_dir: Path, out_path: Path) -> None:
    lines = []
    for p in sorted(assets_dir.iterdir(), key=lambda x: x.name.lower()):
        if p.is_file():
            lines.append(f"{sha256_file(p)}  {p.name}")
    out_path.parent.mkdir(parents=True, exist_ok=True)
    out_path.write_text("\n".join(lines) + ("\n" if lines else ""), encoding="utf-8")


def md_escape(text: Any) -> str:
    s = "" if text is None else str(text)
    return s.replace("|", "\\|").replace("\n", " ")


def write_package_index_md(path: Path, repo: str, tag: str, packages: list[dict], bundles: list[dict]) -> None:
    release_url = f"https://github.com/{repo}/releases/tag/{tag}"
    lines = [
        "# Package Release Index",
        "",
        f"Release: {release_url}",
        "",
        "## Packages",
        "",
        "| Name | ID | Install | Capabilities | Download |",
        "|---|---|---|---|---|",
    ]
    for p in packages:
        caps = ", ".join(p.get("capabilities") or [])
        dl = p.get("download_url") or ""
        asset = p.get("asset") or dl.rsplit("/", 1)[-1]
        link = f"[{md_escape(asset)}]({dl})" if dl else md_escape(asset)
        lines.append(
            f"| {md_escape(p.get('name'))} | `{md_escape(p.get('id'))}` | `{md_escape(p.get('install'))}` | {md_escape(caps)} | {link} |"
        )

    lines += [
        "",
        "## Bundles",
        "",
        "| Name | Type | Download |",
        "|---|---|---|",
    ]
    for b in bundles:
        dl = b.get("download_url") or ""
        asset = b.get("asset") or dl.rsplit("/", 1)[-1]
        link = f"[{md_escape(asset)}]({dl})" if dl else md_escape(asset)
        lines.append(f"| {md_escape(b.get('name'))} | {md_escape(b.get('type'))} | {link} |")

    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text("\n".join(lines) + "\n", encoding="utf-8")


def parse_args() -> argparse.Namespace:
    p = argparse.ArgumentParser(description="Rebuild offline package release assets and manifests.")
    p.add_argument("--work-dir", default="work", help="Work directory containing pkg/* package dirs.")
    p.add_argument("--bundles-dir", default="bundles", help="Directory containing bundle directories.")
    p.add_argument("--docs-dir", default="docs", help="Docs output directory.")
    p.add_argument("--assets-dir", default="release-assets", help="Directory for generated zip assets.")
    p.add_argument("--repo-out", default=".", help="Repository/output root for release and docs files.")
    p.add_argument("--repo", required=True, help="GitHub repo in OWNER/REPO form.")
    p.add_argument("--tag", required=True, help="Release tag used for download URLs.")
    return p.parse_args()


def main() -> int:
    args = parse_args()
    work_dir = Path(args.work_dir)
    bundles_dir = Path(args.bundles_dir)
    docs_dir = Path(args.docs_dir)
    assets_dir = Path(args.assets_dir)
    repo_out = Path(args.repo_out)

    assets_dir.mkdir(parents=True, exist_ok=True)
    release_dir = repo_out / "release"
    docs_out = repo_out / docs_dir if not docs_dir.is_absolute() else docs_dir

    packages: list[dict[str, Any]] = []
    for pkg_dir in discover_package_dirs(work_dir):
        try:
            entry = build_package_entry(pkg_dir, assets_dir, args.repo, args.tag)
            if entry:
                packages.append(entry)
                print(f"packaged: {entry['asset']}")
        except Exception as exc:
            eprint(f"error: package {pkg_dir}: {exc}")
            return 1

    bundles: list[dict[str, Any]] = []
    for bundle_dir in discover_bundle_dirs(bundles_dir):
        try:
            entry = build_bundle_entry(bundle_dir, assets_dir, args.repo, args.tag)
            if entry:
                bundles.append(entry)
                print(f"bundled: {entry['asset']}")
        except Exception as exc:
            eprint(f"error: bundle {bundle_dir}: {exc}")
            return 1

    packages.sort(key=lambda x: (str(x.get("id", "")).lower(), str(x.get("name", "")).lower()))
    bundles.sort(key=lambda x: (str(x.get("id", "")).lower(), str(x.get("name", "")).lower()))

    manifest = packages + bundles
    dump_json(release_dir / "packages.json", packages)
    dump_json(release_dir / "bundles.json", bundles)
    dump_json(release_dir / "RELEASE_MANIFEST.json", manifest)
    write_sha256sums(assets_dir, release_dir / "SHA256SUMS.txt")

    index = {
        "repo": args.repo,
        "tag": args.tag,
        "release_url": f"https://github.com/{args.repo}/releases/tag/{args.tag}",
        "packages": packages,
        "bundles": bundles,
    }
    dump_json(docs_out / "PACKAGE_RELEASE_INDEX.json", index)
    write_package_index_md(docs_out / "PACKAGE_RELEASE_INDEX.md", args.repo, args.tag, packages, bundles)

    print(f"wrote: {release_dir / 'RELEASE_MANIFEST.json'}")
    print(f"wrote: {release_dir / 'packages.json'}")
    print(f"wrote: {release_dir / 'bundles.json'}")
    print(f"wrote: {release_dir / 'SHA256SUMS.txt'}")
    print(f"wrote: {docs_out / 'PACKAGE_RELEASE_INDEX.md'}")
    print(f"wrote: {docs_out / 'PACKAGE_RELEASE_INDEX.json'}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
