# 🚀 Despliegue en GitHub Pages

## Pasos para desplegar en GitHub Pages:

### 1. Preparar el repositorio

```bash
# Inicializar git (si no está ya)
git init

# Agregar archivos
git add .
git commit -m "Initial commit: Sistema de Control de Tanque"

# Conectar con GitHub
git branch -M main
git remote add origin https://github.com/TU_USUARIO/TU_REPOSITORIO.git
git push -u origin main
```

### 2. Configurar GitHub Pages

1. Ve a tu repositorio en GitHub
2. Settings → Pages
3. Source: Deploy from a branch
4. Branch: main
5. Folder: /public (o root si mueves los archivos)

### 3. Estructura recomendada para GitHub Pages

```
tu-repositorio/
├── index.html          # Mover de public/ a raíz
├── insertar-datos.html  # Mover de public/ a raíz
├── test-connection.html # Mover de public/ a raíz
├── firebase.json        # Mantener para referencia
├── database.rules.json  # Mantener para referencia
└── README.md
```

### 4. Consideraciones importantes

#### ✅ Ventajas de GitHub Pages:
- Gratuito
- Fácil de configurar
- Integración automática con git
- SSL automático
- CDN global

#### ⚠️ Limitaciones:
- Solo sitios estáticos (no APIs serverless)
- No Firebase Hosting features (redirects, etc.)
- Tienes que mover archivos de public/ a raíz

#### 🔥 Firebase Realtime Database:
- ✅ Funciona perfectamente desde GitHub Pages
- ✅ CORS está habilitado por defecto
- ✅ No necesita configuración especial
- ✅ Tu configuración actual funcionará

### 5. Script de despliegue automático

Crear `.github/workflows/deploy.yml`:

```yaml
name: Deploy to GitHub Pages

on:
  push:
    branches: [ main ]

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v3
    
    - name: Setup Node.js
      uses: actions/setup-node@v3
      with:
        node-version: '18'
    
    - name: Deploy to GitHub Pages
      uses: peaceiris/actions-gh-pages@v3
      with:
        github_token: ${{ secrets.GITHUB_TOKEN }}
        publish_dir: ./public
```

### 6. Preparación rápida

```bash
# Copiar archivos importantes a la raíz
cp public/index.html ./
cp public/insertar-datos.html ./
cp public/test-connection.html ./

# Crear .gitignore apropiado
echo "node_modules/
.firebase/
firebase-debug.log
.env" > .gitignore
```

### 7. URL final

Tu aplicación estará disponible en:
`https://TU_USUARIO.github.io/TU_REPOSITORIO/`

### 8. Actualizar configuración (opcional)

Si quieres mantener la misma estructura, puedes usar GitHub Pages con la carpeta `public/`:
- Settings → Pages → Source: Deploy from branch
- Branch: main
- Folder: /public

Tu URL será: `https://TU_USUARIO.github.io/TU_REPOSITORIO/`