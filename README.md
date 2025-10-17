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
