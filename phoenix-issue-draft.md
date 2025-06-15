# Issue Title: Warning: Tailwind v4 architecture bug affects Phoenix 1.8 deployments

## Description

Phoenix 1.8.0-rc.3 defaults to Tailwind CSS v4, which has a critical bug where it generates different CSS output on ARM64 vs AMD64 architectures. This causes CSS to work in development (ARM64 Macs) but fail in production (AMD64 servers).

## The Problem

Tailwind v4 has an architecture-specific CSS generation bug:
- Developing on ARM64 (M1/M2 Macs) generates complete CSS
- Deploying to AMD64 (most cloud servers) generates incomplete CSS
- Missing CSS includes arbitrary value classes like `left-[40rem]`

## Reproduction

I've created a minimal reproduction showing the Tailwind v4 bug:
https://github.com/[yourusername]/tailwindcss-v4-arch-bug

The issue has been reported to Tailwind: [Link to Tailwind issue]

## Impact on Phoenix Users

1. **Silent Production Failures**: CSS that works perfectly in development is missing in production
2. **Difficult to Debug**: No build errors - the CSS is simply not generated
3. **Affects New Projects**: Anyone using `mix phx.new` with Phoenix 1.8.0-rc.3

## Example

A Phoenix 1.8 app with this template code:
```html
<div class="left-[40rem] fixed inset-y-0 right-0 z-0 hidden lg:block xl:left-[50rem]">
  <!-- Gradient background -->
</div>
```

- **Development (ARM64)**: Gradient displays correctly
- **Production (AMD64)**: Gradient is missing - the positioning CSS isn't generated

## Recommended Actions

1. **Add Warning to Release Notes**: Warn users about this architecture-specific issue
2. **Consider Reverting to v3**: Until Tailwind fixes this, consider using v3 as default
3. **Documentation Update**: Add a troubleshooting section about architecture mismatches

## Workarounds for Users

Until this is fixed, Phoenix 1.8 users can:

1. **Use Tailwind v3**:
   ```bash
   cd assets
   npm install tailwindcss@^3.4.3
   ```

2. **Match Architectures**: Ensure dev and production use the same architecture

3. **Build on Target**: Generate CSS on the deployment platform

4. **Avoid Arbitrary Values**: Use standard Tailwind classes instead of `[40rem]` style values

## Technical Details

- **Affected**: Phoenix 1.8.0-rc.3 (uses Tailwind v4 by default)
- **Root Cause**: Tailwind v4 architecture-specific binaries generate different output
- **Verified**: The bug is in Tailwind, not Phoenix or Elixir

## Related Links

- Tailwind CSS Issue: [Link to issue]
- Reproduction Repository: https://github.com/[yourusername]/tailwindcss-v4-arch-bug
- Original Discovery: [Link to forum/discussion where this was found]