#!/usr/bin/env bash
# =============================================================
# AA2-EV02 - Generación de la documentación en varios formatos
# Requiere: pandoc (binario) y, para PDF, weasyprint.
# Uso: bash scripts/build_doc.sh
# =============================================================
set -eu
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
DOC="$ROOT/documento"
MD="$DOC/AA2-EV02.md"

# Ruta de pandoc (ajustar si está en el PATH)
PANDOC="${PANDOC:-pandoc}"
# Intérprete con weasyprint (venv). Ajustar si aplica.
WEASY="${WEASY:-weasyprint}"

echo "[1/3] Markdown -> HTML (autocontenido)"
"$PANDOC" "$MD" -o "$DOC/AA2-EV02.html" --standalone --embed-resources \
  --toc --toc-depth=2 --css "$DOC/style.css" \
  --metadata title="AA2-EV02 - Despliegue de contenedores Docker"

echo "[2/3] Markdown -> DOCX"
"$PANDOC" "$MD" -o "$DOC/AA2-EV02.docx" --toc --toc-depth=2 \
  --metadata title="AA2-EV02 - Despliegue de contenedores Docker"

echo "[3/3] HTML -> PDF (WeasyPrint)"
"$WEASY" "$DOC/AA2-EV02.html" "$DOC/AA2-EV02.pdf"

echo "Documentación generada en $DOC"
ls -la "$DOC"
