# OpenReel Video

HelmForge container image for OpenReel Video, a browser-based video editor.

## Image

- `docker.io/helmforge/openreel-video:v0.4.0`
- `docker.io/helmforge/openreel-video:latest`

The image builds the upstream `Augani/openreel-video` release and serves the
Vite static output with an unprivileged NGINX runtime on port `8080`.

## Runtime Defaults

- Non-root runtime image.
- SPA fallback to `index.html`.
- `/healthz` endpoint for probes.
- COOP/COEP headers enabled for browser APIs used by video/WASM workflows.

## Build Locally

```bash
docker build --build-arg OPENREEL_VERSION=v0.4.0 -t helmforge/openreel-video:v0.4.0 .
docker run --rm -p 8080:8080 helmforge/openreel-video:v0.4.0
```

## Source

- Upstream: https://github.com/Augani/openreel-video
- Image: https://github.com/helmforgedev/openreel-video
