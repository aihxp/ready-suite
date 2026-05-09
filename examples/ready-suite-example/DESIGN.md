---
name: Pulse
version: 1.0.0
colors:
  primary: "#1A1C1E"
  secondary: "#6C7278"
  accent: "#B8422E"
  background: "#FAFAF7"
  surface: "#FFFFFF"
  border: "#E4E4E0"
  muted: "#9CA3AF"
  success: "#1F7A4D"
  warning: "#9A6B0F"
  danger: "#9B2D1F"
  info: "#1F4F7A"
typography:
  family:
    sans: "Public Sans, -apple-system, BlinkMacSystemFont, sans-serif"
    serif: "Source Serif 4, Georgia, serif"
    mono: "JetBrains Mono, Menlo, monospace"
  h1: { fontFamily: serif, fontSize: 2.25rem, fontWeight: 600, lineHeight: 1.15, letterSpacing: -0.01 }
  h2: { fontFamily: serif, fontSize: 1.75rem, fontWeight: 600, lineHeight: 1.2 }
  h3: { fontFamily: sans,  fontSize: 1.375rem, fontWeight: 600, lineHeight: 1.3 }
  h4: { fontFamily: sans,  fontSize: 1.125rem, fontWeight: 600, lineHeight: 1.35 }
  body: { fontFamily: sans, fontSize: 0.9375rem, fontWeight: 400, lineHeight: 1.55 }
  small: { fontFamily: sans, fontSize: 0.8125rem, fontWeight: 400, lineHeight: 1.45 }
  caption: { fontFamily: sans, fontSize: 0.75rem, fontWeight: 500, lineHeight: 1.4, letterSpacing: 0.01 }
spacing:
  base: 8px
  xs: 4px
  sm: 8px
  md: 16px
  lg: 24px
  xl: 32px
  2xl: 48px
rounded:
  sm: 4px
  md: 8px
  lg: 12px
  full: 9999px
shadows:
  sm: "0 1px 2px rgba(26, 28, 30, 0.06)"
  md: "0 2px 4px rgba(26, 28, 30, 0.08), 0 1px 2px rgba(26, 28, 30, 0.04)"
  lg: "0 8px 24px rgba(26, 28, 30, 0.10), 0 2px 4px rgba(26, 28, 30, 0.06)"
density:
  rowHeight: 56px
  buttonHeight: { sm: 32px, md: 36px, lg: 40px }
  inputHeight: 36px
---

## Overview

**Architectural Minimalism meets Editorial Authority.** Pulse looks like a high-end finance / journalism property: a deep ink palette, a serif heading face, generous breathing room, and a single terracotta accent reserved for the most important action on every screen. The aesthetic is intentional friction against the "stock SaaS dashboard" look (purple gradients, rounded full-bleed buttons, default Material Icons everywhere) the AM tooling category tends toward.

The visual identity supports the product's thesis: account-state visibility is the job; the UI rewards careful reading more than rapid clicking. Density is medium-comfortable, not dense-spreadsheet; rows are 56px tall, the touchpoint timeline shows full-paragraph bodies without truncation, and contrast is high (deep ink on warm-stone background passes WCAG AAA at body text, AA at small-caption text).

## Colors

