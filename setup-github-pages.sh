#!/bin/bash

# Script para configurar GitHub Pages
echo "🚀 Configurando proyecto para GitHub Pages"
echo "============================================="

# Verificar si estamos en un repositorio git
if [ ! -d ".git" ]; then
    echo "📁 Inicializando repositorio Git..."
    git init
    echo "✅ Repositorio Git inicializado"
else
    echo "✅ Repositorio Git ya existe"
fi

# Crear .gitignore si no existe
if [ ! -f ".gitignore" ]; then
    echo "📝 Creando .gitignore..."
    cat > .gitignore << EOF
# Dependencies
node_modules/
npm-debug.log*
yarn-debug.log*
yarn-error.log*

# Firebase
.firebase/
firebase-debug.log
firebase-debug.*.log

# Environment variables
.env
.env.local
.env.development.local
.env.test.local
.env.production.local

# IDEs
.vscode/
.idea/
*.swp
*.swo

# OS
.DS_Store
Thumbs.db

# Logs
logs
*.log

# Cache
.cache/
dist/
build/

# Temporary files
*.tmp
*.temp
EOF
    echo "✅ .gitignore creado"
else
    echo "✅ .gitignore ya existe"
fi

# Verificar estructura de archivos
echo ""
echo "🔍 Verificando estructura del proyecto..."

if [ -f "public/index.html" ]; then
    echo "✅ public/index.html encontrado"
else
    echo "❌ public/index.html NO encontrado"
fi

if [ -f "public/insertar-datos.html" ]; then
    echo "✅ public/insertar-datos.html encontrado"
else
    echo "❌ public/insertar-datos.html NO encontrado"
fi

if [ -f "public/test-connection.html" ]; then
    echo "✅ public/test-connection.html encontrado"
else
    echo "❌ public/test-connection.html NO encontrado"
fi

# Verificar GitHub Actions
if [ -f ".github/workflows/deploy-pages.yml" ]; then
    echo "✅ GitHub Actions configurado"
else
    echo "❌ GitHub Actions NO configurado"
fi

echo ""
echo "📋 PASOS PARA DESPLEGAR EN GITHUB PAGES:"
echo "======================================="
echo ""
echo "1. Crear repositorio en GitHub:"
echo "   - Ve a https://github.com/new"
echo "   - Nombre: sistema-control-tanque (o el que prefieras)"
echo "   - Público o Privado (tu elección)"
echo "   - NO inicialices con README, .gitignore o license"
echo ""
echo "2. Conectar repositorio local:"
echo "   git remote add origin https://github.com/TU_USUARIO/TU_REPOSITORIO.git"
echo "   git branch -M main"
echo "   git add ."
echo "   git commit -m \"Initial commit: Sistema de Control de Tanque\""
echo "   git push -u origin main"
echo ""
echo "3. Configurar GitHub Pages:"
echo "   - Ve a tu repositorio → Settings → Pages"
echo "   - Source: Deploy from a branch"
echo "   - Branch: main"
echo "   - Folder: /public"
echo "   - Save"
echo ""
echo "4. Tu aplicación estará disponible en:"
echo "   https://TU_USUARIO.github.io/TU_REPOSITORIO/"
echo ""
echo "5. URLs específicas:"
echo "   - Aplicación principal: https://TU_USUARIO.github.io/TU_REPOSITORIO/"
echo "   - Panel de control: https://TU_USUARIO.github.io/TU_REPOSITORIO/insertar-datos.html"
echo "   - Diagnóstico: https://TU_USUARIO.github.io/TU_REPOSITORIO/test-connection.html"
echo ""
echo "🔥 IMPORTANTE:"
echo "============="
echo "- Tu configuración de Firebase NO necesita cambios"
echo "- La aplicación funcionará exactamente igual"
echo "- Los datos del ESP32 se seguirán sincronizando"
echo "- GitHub Pages es GRATUITO"
echo ""
echo "🎯 ¿Quieres ejecutar el deploy ahora?"
echo "Si ya tienes el repositorio en GitHub, ejecuta:"
echo ""
echo "git add ."
echo "git commit -m \"Preparado para GitHub Pages\""
echo "git push"
echo ""
echo "✅ ¡Configuración completada!"