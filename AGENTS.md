# AGENTS.md — Guía para agentes y colaboradores

## Propósito del repositorio

Repositorio de la evidencia académica **AA2-EV02 — Taller de aplicación: ejercicio despliegue de contenedores (SENA)**. Contiene una aplicación Node.js desplegada en Docker, junto con las evidencias, los registros de comandos y la documentación del taller.

## Regla fundamental

No inventar evidencias. Toda afirmación del README, la documentación o los metadatos debe corresponder a una ejecución real o a un archivo realmente presente en el repositorio. No documentar resultados que no hayan sido verificados.

## Estructura de carpetas

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

## Convenciones

- Los comandos ejecutados se registran en `metadata/commands.log`.
- El estado del proyecto se registra en `metadata/project-state.json`.
- El índice de evidencias se mantiene en `metadata/evidence-index.json`.
- La lista de verificación se mantiene en `metadata/checklist.json`.

## Cómo reproducir

```bash
docker build -f docker/Dockerfile -t getting-started app/getting-started-app
docker run -dp 3000:3000 --name getting-started getting-started
docker image ls getting-started
docker ps
docker stop <ID> && docker rm <ID>
bash scripts/verify.sh
```

## Regla de seguridad

- No ejecutar `docker system prune`.
- No eliminar contenedores de otros proyectos.
- No manejar credenciales.

## Regla de interacción

Detenerse y pedir acción humana si se requiere un inicio de sesión, por ejemplo para Docker Hub.
