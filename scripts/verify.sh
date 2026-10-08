#!/usr/bin/env bash
# =============================================================
# AA2-EV02 - Verificación automática del despliegue
# Comprueba: Docker, Engine, imagen, contenedor, puerto y HTTP.
# Uso: bash scripts/verify.sh
# =============================================================
set -u

LOG_DIR="$(cd "$(dirname "$0")/.." && pwd)/logs"
mkdir -p "$LOG_DIR"
LOG="$LOG_DIR/final-verification.log"

IMAGE="getting-started"
CONTAINER="getting-started"
PORT=3000
PASS=0
FAIL=0

log() { echo "$1" | tee -a "$LOG"; }
check() {
  if [ "$1" = "0" ]; then log "  [PASS] $2"; PASS=$((PASS+1));
  else log "  [FAIL] $2"; FAIL=$((FAIL+1)); fi
}

: > "$LOG"
log "================================================================"
log "AA2-EV02 - VERIFICACIÓN FINAL AUTOMATIZADA"
log "Fecha: $(date '+%Y-%m-%d %H:%M:%S %Z')"
log "================================================================"

# 1) Docker disponible
docker --version >/dev/null 2>&1
check $? "Docker CLI disponible ($(docker --version 2>/dev/null))"

# 2) Docker Engine respondiendo
docker info >/dev/null 2>&1
check $? "Docker Engine responde (docker info)"

# 3) Imagen existe
docker image inspect "$IMAGE" >/dev/null 2>&1
check $? "Imagen '$IMAGE' existe"
log "     ID imagen: $(docker image inspect "$IMAGE" --format '{{.Id}}' 2>/dev/null)"

# 4) Contenedor en ejecución
docker ps --filter "name=^/${CONTAINER}$" --filter "status=running" | grep -q "$CONTAINER"
check $? "Contenedor '$CONTAINER' en ejecución"
log "     ID contenedor: $(docker ps -q --filter "name=^/${CONTAINER}$")"

# 5) Puerto mapeado
docker port "$CONTAINER" 2>/dev/null | grep -q "${PORT}/tcp ->"
check $? "Puerto ${PORT} mapeado (host -> contenedor)"

# 6) Respuesta HTTP
CODE=$(curl -s -o /dev/null -w '%{http_code}' "http://localhost:${PORT}/" 2>/dev/null)
[ "$CODE" = "200" ]; check $? "Aplicación responde HTTP 200 en localhost:${PORT} (recibido: $CODE)"

# 7) Modificación visible
if curl -s "http://localhost:${PORT}/js/app.js" 2>/dev/null | grep -q "elementos pendientes"; then
  check 0 "Modificación visible: '¡Aún no tienes elementos pendientes! ¡Agrega uno arriba!'"
else
  check 1 "Modificación NO visible en app.js servido"
fi

log "================================================================"
log "RESULTADO: $PASS pruebas OK, $FAIL fallidas"
if [ "$FAIL" -eq 0 ]; then log "ESTADO GLOBAL: VERIFICACIÓN EXITOSA"; else log "ESTADO GLOBAL: REVISAR FALLOS"; fi
log "================================================================"
exit $FAIL
