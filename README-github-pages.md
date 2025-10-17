# Sistema de Control de Tanque 💧

[![Deploy to GitHub Pages](https://img.shields.io/badge/Deploy-GitHub%20Pages-brightgreen.svg)](https://pages.github.com/)
[![Firebase](https://img.shields.io/badge/Database-Firebase-orange.svg)](https://firebase.google.com/)

Sistema completo de monitoreo y control de tanque de agua en tiempo real usando Firebase Realtime Database.

## 🌐 Despliegue en GitHub Pages

### Opción 1: Despliegue directo desde /public

1. **Configurar GitHub Pages:**
   - Ve a Settings → Pages
   - Source: Deploy from a branch
   - Branch: `main`
   - Folder: `/public`

2. **Tu aplicación estará en:**
   ```
   https://TU_USUARIO.github.io/TU_REPOSITORIO/
   ```

### Opción 2: Mover archivos a la raíz

```bash
# Copiar archivos principales
cp public/index.html ./
cp public/insertar-datos.html ./
cp public/test-connection.html ./

# Configurar GitHub Pages para usar la raíz
# Settings → Pages → Folder: / (root)
```

## 🚀 Configuración Automática

### 1. Clonar y configurar

```bash
git clone https://github.com/TU_USUARIO/TU_REPOSITORIO.git
cd TU_REPOSITORIO
```

### 2. GitHub Actions (Opcional)

Crear `.github/workflows/pages.yml` para despliegue automático:

```yaml
name: Deploy to GitHub Pages

on:
  push:
    branches: ["main"]
  workflow_dispatch:

permissions:
  contents: read
  pages: write
  id-token: write

concurrency:
  group: "pages"
  cancel-in-progress: false

jobs:
  deploy:
    environment:
      name: github-pages
      url: ${{ steps.deployment.outputs.page_url }}
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v4
      - name: Setup Pages
        uses: actions/configure-pages@v4
      - name: Upload artifact
        uses: actions/upload-pages-artifact@v3
        with:
          path: './public'
      - name: Deploy to GitHub Pages
        id: deployment
        uses: actions/deploy-pages@v4
```

## 🔧 Configuración de Firebase

Tu configuración actual de Firebase funcionará perfectamente en GitHub Pages:

```javascript
const firebaseConfig = {
  apiKey: "AIzaSyCGo5VbKXDW1GNcejA66NDr0bemrq5glKA",
  authDomain: "shiro-mierdas.firebaseapp.com",
  databaseURL: "https://shiro-mierdas-default-rtdb.firebaseio.com",
  projectId: "shiro-mierdas",
  storageBucket: "shiro-mierdas.firebasestorage.app",
  messagingSenderId: "510647911107",
  appId: "1:510647911107:web:3e18610d8455cb0fed1876"
};
```

## 📁 Estructura del proyecto

```
sistema-control-tanque/
├── public/                 # Archivos web
│   ├── index.html         # Aplicación principal
│   ├── insertar-datos.html # Panel de control
│   └── test-connection.html # Diagnóstico
├── .github/
│   └── workflows/
│       └── pages.yml      # GitHub Actions
├── firebase.json          # Configuración Firebase
├── database.rules.json    # Reglas de seguridad
└── README.md
```

## 🌍 URLs de acceso

Una vez desplegado en GitHub Pages:

- **Aplicación principal:** `https://TU_USUARIO.github.io/TU_REPOSITORIO/`
- **Panel de control:** `https://TU_USUARIO.github.io/TU_REPOSITORIO/insertar-datos.html`
- **Diagnóstico:** `https://TU_USUARIO.github.io/TU_REPOSITORIO/test-connection.html`

## ✅ Ventajas de GitHub Pages

- ✅ **Gratuito** - Sin costos
- ✅ **Automático** - Deploy con cada push
- ✅ **SSL/HTTPS** - Certificado automático
- ✅ **CDN Global** - Rápido en todo el mundo
- ✅ **Compatible** - Funciona con Firebase
- ✅ **Fácil** - Solo configurar una vez

## 🔄 Flujo de trabajo

1. **Desarrollar localmente:**
   ```bash
   npm run dev  # Servidor local en http://localhost:5000
   ```

2. **Hacer commit:**
   ```bash
   git add .
   git commit -m "Actualizar aplicación"
   git push
   ```

3. **Deploy automático:** GitHub Pages se actualiza automáticamente

## 🛠️ Troubleshooting

### Error CORS
- No debería ocurrir, Firebase permite requests desde GitHub Pages

### 404 en GitHub Pages
- Verificar que `index.html` esté en la carpeta correcta
- Configurar correctamente Source en Settings → Pages

### Firebase no conecta
- Verificar credenciales en `firebaseConfig`
- Revisar reglas de database en Firebase Console

## 📞 Soporte

Si tienes problemas:
1. Revisa la consola del navegador (F12)
2. Verifica la configuración en GitHub Pages
3. Confirma que Firebase esté configurado correctamente

---

**¡Tu aplicación de control de tanque estará disponible 24/7 en GitHub Pages! 🚀**