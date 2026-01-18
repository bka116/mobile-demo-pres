# Build demo4.html

Requirements: Python 3

Build:
  python scripts/build-demo4.py
  powershell -ExecutionPolicy Bypass -File scripts/export-pdf.ps1
  powershell -ExecutionPolicy Bypass -File scripts/export-pdf.ps1 -Scale 0.82

Sources:
  - src/template.html (layout with {{slides}})
  - src/slides/slide-XX.html (individual slides)

Output:
  - demo4.html
  - demo4.pdf

# Build apk-instructions.pdf

Build:
  powershell -ExecutionPolicy Bypass -File scripts/export-apk-instructions-pdf.ps1
  # or: powershell -ExecutionPolicy Bypass -File scripts/export-pdf.ps1 -InputPath apk-instructions.html -OutputPath apk-instructions.pdf

Sources:
  - apk-instructions.html

Output:
  - apk-instructions.pdf
