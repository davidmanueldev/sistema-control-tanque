#!/bin/bash

# Script rápido para configurar y deployar en GitHub Pages
echo "🚀 DESPLIEGUE RÁPIDO EN GITHUB PAGES"
echo "===================================="

# Verificar si git está configurado
if ! git config user.name > /dev/null; then
    echo "⚙️ Configurando Git..."
    read -p "Ingresa tu nombre: " git_name
    read -p "Ingresa tu email: " git_email
    git config --global user.name "$git_name"
    git config --global user.email "$git_email"
    echo "✅ Git configurado"
fi

# Verificar si hay repositorio remoto
if ! git remote get-url origin > /dev/null 2>&1; then
    echo ""
    echo "📁 CONFIGURACIÓN DEL REPOSITORIO"
    echo "================================"
    echo "1. Ve a https://github.com/new"
    echo "2. Crea un repositorio público"
    echo "3. NO añadas README, .gitignore o license"
    echo ""
    read -p "Ingresa la URL del repositorio (https://github.com/usuario/repo.git): " repo_url
    
    if [ ! -z "$repo_url" ]; then
        git remote add origin "$repo_url"
        echo "✅ Repositorio remoto configurado"
    else
        echo "❌ URL no proporcionada. Configura manualmente:"
        echo "git remote add origin https://github.com/TU_USUARIO/TU_REPO.git"
        exit 1
    fi
fi

# Verificar si estamos en main
current_branch=$(git branch --show-current)
if [ "$current_branch" != "main" ]; then
    echo "🔄 Cambiando a rama main..."
    git checkout -b main 2>/dev/null || git checkout main
fi

# Hacer commit de todos los cambios
echo "📝 Preparando archivos para deploy..."
git add .

# Verificar si hay cambios
if git diff --staged --quiet; then
    echo "✅ No hay cambios nuevos"
else
    git commit -m "Deploy: Sistema de Control de Tanque para GitHub Pages"
    echo "✅ Cambios commiteados"
fi

# Push al repositorio
echo "🚀 Desplegando a GitHub..."
if git push -u origin main; then
    echo ""
    echo "🎉 ¡DESPLIEGUE EXITOSO!"
    echo "====================="
    echo ""
    echo "Ahora ve a tu repositorio en GitHub y:"
    echo "1. Ve a Settings → Pages"
    echo "2. Source: Deploy from a branch"
    echo "3. Branch: main"
    echo "4. Folder: /public"
    echo "5. Save"
    echo ""
    echo "Tu aplicación estará disponible en unos minutos en:"
    
    # Extraer usuario y repo de la URL
    remote_url=$(git remote get-url origin)
    if [[ $remote_url =~ github\.com[:/]([^/]+)/([^/.]+) ]]; then
        user=${BASH_REMATCH[1]}
        repo=${BASH_REMATCH[2]}
        echo "🌐 https://$user.github.io/$repo/"
        echo ""
        echo "📱 URLs específicas:"
        echo "   - Panel de control: https://$user.github.io/$repo/insertar-datos.html"
        echo "   - Diagnóstico: https://$user.github.io/$repo/test-connection.html"
    else
        echo "🌐 https://TU_USUARIO.github.io/TU_REPOSITORIO/"
    fi
    
    echo ""
    echo "✅ El deploy automático con GitHub Actions está configurado"
    echo "   Cada vez que hagas push, se actualizará automáticamente"
    
else
    echo ""
    echo "❌ Error en el deploy"
    echo "Verifica:"
    echo "1. Que tengas permisos en el repositorio"
    echo "2. Que la URL del repositorio sea correcta"
    echo "3. Que tengas configurado tu token de GitHub"
fi

echo ""
echo "🔥 Firebase Realtime Database seguirá funcionando perfectamente"
echo "   Tu ESP32 puede continuar enviando datos normalmente"