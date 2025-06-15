# Issue Title: Tailwind v4 generates different CSS on ARM64 vs AMD64 architectures

## Description

Tailwind CSS v4 generates different CSS output when run on ARM64 vs AMD64 architectures using identical input files. This causes production deployments to have missing CSS when developing on a different architecture.

## Reproduction

I've created a minimal reproduction repository with Docker-based tests:
https://github.com/elepedus/tailwindcss-v4-arch-bug

### Quick reproduction:
```bash
git clone https://github.com/elepedus/tailwindcss-v4-arch-bug.git
cd tailwindcss-v4-arch-bug
./verify.sh  # or docker compose up
```

## Current Behavior

When building the same HTML/CSS with Tailwind v4:
- **AMD64**: Generates 83,999 bytes of CSS
- **ARM64**: Generates 88,803 bytes of CSS
- **Difference**: 4,804 bytes (5.7% larger on ARM64)

The AMD64 build is missing CSS rules for arbitrary value classes like `left-[40rem]`.

## Expected Behavior

Tailwind should generate identical CSS output regardless of CPU architecture, as it does in v3.

## Visual Impact

The missing CSS causes visible differences:

**AMD64 Build** - Gradient is missing:
![AMD64 Screenshot](https://github.com/elepedus/tailwindcss-v4-arch-bug/blob/main/screenshots/v4-amd64.png)

**ARM64 Build** - Gradient displays correctly:
![ARM64 Screenshot](https://github.com/elepedus/tailwindcss-v4-arch-bug/blob/main/screenshots/v4-arm64.png)

## Environment

- **Tailwind CSS version**: v4.0.0 through v4.1.10 (latest)
- **Node version**: N/A (using standalone binaries)
- **Operating System**: Linux (via Docker)
- **CPU Architectures**: linux/amd64 and linux/arm64

## Additional Context

1. This bug does **NOT** affect Tailwind v3.x - it produces identical output on both architectures
2. The issue appears to be in the architecture-specific binaries
3. This is causing production breakage for users developing on ARM64 Macs and deploying to AMD64 servers
4. Phoenix Framework 1.8.0-rc.3 users are particularly affected as it defaults to Tailwind v4

## Workarounds

1. Use Tailwind v3 until this is fixed
2. Ensure development and production use the same CPU architecture
3. Build CSS on the target deployment architecture
4. Avoid arbitrary value classes

## Related

This was discovered while debugging Phoenix Framework deployments where CSS worked locally but not in production.