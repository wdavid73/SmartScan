# 📱 SmartScan - Flutter OCR Document Scanner

SmartScan is a smart mobile application developed in Flutter that allows you to scan physical documents, enhance images, extract text (OCR) and export in PDF format. It is intended as a productivity tool, works offline and is compatible with Android/iOS.

---

## 🚀 Main functionalities.

- 📸 Document scanning from the camera with intelligent overlay.
- 🧾 Edge detection and black/white filters
- 🧠 Offline OCR with ML Kit (language selectable)
- ✍️ Editable preview before exporting
- 📄 PDF export of single or multiple pages
- 🕑 Scan history with integrated viewer
- 📤 Sharing documents as PDF from the device
- ⚙️ Automatic OCR and language settings

---

## 🛠️ Technologies and packages used

| Technology                      | Description                              |
| ------------------------------- | ---------------------------------------- |
| **Flutter**                     | Main cross-platform development SDK      |
| `camera`                        | Capture from rear camera                 |
| `google_mlkit_text_recognition` | Offline OCR by script                    |
| `image`                         | Image filters                            |
| `pdf`                           | Generation of PDF files                  |
| `path_provider`                 | Local file system access                 |
| `share_plus`                    | File sharing from the app                |
| `syncfusion_flutter_pdfviewer`  | Integrated PDF viewer                    |
| `hydrated_bloc`                 | Persistent configuration (OCR, language) |
| `go_router`                     | Structured and maintainable navigation   |

---

## Project structure

```
lib/
├── features/ # Screens: home, scan, preview, history, settings
├── core/ # OCR logic, PDF, camera, configuration
├── models/ # Data models
├── theme/ # Palette and styles
└─── main.dart # Entry point
```

---

## 🧪 MVP status

✅ Scanning, OCR, filters and export

✅ Persistent configuration

✅ History with PDF viewer

🚧 Pending multipage

🚧 OCR editor in text not yet implemented

---

## 🧠 Project Purpose.

- Demonstrate skills with Flutter, native packages, OCR and file management.
- Serve as a technical portfolio for interviews
- To be the basis for productive or corporate scanning apps.

---

## 📃 License

This project is available under the MIT license.
