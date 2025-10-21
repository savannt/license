# license
A simple utility to generate a stable machine identifier for license key generation.

## Usage

```bash
curl -s https://raw.githubusercontent.com/thing-king/license/main/profiler.nim -o /tmp/profiler.nim && nim c -r --hints:off /tmp/profiler.nim && rm /tmp/profiler.nim /tmp/profiler
```

The tool will output your machine ID:
```
✓ Machine-ID generated!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
a3f5b8c9d2e1f4a7b6c5d4e3f2a1b0c9
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Use this ID to generate a license.
 → https://thingking.org/create ←
```