- **Primary (#1A1C1E):** Deep ink. Headlines, body text, primary CTA backgrounds. The single most-used color; the spine of the visual identity.
- **Secondary (#6C7278):** Warm stone. Secondary text, table-row borders, muted iconography. Reads as quiet, not decorative.
- **Accent (#B8422E):** Terracotta. The "primary CTA" color. Reserved for the single most important action on every visible context (Save on a form, Log Touchpoint on the account-detail page, Resolve on an at-risk flag). Never on more than one visible element at a time.
- **Background (#FAFAF7):** Warm off-white. The page background. Softer than pure white; reduces eye strain in extended use (AMs spend 60-70% of their week in this UI).
- **Surface (#FFFFFF):** Pure white. Cards, modals, dropdown menus. The only place pure white appears.
- **Border (#E4E4E0):** Quiet edge. Table-row separators, card borders, input borders.
- **Muted (#9CA3AF):** Disabled state, placeholder text.
- **Success (#1F7A4D)**, **Warning (#9A6B0F)**, **Danger (#9B2D1F)**, **Info (#1F4F7A):** Semantic colors. Always paired with a text label, never with color alone (per accessibility-deep-dive.md). Used sparingly: green only on resolved-positive states, amber only on pre-action warnings, red only on irreversible-destructive actions, blue only on informational toasts.

## Typography

The pairing is **Public Sans (sans, body + UI)** + **Source Serif 4 (serif, h1-h2)**. Public Sans is U.S. government typography (highly legible, generous x-height, neutral); Source Serif 4 is Adobe's open serif (warm, editorial, pairs cleanly with sans). Both are open-source.

- Body text is `0.9375rem` (15px), heavier than the SaaS norm of 14px to support extended reading.
- H1 (page title) is serif at 2.25rem; this is the only place serif appears on most pages.
- H2 (section headings within a page) is serif at 1.75rem; appears on the account-detail page (timeline section heading, profile section heading).
- H3 and below are sans; the serif fades out as the hierarchy descends.
- Mono (JetBrains Mono) appears only for code-like content: account IDs, audit-log entries, API responses in error states.

## Spacing

8px base unit. The scale is `xs=4 / sm=8 / md=16 / lg=24 / xl=32 / 2xl=48`. Stick to the scale; do not improvise odd values like 14px or 20px.

Density: medium-comfortable. Account-list rows are 56px tall (height fits a 15px name + 13px metadata line + 8px padding top/bottom). Buttons are 36px tall (md size; the canonical interaction target).

## Rounded

`sm=4 / md=8 / lg=12 / full`. Inputs use sm; buttons use md; cards use lg; avatars use full. Avoid mixing radii within a single component; pick the scale rung and stay there.

## Shadows

Three levels. Use sm for hovered table rows; md for hovered cards and dropdown menus; lg only for modal dialogs and the global command palette. Do not stack shadows; do not invent a fourth level.

## Density

| Element | Size |
|---|---|
| Account-list row height | 56px |
| Touchpoint timeline entry min-height | 72px |
| Button height (sm / md / lg) | 32 / 36 / 40 px |
| Input height | 36px |
| Modal max-width | 560px |
| Sidebar nav width | 240px |
| Header height | 56px |

## Agent Prompt Guide

The following are explicit have-nots for any agent generating UI code against this design system. Treat each line as load-bearing; violations break the visual identity.

- **Use the accent color (#B8422E) sparingly.** Reserve it for the single primary CTA on each visible context. Never on more than one element on screen at a time. Never as a decorative accent on borders, headers, or non-action elements.
- **No gradients.** Solid fills only. Tailwind `bg-gradient-*` utilities are forbidden. Inline `linear-gradient` and `radial-gradient` styles are forbidden.
- **No shadows on flat surfaces.** Cards do not have a shadow at rest. Only hovered cards and dropdown menus get shadow. The page background is flat.
- **Type sizes from the scale only.** Never improvise `font-size: 1.18rem`. Always use the typography tokens (`text-h1`, `text-body`, `text-small`, `text-caption` per the Tailwind v4 `@theme` import).
- **Colors from the palette only.** Never improvise hex codes. If a color is not in the palette, ask before adding.
- **Serif only at h1-h2.** Body, h3, h4, captions, buttons all use sans. Mixing serif into the body breaks the editorial-vs-functional rhythm.
- **One semantic color per state, paired with text.** Don't show a "warning" with amber background alone; always pair it with the word "warning" or an icon + label. Color-blind users see no warning otherwise.
- **No animated splash screens, no loading-spinner-as-decoration.** Loading states are inline (skeleton rows, button spinners). The page does not "transition in"; it loads.
- **No third-party UI libraries beyond shadcn/ui (re-skinned).** No Mantine, no Chakra, no MUI. shadcn primitives plus Tailwind is the entire vocabulary. If you need a component shadcn doesn't have, compose from Radix primitives.
- **Round to the scale; do not free-form pixel-tweak.** Buttons are 32 / 36 / 40 px tall, never 34 or 38.
- **Do not invent icons.** Use Lucide icons (the shadcn/ui default). If Lucide doesn't have a fitting icon, use the closest semantic match plus a text label, never inline SVG with an invented glyph.

## How this file was produced

This `DESIGN.md` was scaffolded at week 4 by `production-ready` (Step 3 sub-step 3b: derive from scratch when no DESIGN.md is present, then optionally scaffold one before Step 4 so the next agent starts from sub-step 3a). The token values in the YAML frontmatter are the same tokens applied globally in `src/app/globals.css` via the Tailwind v4 `@theme` import; the round-trip is preserved via the `npx @google/design.md export --format css-tailwind DESIGN.md > theme.css` build step.

## Lint

CI runs `npx @google/design.md lint DESIGN.md` on every push. The seven rules:

1. Token references resolve.
2. WCAG AA contrast on every foreground/background pair (passes).
3. WCAG AAA contrast (--aaa flag, opt-in; passes for body text against `background`; fails for caption against `muted`, accepted: muted is for disabled-state text only).
4. Color format consistency (all hex; passes).
5. Typography scale present (passes).
6. Spacing scale monotonic (passes).
7. Required sections present (passes).

Lint runs as part of `pnpm lint` (CI-enforced).
