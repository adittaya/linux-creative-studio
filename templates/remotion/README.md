# Remotion templates

`starter/` is a pinned, minimal Remotion 4.0.538 + React 19 + TypeScript project with an example
composition (`StudioSample`, 90 frames @ 30 fps). It is **source only**: no `node_modules` or browser
are included.

## Preparation (connected machine)

```bash
cd starter
npm install --package-lock-only
npm ci
npx remotion browser ensure
npm cache verify
# copy ~/.npm/_cacache -> offline-repo/npm-cache/_cacache
# copy the pinned Chrome Headless Shell -> runtimes/browsers/chrome-headless-shell/
```

## Offline target

```bash
npm ci --offline --cache ../../../offline-repo/npm-cache
./render.sh
```

Read `https://remotion.dev/license` before production use.
