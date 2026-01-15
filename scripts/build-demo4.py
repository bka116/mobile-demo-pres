from __future__ import annotations

import re
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
TEMPLATE_PATH = ROOT / 'src' / 'template.html'
SLIDES_DIR = ROOT / 'src' / 'slides'
OUTPUT_PATH = ROOT / 'demo4.html'

PLACEHOLDER = '{{slides}}'


def _slide_sort_key(path: Path) -> int:
    match = re.search(r'(\d+)', path.stem)
    return int(match.group(1)) if match else 0


def build() -> None:
    if not TEMPLATE_PATH.exists():
        raise SystemExit(f'Missing template: {TEMPLATE_PATH}')
    if not SLIDES_DIR.exists():
        raise SystemExit(f'Missing slides dir: {SLIDES_DIR}')

    slide_files = sorted(SLIDES_DIR.glob('slide-*.html'), key=_slide_sort_key)
    if not slide_files:
        raise SystemExit('No slides found in src/slides')

    template = TEMPLATE_PATH.read_text(encoding='utf-8')
    if PLACEHOLDER not in template:
        raise SystemExit('Template is missing {{slides}} placeholder')

    slides_content = ''.join(p.read_text(encoding='utf-8').rstrip() + '\n' for p in slide_files)
    output = template.replace(PLACEHOLDER, slides_content)

    OUTPUT_PATH.write_text(output, encoding='utf-8')
    print(f'Built {OUTPUT_PATH} from {len(slide_files)} slides')


if __name__ == '__main__':
    build()
