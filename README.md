# AA2-EV02 — Despliegue de contenedores Docker (SENA)

Taller de despliegue de una aplicación Node.js en un contenedor Docker, con evidencia académica.

## Datos de la práctica

- Programa: Despliegue de aplicaciones y servicios en contenedores Docker.
- Resultado de aprendizaje: 220501086-02 — Crear la infraestructura y plataforma tecnológica según los requerimientos del proyecto de Software.
- Actividad: AA2 — Generar un ambiente de desarrollo a partir de la ejecución de imágenes para la creación de contenedores.
- Evidencia: AA2-EV02 — Taller de aplicación: ejercicio despliegue de contenedores.
- Aprendiz: Javier Parra.
- Entorno: Windows 11 + WSL2 (Ubuntu 24.04.4 LTS), x86_64.

## Estructura de carpetas del repositorio

```
AA2-EV02-Docker/
├── AGENTS.md
├── README.md
├── app/
│   └── getting-started-app/        (app clonada de docker/getting-started-app,
│                                     commit 6b025fc53bc7b9bef435d6b09bcd1da5a871c9cc)
├── docker/
│   ├── Dockerfile
│   └── .dockerignore
├── scripts/
│   └── verify.sh
├── evidencias/                     (subcarpetas 00-diagnostico ... 14-final)
├── logs/
├── metadata/
│   ├── project-state.json
│   ├── commands.log
│   ├── evidence-index.json
│   └── checklist.json
└── documento/
    ├── AA2-EV02.md
    └── AA2-EV02.html
```

## Comandos clave

```bash
docker build -f docker/Dockerfile -t getting-started app/getting-started-app
docker run -dp 3000:3000 --name getting-started getting-started
docker image ls getting-started
docker ps
docker stop <ID> && docker rm <ID>
bash scripts/verify.sh
```

## Resultados verificados

- Docker version 29.7.2 / Docker Compose v5.3.1.
- Imagen final `getting-started` ID `3346675b07f4` (81.5 MB, `node:22-alpine`, Node 22.23.3).
- Contenedor final `ba5968cb3faa` en ejecución, puerto `0.0.0.0:3000->3000/tcp`.
- Modificación en `src/static/js/app.js` línea 56: antes `No items yet! Add one above!` → después `¡Aún no tienes elementos pendientes! ¡Agrega uno arriba!`.
- `scripts/verify.sh`: 7/7 pruebas OK.

## Nota sobre Docker Hub

La publicación en Docker Hub NO se realizó (fase opcional).

## Evidencias

El detalle de las evidencias está en `documento/AA2-EV02.md` y en la carpeta `evidencias/`.
