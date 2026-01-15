# Build demo4.html

Requirements: Python 3

Build:
  python scripts/build-demo4.py
  powershell -ExecutionPolicy Bypass -File scripts/export-pdf.ps1

Sources:
  - src/template.html (layout with {{slides}})
  - src/slides/slide-XX.html (individual slides)

Output:
  - demo4.html
  - demo4.pdf
