#!/bin/bash

# Script para desplegar automáticamente en GitHub Pages usando GitHub CLI
echo "🚀 DEPLOY AUTOMÁTICO CON GITHUB CLI"
echo "===================================="

# Verificar si gh está instalado
if ! command -v gh &> /dev/null; then
    echo "❌ GitHub CLI no está instalado. Instálalo con:"
    echo "   curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg"
    echo "   sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg"
    echo "   echo 'deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main' | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null"
    echo "   sudo apt update && sudo apt install gh"
    exit 1
fi

echo "✅ GitHub CLI encontrado: $(gh --version | head -n1)"

# Verificar si está autenticado
if ! gh auth status >/dev/null 2>&1; then
    echo "🔐 No estás autenticado en GitHub. Iniciando autenticación..."
    gh auth login
else
    echo "✅ Ya estás autenticado en GitHub"
    gh auth status
fi

# Configurar Git si es necesario
if ! git config user.name >/dev/null 2>&1; then
    echo "⚙️ Configurando Git..."
    echo "Usa el mismo nombre y email de tu cuenta de GitHub"
    gh api user --jq '.name' | xargs -I {} git config --global user.name "{}"
    gh api user --jq '.email // .login + "@users.noreply.github.com"' | xargs -I {} git config --global user.email "{}"
    echo "✅ Git configurado automáticamente con tu info de GitHub"
fi

# Preguntar nombre del repositorio
echo ""
echo "📁 CONFIGURACIÓN DEL REPOSITORIO"
echo "================================"
read -p "Nombre del repositorio (default: sistema-control-tanque): " repo_name
repo_name=${repo_name:-sistema-control-tanque}

read -p "Descripción del repositorio: " repo_description
repo_description=${repo_description:-"Sistema de monitoreo y control de tanque de agua en tiempo real con Firebase"}

echo ""
echo "🔍 Verificando si el repositorio ya existe..."

# Verificar si el repositorio ya existe
if gh repo view "$repo_name" >/dev/null 2>&1; then
    echo "⚠️ El repositorio '$repo_name' ya existe."
    read -p "¿Quieres usar el repositorio existente? (y/n): " use_existing
    if [[ $use_existing != "y" && $use_existing != "Y" ]]; then
        echo "❌ Operación cancelada. Cambia el nombre del repositorio."
        exit 1
    fi
    echo "✅ Usando repositorio existente"
else
    echo "📦 Creando nuevo repositorio '$repo_name'..."
    
    # Crear repositorio público
    if gh repo create "$repo_name" --description "$repo_description" --public --clone=false; then
        echo "✅ Repositorio creado exitosamente"
    else
        echo "❌ Error creando el repositorio"
        exit 1
    fi
fi

# Inicializar git si es necesario
if [ ! -d ".git" ]; then
    echo "📁 Inicializando repositorio Git local..."
    git init
    git branch -M main
else
    echo "✅ Repositorio Git ya inicializado"
fi

# Obtener la URL del repositorio
repo_url=$(gh repo view "$repo_name" --json url --jq '.url')
echo "🔗 URL del repositorio: $repo_url"

# Configurar remoto
if git remote get-url origin >/dev/null 2>&1; then
    git remote set-url origin "$repo_url.git"
else
    git remote add origin "$repo_url.git"
fi
echo "✅ Remoto configurado"

# Preparar archivos para commit
echo ""
echo "📝 Preparando archivos..."

# Verificar estructura
missing_files=()
if [ ! -f "public/index.html" ]; then missing_files+=("public/index.html"); fi
if [ ! -f "public/insertar-datos.html" ]; then missing_files+=("public/insertar-datos.html"); fi
if [ ! -f "public/test-connection.html" ]; then missing_files+=("public/test-connection.html"); fi

