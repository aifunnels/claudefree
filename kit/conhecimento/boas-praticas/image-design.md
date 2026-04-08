---
name: "Visual Design & Image Creation"
description: "Design graphics, carousel slides, social media visuals, or HTML/CSS templates"
version: "1.0.0"
---

## Core Principles

1. **Design system before individual pieces.** Define colors, fonts, spacing, grid, shadows.
2. **Platform-aware viewport and typography.** Respect minimum font sizes per platform.
3. **Visual hierarchy through contrast and scale.** 1.5x minimum size ratio between levels.
4. **Self-contained HTML.** Inline CSS only, no external dependencies except Google Fonts.
5. **Accessibility.** WCAG AA 4.5:1 contrast ratio minimum.
6. **Batch consistency.** Same design system across all slides.

## Platform Specifications

- **Instagram Post/Carousel**: 1080x1440 (3:4), Hero 58px, Body 34px, Caption 24px
- **Instagram Story/Reel**: 1080x1920 (9:16), Hero 56px, Body 32px
- **LinkedIn Post**: 1200x627 (1.91:1), Hero 40px+, Body 24px+
- **Absolute minimum**: 20px for any readable text

## Quality Criteria

- [ ] Design system documented before slides created
- [ ] HTML files self-contained
- [ ] All text meets minimum font size for platform
- [ ] WCAG AA contrast ratio 4.5:1
- [ ] Body dimensions match target viewport exactly
- [ ] CSS Grid or Flexbox for layout
- [ ] First slide verified before batch rendering
