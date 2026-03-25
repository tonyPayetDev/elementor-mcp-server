# CLAUDE.md — Elementor MCP Server Landing Page

## Project Overview

This repository contains the **landing page and documentation website** for the Elementor MCP Server project. It is a static HTML/CSS/JS site served via nginx, NOT the actual MCP server implementation.

The actual MCP server is a separate npm package (`elementor-mcp`) distributed at https://github.com/aguaitech/Elementor-MCP.

---

## Repository Structure

```
elementor-mcp-server/
├── index.html          # Main landing/documentation page (single page)
├── Dockerfile          # nginx:alpine container for hosting
├── assets/
│   ├── css/
│   │   └── style.css   # Dark theme styling (~726 lines)
│   └── js/
│       └── main.js     # Vanilla JS interactivity (~45 lines)
└── CLAUDE.md           # This file
```

**No build system, no package.json, no test suite.** Everything is static.

---

## Running the Site

**Via Docker (recommended):**
```bash
docker build -t elementor-mcp-landing .
docker run -p 80:80 elementor-mcp-landing
```

**Direct browser:**
Open `index.html` directly in any modern browser — no server required.

---

## Development Conventions

### HTML (`index.html`)
- Single-page structure; all content lives in one file
- Semantic HTML5 with ARIA labels for accessibility
- Inline SVG icons
- Proper meta/og tags for SEO and social sharing
- Installation code blocks use `<pre><code>` with copy-to-clipboard support

### CSS (`assets/css/style.css`)
- GitHub-inspired dark theme using CSS custom properties
- Key variables:
  ```css
  --color-bg: #0d1117        /* page background */
  --color-accent: #0366d6    /* primary blue */
  --color-text: #e6edf3      /* main text */
  --color-success: #3fb950   /* green accents */
  --color-border: #30363d    /* borders/dividers */
  ```
- BEM-like class naming (`.tool-card`, `.platform-badge`, `.code-block`)
- CSS Grid for layouts; flexbox for components
- Smooth transitions on interactive elements

### JavaScript (`assets/js/main.js`)
- Vanilla JS only — no frameworks or bundlers
- Three concerns: tab switching, copy-to-clipboard, scroll-triggered animations
- Uses `IntersectionObserver` for scroll animations
- `classList` for all state management

---

## Content: What the MCP Server Does

The landing page documents **7 MCP tools** exposed by the `elementor-mcp` npm package:

| Tool | Description |
|------|-------------|
| `create_page` | Creates a new WordPress page with Elementor data |
| `get_page` | Retrieves a page by ID including `_elementor_data` |
| `update_page` | Updates title, status, content, or Elementor data |
| `delete_page` | Deletes a page (optional: force/bypass trash) |
| `download_page_to_file` | Saves page locally (optionally Elementor data only) |
| `update_page_from_file` | Updates page from a local file |
| `get_page_id_by_slug` | Retrieves a page ID by its URL slug |

### Required Environment Variables (for the MCP server, not this site)
- `WP_URL` — WordPress site URL
- `WP_APP_USER` — WordPress application username
- `WP_APP_PASSWORD` — WordPress application password

---

## Git Workflow

- **Default branch:** `master` / `main`
- **Active development branch:** `claude/add-claude-documentation-cogeA`
- Push to the designated branch, never directly to `main`/`master` without explicit permission
- Commit messages follow the pattern: `Deploy: YYYY-MM-DD HH:MM:SS` for deployments

---

## Key Constraints for AI Assistants

1. **No build step** — Do not add package.json, webpack, or bundlers unless explicitly requested.
2. **No frameworks** — Keep HTML/CSS/JS vanilla; do not introduce React, Vue, Tailwind, etc.
3. **Single-page** — All content belongs in `index.html`; do not split into multiple HTML files.
4. **No backend** — This is purely a static site. Any server-side logic belongs in the separate `elementor-mcp` npm package, not here.
5. **Preserve the dark theme** — All new UI elements must use the established CSS variables.
6. **Accessibility** — Maintain ARIA labels and semantic HTML when modifying markup.
7. **Do not modify Dockerfile** unless specifically asked — the nginx alpine setup is intentionally minimal.

---

## Common Tasks

### Updating installation instructions
Edit the relevant `<section>` in `index.html`. Copy-to-clipboard is handled automatically by `main.js` for any element with class `code-block`.

### Adding a new MCP tool to the docs
Add a new `.tool-card` block inside the tools grid section in `index.html`. Follow the existing card structure for consistency.

### Styling changes
Edit `assets/css/style.css`. Always use the existing CSS variables rather than hardcoded colors.

### Deploying
Build and push the Docker image, or upload the static files to any static hosting service (Netlify, GitHub Pages, Cloudflare Pages, etc.).