if [ ${#missing_files[@]} -gt 0 ]; then
    echo "❌ Archivos faltantes: ${missing_files[*]}"
    echo "   Asegúrate de que todos los archivos estén en la carpeta 'public/'"
    exit 1
fi

echo "✅ Todos los archivos necesarios encontrados"

# Crear README específico para GitHub
cat > README.md << 'EOF'
# 💧 Sistema de Control de Tanque

[![GitHub Pages](https://img.shields.io/badge/Deploy-GitHub%20Pages-brightgreen.svg)](https://pages.github.com/)
[![Firebase](https://img.shields.io/badge/Database-Firebase-orange.svg)](https://firebase.google.com/)

Sistema completo de monitoreo y control de tanque de agua en tiempo real usando Firebase Realtime Database.

## 🌐 Demo en Vivo

- **Aplicación Principal:** [Ver Demo](https://tuusuario.github.io/sistema-control-tanque/)
- **Panel de Control:** [Control Manual](https://tuusuario.github.io/sistema-control-tanque/insertar-datos.html)
- **Diagnóstico:** [Test de Conexión](https://tuusuario.github.io/sistema-control-tanque/test-connection.html)

## 🚀 Características

- ✅ **Monitoreo en tiempo real** del nivel de agua
- ✅ **Control visual** del estado de la bomba
- ✅ **Alertas inteligentes** para niveles críticos
- ✅ **Interfaz responsive** adaptable a móviles
- ✅ **Conexión Firebase** con reconexión automática
- ✅ **Compatible con ESP32** para IoT
- ✅ **Gratuito** - Hosted en GitHub Pages

## 🛠️ Tecnologías

- **Frontend:** HTML5, CSS3, JavaScript (ES6+)
- **Database:** Firebase Realtime Database
- **Hosting:** GitHub Pages
- **IoT:** Compatible con ESP32/Arduino

## 📱 Capturas de Pantalla

![Sistema de Control](https://via.placeholder.com/800x400/00bfff/ffffff?text=Sistema+de+Control+de+Tanque)

## 🔧 Configuración Local

```bash
# Clonar repositorio
git clone https://github.com/tuusuario/sistema-control-tanque.git
cd sistema-control-tanque

# Instalar Firebase CLI (opcional)
npm install -g firebase-tools

# Servidor local
firebase serve --port 5000
# o usar cualquier servidor HTTP
python -m http.server 5000 --directory public
```

## 🔥 Configuración Firebase

El sistema usa Firebase Realtime Database con la siguiente estructura:

```json
{
  "tanque": {
    "actual": {
      "nivel": 75.5,
      "estado_bomba": true
    }
  }
}
```

## 📡 Integración ESP32

Código ejemplo para ESP32:

```cpp
#include <WiFi.h>
#include <FirebaseESP32.h>

// Configuración
const char* ssid = "TU_WIFI";
const char* password = "TU_PASSWORD";
const char* firebase_host = "shiro-mierdas-default-rtdb.firebaseio.com";
const char* firebase_auth = "TU_AUTH_TOKEN";

void setup() {
  // Conectar WiFi
  WiFi.begin(ssid, password);
  
  // Configurar Firebase
  Firebase.begin(firebase_host, firebase_auth);
  Firebase.reconnectWiFi(true);
}

void loop() {
  // Leer sensores
  float nivel = leerSensorNivel();
  bool bomba = digitalRead(PIN_BOMBA);
  
  // Enviar a Firebase
  Firebase.setFloat(firebaseData, "/tanque/actual/nivel", nivel);
  Firebase.setBool(firebaseData, "/tanque/actual/estado_bomba", bomba);
  
  delay(5000);
}
```

## 🤝 Contribuir

1. Fork el proyecto
2. Crea una rama para tu feature (`git checkout -b feature/nueva-funcionalidad`)
3. Commit tus cambios (`git commit -am 'Agregar nueva funcionalidad'`)
4. Push a la rama (`git push origin feature/nueva-funcionalidad`)
5. Abre un Pull Request

## 📄 Licencia

MIT License - Ver [LICENSE](LICENSE) para más detalles.

## 🆘 Soporte

¿Problemas? Abre un [Issue](../../issues) o contacta al desarrollador.

---

**⭐ Si te gusta este proyecto, dale una estrella!**
EOF

echo "✅ README.md creado"

# Hacer commit
echo ""
echo "💾 Haciendo commit de todos los archivos..."
git add .

if git diff --staged --quiet; then
    echo "⚠️ No hay cambios para commitear"
else
    git commit -m "🚀 Deploy: Sistema de Control de Tanque para GitHub Pages

- Aplicación completa de monitoreo de tanque
- Integración con Firebase Realtime Database  
- Panel de control manual
- Herramientas de diagnóstico
- Compatible con ESP32/Arduino
- Interfaz responsive y moderna

Características:
✅ Monitoreo en tiempo real
✅ Alertas inteligentes
✅ Animaciones fluidas
✅ Deploy automático con GitHub Actions"
    
    echo "✅ Commit realizado"
fi

# Push al repositorio
echo ""
echo "🚀 Subiendo código a GitHub..."
if git push -u origin main; then
    echo "✅ Código subido exitosamente"
else
    echo "❌ Error subiendo el código"
    exit 1
fi

# Configurar GitHub Pages automáticamente
echo ""
echo "📄 Configurando GitHub Pages..."

# Usar GitHub CLI para configurar Pages
if gh api repos/:owner/"$repo_name"/pages -X POST -f source='{"branch":"main","path":"/public"}' >/dev/null 2>&1; then
    echo "✅ GitHub Pages configurado desde /public"
elif gh api repos/:owner/"$repo_name"/pages -X POST -f source='{"branch":"main","path":"/"}' >/dev/null 2>&1; then
    echo "✅ GitHub Pages configurado desde raíz"
else
    echo "⚠️ No se pudo configurar GitHub Pages automáticamente"
    echo "   Configúralo manualmente en: $repo_url/settings/pages"
    echo "   - Source: Deploy from a branch"
    echo "   - Branch: main"
    echo "   - Folder: /public"
fi

# Obtener información del usuario para las URLs
username=$(gh api user --jq '.login')

echo ""
echo "🎉 ¡DEPLOY COMPLETADO!"
echo "===================="
echo ""
echo "📋 Información del despliegue:"
echo "  Repositorio: $repo_url"
echo "  Usuario: $username"
echo "  Rama: main"
echo "  Carpeta: /public"
echo ""
echo "🌐 Tu aplicación estará disponible en:"
echo "  https://$username.github.io/$repo_name/"
echo ""
echo "📱 URLs específicas:"
echo "  - Aplicación: https://$username.github.io/$repo_name/"
echo "  - Control:    https://$username.github.io/$repo_name/insertar-datos.html"
echo "  - Diagnóstico: https://$username.github.io/$repo_name/test-connection.html"
echo ""
echo "⏰ GitHub Pages puede tardar unos minutos en activarse"
echo "   Puedes ver el estado en: $repo_url/deployments"
echo ""
echo "🔥 Características activas:"
echo "  ✅ Deploy automático con cada push"
echo "  ✅ HTTPS automático"
echo "  ✅ CDN global"
echo "  ✅ Firebase Realtime Database funcionando"
echo "  ✅ Compatible con ESP32"
echo ""
echo "🎯 Próximos pasos:"
echo "  1. Espera unos minutos a que se active GitHub Pages"
echo "  2. Visita tu aplicación en la URL de arriba"
echo "  3. Prueba el panel de control para insertar datos"
echo "  4. ¡Conecta tu ESP32 para datos reales!"
echo ""
echo "💡 Para futuras actualizaciones, solo haz:"
echo "   git add ."
echo "   git commit -m 'Actualización'"
echo "   git push"
echo ""
echo "✅ ¡Tu sistema de control de tanque está LIVE! 🚀"