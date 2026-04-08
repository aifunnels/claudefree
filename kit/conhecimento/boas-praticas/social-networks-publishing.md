---
name: "Social Networks Publishing"
description: "Publish content to Instagram, LinkedIn, X/Twitter, YouTube, or other social platforms"
version: "1.0.0"
---

## Core Principles

1. **Never publish without explicit user confirmation.**
2. **Dry-run first, always.**
3. **Validate platform requirements before publishing.**
4. **Format content natively for each platform.**
5. **Report results immediately.**
6. **Multi-platform publishing is sequential, not parallel.**
7. **Respect rate limits and warn proactively.**

## Publishing Workflow

1. Receive content and identify targets.
2. Check skill availability.
3. Validate content against platform requirements.
4. Present preview to user.
5. Execute dry-run.
6. Request final confirmation.
7. Publish and report.

## Platform Requirements

- **Instagram**: JPEG only, 2-10 images, 2,200 char caption, 25 posts/24h
- **LinkedIn**: JPG/PNG, max 9 images, 3,000 char caption
- **X/Twitter**: JPG/PNG/GIF, max 4 images, 280 chars
- **YouTube**: Thumbnail 1280x720 min, max 2MB

## Quality Criteria

- [ ] User confirmation before live publish
- [ ] Dry-run passed before live publish
- [ ] All platform validations passed
- [ ] Preview presented with complete details
- [ ] Successful publishes include post URL
- [ ] Failed publishes include error details
- [ ] Rate limit checked before publishing
