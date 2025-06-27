# 📱 SmartScan – Flutter OCR Document Scanner

SmartScan es una aplicación móvil inteligente desarrollada en Flutter que permite escanear documentos físicos, mejorar imágenes, extraer texto (OCR) y exportar en formato PDF. Está pensada como herramienta de productividad, funciona sin conexión y es compatible con Android/iOS.

---

## 🚀 Funcionalidades principales

- 📸 Escaneo de documentos desde la cámara con overlay inteligente
- 🧾 Detección de bordes y filtros en blanco/negro
- 🧠 OCR offline con ML Kit (idioma seleccionable)
- ✍️ Previsualización editable antes de exportar
- 📄 Exportación a PDF de una o varias páginas
- 🕑 Historial de escaneos con visor integrado
- 📤 Compartir documentos como PDF desde el dispositivo
- ⚙️ Configuración de OCR automático e idioma

---

## 🛠️ Tecnologías y paquetes usados

| Tecnología                      | Descripción                                 |
| ------------------------------- | ------------------------------------------- |
| **Flutter**                     | SDK principal de desarrollo multiplataforma |
| `camera`                        | Captura desde cámara trasera                |
| `google_mlkit_text_recognition` | OCR offline por script                      |
| `image`                         | Filtros de imagen                           |
| `pdf`                           | Generación de archivos PDF                  |
| `path_provider`                 | Acceso al sistema de archivos local         |
| `share_plus`                    | Compartir archivos desde la app             |
| `syncfusion_flutter_pdfviewer`  | Visor de PDF integrado                      |
| `hydrated_bloc`                 | Configuración persistente (OCR, idioma)     |
| `go_router`                     | Navegación estructurada y mantenible        |

---

## 📂 Estructura del proyecto

```
lib/
├── features/ # Pantallas: home, scan, preview, history, settings
├── core/ # Lógica OCR, PDF, cámara, configuración
├── models/ # Modelos de datos
├── theme/ # Paleta y estilos
└── main.dart # Punto de entrada
```

---

## 🧪 Estado del MVP

✅ Escaneo, OCR, filtros y exportación  
✅ Configuración persistente  
✅ Historial con visor PDF  
🚧 Multipágina pendiente  
🚧 Editor OCR en texto aún no implementado

---

## 🧠 Propósito del proyecto

- Demostrar habilidades con Flutter, paquetes nativos, OCR y manejo de archivos
- Servir como portfolio técnico para entrevistas
- Ser base para apps productivas o de escaneo corporativo

---

## 📃 Licencia

Este proyecto está disponible bajo la licencia MIT.
