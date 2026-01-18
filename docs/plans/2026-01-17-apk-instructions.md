# APK Instructions Page Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Create a standalone HTML instruction page for APK installation that matches the `demo4.html` visual style and documents screenshot placeholders.

**Architecture:** Single static HTML file using existing `assets/css/demo4.css` and Tailwind CDN with a small scoped override block. Update `SCREENSHOTS_LIST.md` to record placeholder screenshot filenames.

**Tech Stack:** HTML, Tailwind CDN, existing `assets/css/demo4.css`.

### Task 1: Add a lightweight validation script

**Files:**
- Create: `scripts/validate-apk-instructions.py`

**Step 1: Write the failing test**

Create `scripts/validate-apk-instructions.py`:
```python
from pathlib import Path

page = Path("apk-instructions.html")
text = page.read_text(encoding="utf-8")

assert "Скачать мобильное приложение АС \"ПУСК\"" in text
assert "Пошаговая установка" in text
```

**Step 2: Run test to verify it fails**

Run: `python scripts/validate-apk-instructions.py`
Expected: FAIL with `FileNotFoundError` for `apk-instructions.html`.

**Step 3: Write minimal implementation**

Create `apk-instructions.html` with the static layout, CTA button, steps, and screenshot placeholders.

**Step 4: Run test to verify it passes**

Run: `python scripts/validate-apk-instructions.py`
Expected: PASS with no output.

**Step 5: Commit**

```bash
git add apk-instructions.html scripts/validate-apk-instructions.py
git commit -m "feat: add APK instructions page"
```

### Task 2: Document screenshot placeholders

**Files:**
- Modify: `SCREENSHOTS_LIST.md`

**Step 1: Write the failing test**

Create a temporary check (no repository file) that expects the APK screenshot section:
```bash
rg "apk_screen_settings.png" SCREENSHOTS_LIST.md
```

**Step 2: Run test to verify it fails**

Run: `rg "apk_screen_settings.png" SCREENSHOTS_LIST.md`
Expected: no matches.

**Step 3: Write minimal implementation**

Add a new section listing:
- `apk_screen_settings.png`
- `apk_screen_downloads.png`
- `apk_screen_install.png`

**Step 4: Run test to verify it passes**

Run: `rg "apk_screen_settings.png" SCREENSHOTS_LIST.md`
Expected: match found.

**Step 5: Commit**

```bash
git add SCREENSHOTS_LIST.md
git commit -m "docs: add APK screenshot placeholders"
```

### Task 3: Manual visual verification

**Files:**
- Verify: `apk-instructions.html`

**Step 1: Open the page in a browser**

Run: `start apk-instructions.html`
Expected: page renders with hero, steps, warning cards, and 3 screenshot placeholders.

**Step 2: Check responsive layout**

Resize browser to ~375px width.
Expected: content stacks vertically, text remains readable, buttons remain visible.

**Step 3: Commit**

```bash
git add docs/plans/2026-01-17-apk-instructions.md
git commit -m "docs: add APK instructions implementation plan"
```
