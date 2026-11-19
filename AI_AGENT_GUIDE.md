# AI agent guide

This file is the machine-facing contract for agents using the studio.

## Discovery sequence

```bash
./studioctl status --json
./studioctl doctor --json
./studioctl capabilities --json
./studioctl search "photo editing" --json
./studioctl plan --task "Create a parallax animation" --json
./studioctl info blender --json
./studioctl deps blender --json
./studioctl offline-check --json
```

## JSON contracts

| Command | Top-level keys |
|---|---|
| `list --json` | `ok`, `count`, `applications[{id,name,category,verification_status,installed,offline_available}]` |
| `search <q> --json` | `ok`, `query`, `query_tokens`, `matched_profiles`, `results[{id,name,category,score,reasons,capabilities,installed,verification_status}]`, `count` |
| `info <id> --json` | `ok`, `application{...full manifest + install_record + candidate_paths}` |
| `capabilities --json` | `schema_version`, `capability_count`, `capabilities{name:[ids]}` |
| `plan --task <t> --json` | `ok`, `task`, `matched_profiles`, `proposed_toolchain[{id,name,role,why,dependencies,installed,executable,...}]`, `workflows`, `verification`, `notes` |
| `doctor --json` | `ok`, `studio_root`, `python`, `host`, `registry`, `disk`, `installed_applications`, `problems`, `warnings`, `honest_state` |
| `verify --json` | `ok`, `smoke`, `checked`, `passed`, `results[{id,verdict,...}]` |
| `offline-check --json` | `ok`, `network_used`, `summary`, `applications[{id,offline_capable,cached_artifacts,verdict}]` |
| `profiles [--json]` | `ok`, `count`, `profiles[...]` |

## Safe automation rules

1. **Never invent an application ID.** All IDs must exist in `registry/applications.json`.
2. **Never construct a shell command from model output.** Use `studioctl launch <verified-id>`.
   `studioctl` resolves only allowlisted paths, uses argv arrays and validates `--input` paths.
3. **Respect status fields.** `installed != verified`. `verification_status` is one of
   `not-tested`, `unavailable`, `not-redistributable`, etc. Only test logs can change it.
4. **Facets are not binaries.** `blender-compositor`, `blender-grease-pencil` (via Blender),
   `krita-animation`, `ffprobe`, `blender-color-management` delegate to their parent application.
5. **Do not claim offline capability from `offline_available` alone.** Check
   `offline-check` verdict, cached artifacts and the functional offline test log.
6. **Commercial software is quarantined.** `davinci-resolve` and `reaper` are
   `not-redistributable`, require network/installer and must never be downloaded or shipped here.
7. **Minimise toolchains.** Use `plan` output as a proposal; drop optional tools unless the task needs them.

## Example decision flow

```text
task -> studioctl plan --task "<task>" --json
     -> pick required tools with installed=true and verification_status acceptable
     -> read docs/applications/<id>.md and profiles/<matched>.json
     -> studioctl launch <id> --dry-run
     -> studioctl launch <id> [--input <validated file>]
     -> run matching tests in tests/, store logs, then report honest status
```

## Extending the registry

Edit `scripts/_generate.py` data (or add a new manifest following
`packages/3d/blender/metadata/application.json` as reference), then run `python3 scripts/_generate.py`
and `./scripts/repair.sh --dry-run` first. Re-running the generator is safe for generated metadata;
it never deletes `assets/`, `projects/`, `active/` or cached artifacts.

## Error semantics

Exit codes: `0` success, `1` runtime/diagnostic error, `2` bad arguments/guard failure,
`3` unknown application/profile ID, `4` invalid input path. JSON mode returns
`{"ok": false, "error": "...", "exit_code": n}`.
