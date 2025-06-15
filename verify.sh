#!/bin/bash

# This script builds and runs Tailwind CSS v3 and v4 on both AMD64 and ARM64 architectures
# to demonstrate the architecture-specific CSS generation bug in v4

set -e

echo "🔍 Tailwind CSS Architecture Bug Verification"
echo "============================================="
echo ""

# Clean up previous outputs
rm -rf outputs
mkdir -p outputs

# Build v3
echo "📦 Building Tailwind v3 for both architectures..."
docker buildx build --platform linux/amd64 -t tailwind-v3:amd64 -f v3/Dockerfile . --load > /dev/null 2>&1
docker buildx build --platform linux/arm64 -t tailwind-v3:arm64 -f v3/Dockerfile . --load > /dev/null 2>&1

# Build v4
echo "📦 Building Tailwind v4 for both architectures..."
docker buildx build --platform linux/amd64 -t tailwind-v4:amd64 -f v4/Dockerfile . --load > /dev/null 2>&1
docker buildx build --platform linux/arm64 -t tailwind-v4:arm64 -f v4/Dockerfile . --load > /dev/null 2>&1

# Run v3
echo ""
echo "🏃 Running Tailwind v3..."
docker run --rm -v $(pwd)/outputs:/outputs tailwind-v3:amd64 sh -c "tailwindcss -i input.css -o /outputs/v3-amd64.css" > /dev/null 2>&1
docker run --rm -v $(pwd)/outputs:/outputs tailwind-v3:arm64 sh -c "tailwindcss -i input.css -o /outputs/v3-arm64.css" > /dev/null 2>&1

# Run v4
echo "🏃 Running Tailwind v4..."
docker run --rm -v $(pwd)/outputs:/outputs tailwind-v4:amd64 sh -c "./tailwindcss -i input.css -o /outputs/v4-amd64.css" > /dev/null 2>&1
docker run --rm -v $(pwd)/outputs:/outputs tailwind-v4:arm64 sh -c "./tailwindcss -i input.css -o /outputs/v4-arm64.css" > /dev/null 2>&1

# Results
echo ""
echo "📊 RESULTS"
echo "=========="
echo ""
echo "Tailwind v3 (EXPECTED: identical output):"
echo "  AMD64: $(wc -c < outputs/v3-amd64.css) bytes"
echo "  ARM64: $(wc -c < outputs/v3-arm64.css) bytes"
if diff outputs/v3-amd64.css outputs/v3-arm64.css > /dev/null; then
    echo "  ✅ PASS: Files are identical"
else
    echo "  ❌ FAIL: Files differ (this would be unexpected)"
fi

echo ""
echo "Tailwind v4 (BUG: different output):"
echo "  AMD64: $(wc -c < outputs/v4-amd64.css) bytes"
echo "  ARM64: $(wc -c < outputs/v4-arm64.css) bytes"
if diff outputs/v4-amd64.css outputs/v4-arm64.css > /dev/null; then
    echo "  ✅ Files are identical"
else
    echo "  ❌ BUG CONFIRMED: Files differ!"
    echo "  Difference: $(($(wc -c < outputs/v4-arm64.css) - $(wc -c < outputs/v4-amd64.css))) bytes"
    echo ""
    echo "  Checking for left-[40rem] class:"
    echo "  AMD64: $(grep -c 'left-\[40rem\]' outputs/v4-amd64.css || echo 0) occurrences"
    echo "  ARM64: $(grep -c 'left-\[40rem\]' outputs/v4-arm64.css || echo 0) occurrences"
fi

echo ""
echo "💡 The AMD64 build is missing CSS for arbitrary value classes like left-[40rem]"
echo "   This causes visual differences in production deployments."