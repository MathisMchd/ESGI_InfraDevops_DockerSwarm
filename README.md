# Infra DevOps - Docker Swarm
### Mathis MICHENAUD - ESGI IW Nantes - 2026 




## Comment récupérer le hostname dans Node.js ?

Utiliser le module natif `os` qui permet de récupérer le hostname :

```js
import os from "os";

const hostname = os.hostname();
console.log(hostname);
```

## Différence entre localhost et 0.0.0.0 dans un conteneur

 - `localhost` : écoute uniquement dans le conteneur, non accessible depuis l'hôte, on ne peut pas redéfinir le port avec `docker run -p 3000:3000` par exemple.

 - `0.0.0.0` : accessible depuis l'extérieur du conteneur, port redéfinissable (`docker run -p 3000:3000`)


## Quels fichiers doivent absolument être ignorés ? Pourquoi ?

À ignorer dans `.dockerignore` :

- `node_modules` → reconstruit dans l'image, évite conflits d’OS
- `.git` → inutile et evite la fuite de l'historique
- `tests` / `coverage` →  inutiles
- `.env*` → secrets potentiellement exposés
- `README.md` → pas nécessaire
- `.vscode` / `.idea` → configs locales pas nécessaire
- `logs` → inutiles et volumineux + risque fuite de données si on maitrise pas les logs
- `Dockerfile` / `.dockerignore` → inutiles dans l’image finale

Objectifs :
- réduire la taille de l’image
- éviter fuite de secrets
- utiliser au maximum le cache Docker


## Comment valider que l'image finale ne contient pas d’artefacts de dev ?

### 1. Inspecter le contenu du conteneur

```bash
docker run --rm -it mon-image sh
```

### 2. Vérifier 
```bash
npm ls --dev
```