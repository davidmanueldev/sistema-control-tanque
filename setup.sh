#!/bin/bash

# Script de configuración para el Sistema de Control de Tanque
# Este script configura Firebase y prepara el entorno de desarrollo

echo "🚀 Configurando Sistema de Control de Tanque con Firebase"
echo "=================================================="

# Verificar si Node.js está instalado
if ! command -v node &> /dev/null; then
    echo "❌ Node.js no está instalado. Por favor instala Node.js primero."
    exit 1
fi

# Verificar si npm está instalado
if ! command -v npm &> /dev/null; then
    echo "❌ npm no está instalado. Por favor instala npm primero."
    exit 1
fi

echo "✅ Node.js y npm están instalados"

# Instalar dependencias
echo "📦 Instalando dependencias..."
npm install

# Verificar si Firebase CLI está instalado globalmente
if ! command -v firebase &> /dev/null; then
    echo "🔧 Firebase CLI no está instalado. Instalando..."
    npm install -g firebase-tools
else
    echo "✅ Firebase CLI ya está instalado"
fi

# Mensaje de configuración de Firebase
echo ""
echo "🔥 CONFIGURACIÓN DE FIREBASE"
echo "=============================="
echo ""
echo "Para completar la configuración, necesitas:"
echo ""
echo "1. Ir a https://console.firebase.google.com/"
echo "2. Crear un nuevo proyecto llamado 'tanque-control-system'"
echo "3. Habilitar Realtime Database"
echo "4. Habilitar Authentication con 'Anonymous'"
echo "5. Habilitar Hosting"
echo ""
echo "6. Ejecutar: firebase login"
echo "7. Ejecutar: firebase init"
echo "   - Seleccionar Database, Hosting"
echo "   - Usar proyecto existente: tanque-control-system"
echo "   - Usar public como directorio de hosting"
echo "   - Configurar como SPA: Sí"
echo ""
echo "8. Actualizar las credenciales en index.html con las de tu proyecto"
echo ""
echo "9. Para desarrollo local: npm run dev"
echo "10. Para deploy: npm run deploy"
echo ""
echo "📊 ESTRUCTURA DE DATOS EN FIREBASE"
echo "=================================="
echo ""
echo "La base de datos tendrá esta estructura:"
echo ""
echo "tanque-control-system/"
echo "├── tanque/"
echo "│   ├── actual/"
echo "│   │   ├── nivel: (0-100)"
echo "│   │   ├── estado_bomba: (true/false)"
echo "│   │   ├── timestamp: (ISO string)"
echo "│   │   ├── sensor_temperatura: (°C)"
echo "│   │   ├── presion: (bar)"
echo "│   │   └── flujo: (L/min)"
echo "│   └── historico/"
echo "│       └── [timestamp]: { datos históricos }"
echo "├── logs/"
echo "│   └── [timestamp]: { eventos del sistema }"
echo "└── config/"
echo "    ├── alertas_habilitadas: true"
echo "    ├── nivel_minimo: 10"
echo "    ├── nivel_maximo: 95"
echo "    └── intervalo_actualizacion: 5000"
echo ""
echo "🎯 EJEMPLO DE DATOS PARA PRUEBAS"
echo "================================"
echo ""
echo "Puedes insertar estos datos de prueba en Firebase Database:"
echo ""
echo '{'
echo '  "tanque": {'
echo '    "actual": {'
echo '      "nivel": 45.5,'
echo '      "estado_bomba": true,'
echo '      "timestamp": "'$(date -u +"%Y-%m-%dT%H:%M:%S.%3NZ")'",'
echo '      "sensor_temperatura": 24.5,'
echo '      "presion": 1.3,'
echo '      "flujo": 7.2'
echo '    }'
echo '  },'
echo '  "config": {'
echo '    "alertas_habilitadas": true,'
echo '    "nivel_minimo": 10,'
echo '    "nivel_maximo": 95,'
echo '    "intervalo_actualizacion": 5000'
echo '  }'
echo '}'
echo ""
echo "🚀 ¡Configuración completada!"
echo ""
echo "Comandos útiles:"
echo "- npm run dev      : Servidor de desarrollo local"
echo "- npm run deploy   : Deploy a Firebase Hosting"
echo "- firebase emulators:start : Emuladores locales"
echo ""