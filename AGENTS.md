# AGENTS.md

## Project Structure

This is an Astro + Starlight documentation site deployed with the Cloudflare adapter.

- `astro.config.mjs`: Main Astro/Starlight configuration, including component overrides (for example `PageTitle`).
- `src/pages/`: Route pages (including `changelog` and `zh-cn/changelog`).
- `src/changelog/`: English changelog content (one file per version).
- `src/changelog/zh-cn/`: Chinese changelog content (one file per version).
- `src/components/`: Page components and Starlight override components (for example `title.astro`).
- `public/`: Static assets.

## Common Commands

Run these commands in the project root:

- `pnpm dev`: Start local development server
- `pnpm build`: Build for production
- `pnpm preview`: Preview build (Cloudflare wrangler)
- `pnpm deploy`: Build and deploy

## Change Conventions

### Changelog Conventions

- Use one file per version, and name the file with the version number (for example `1.8.0.md`).
- Store English and Chinese content separately:
  - `src/changelog/`
  - `src/changelog/zh-cn/`
- Do not repeat the version number as a heading in the file body (version info comes from frontmatter/file name).

### Commit Message Style

Use natural-language commit messages that describe the change directly. Do not use Conventional Commit prefixes (such as `feat:` or `fix:`).

Recommended examples:

- `Add per-version changelog files for English and Chinese`
- `Add changelog pages and components and compute latest version from filenames`
- `Replace default page title component and wire hideTitle in Astro config`

Recommendations:

- Keep one commit focused on one type of change (content, page logic, configuration).
- State clearly what changed; add why when useful.
