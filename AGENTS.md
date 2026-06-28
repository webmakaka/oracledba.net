# oracledba.net — Agent Guide

Jekyll 4.2.2 static site (pages only, no `_posts`). Oracle DBA knowledge base.

## Quick start

```sh
docker-compose up                          # jekyll serve --watch --incremental on port 80:4000
docker build ./ -t oracledba.net           # full production build + html-proofer check
```

## Content rules

- All pages live under `website/`, organized as `NN-category/` → `NN-subcategory/`.
- Every markdown file needs exact front-matter: `layout: page`, `title`, `description`, `keywords`, `permalink`.
- `00-index.md` files are landing pages for each section.
- No `date`, `author`, `categories`, or `tags` in front-matter — never used.
- Filename convention: `NN-slug.md` (zero-padded number, lowercase hyphenated slug).
- Permalink convention: always starts and ends with `/`.

## Build & deploy

- **CI**: `.github/workflows/build.yml` — `docker build` on push/PR to `main`.
- **Dockerfile**: multi-stage — Jekyll build → html-proofer → nginx serve.
- **Production**: systemd unit (`oracledba.net.service`) runs container on port 4010.
- **html-proofer**: run via `bundle exec htmlproofer ./_site --file-ignore /.git/,./_site/404.html --only-4xx --check-html --allow-hash-href --assume-extension`.
- **Prettier** for formatting (`singleQuote: true`).

## Project references

- Production: `https://oracledba.net`
- GA4 tag: `G-PTP4HLFGT2`
- Telegram: `https://t.me/oracledba_net`
- Source: `https://github.com/webmakaka/oracledba.net`

## Style notes

- Primary language is English.
