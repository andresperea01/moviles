# Taller de Asincronía en Flutter 🚀

Este proyecto es una demostración práctica de cómo manejar tareas en segundo plano, comunicación asincrónica y procesamiento pesado en Flutter.

## 🎯 Objetivos del Proyecto

Demostrar el uso de:
- **Future / Async / Await**: Para peticiones de datos y flujos de control asincrónicos.
- **Timer**: Para la creación de cronómetros y control de tiempo en la UI.
- **Isolate**: Para ejecutar tareas pesadas en hilos separados sin bloquear el hilo principal (UI Thread).

---

## 📚 Conceptos Clave

### 1. ¿Qué es un Future?
Un `Future` representa un valor o un error que estará disponible en algún momento en el futuro. Es la base de la programación asincrónica en Dart.
- **Uso**: Peticiones HTTP, lectura de archivos, retardos simulados.

### 2. ¿Qué es Async / Await?
Son palabras clave que permiten escribir código asincrónico con una sintaxis que parece sincrónica, lo que facilita la lectura y el mantenimiento.
- `async`: Marca una función para que devuelva un `Future`.
- `await`: Detiene la ejecución de la función hasta que el `Future` se complete.

### 3. ¿Cuándo usar un Timer?
El `Timer` se utiliza cuando necesitamos ejecutar una acción después de un retraso o de forma periódica (cada N segundos).
- **Ejemplo**: Cronómetros, cuentas regresivas, polling de datos.

### 4. ¿Cuándo usar un Isolate?
Por defecto, Dart se ejecuta en un solo hilo. Si realizamos una tarea muy pesada (como procesar miles de imágenes o cálculos matemáticos masivos), la aplicación se "congelará" (jank).
- **Isolate**: Crea un espacio de memoria y un hilo separado para realizar esa tarea sin afectar la fluidez de la interfaz.

---

## 🧭 Estructura del Proyecto

```text
lib/
├── main.dart                # Punto de entrada y rutas
├── screens/                 # Interfaces de usuario
│   ├── home_screen.dart     # Menú principal
│   ├── future_screen.dart   # Demo de carga de datos
│   ├── timer_screen.dart    # Demo de cronómetro
│   └── isolate_screen.dart  # Demo de tarea pesada
├── services/
│   └── fake_api_service.dart # Simulación de API con Future
├── utils/
│   └── isolate_helper.dart  # Lógica de comunicación con Isolate
```

---


---

## 🔥 Módulo Firebase — Universidades

Taller de integración con **Cloud Firestore** (rama `feature/taller_firebase_universidades`).

### Funcionalidades

- CRUD sobre la colección `universidades` (nit, nombre, direccion, telefono, pagina_web).
- Listado en **tiempo real** con `StreamBuilder` + `snapshots()`.
- Formulario **Nueva Universidad** con validación de campos y URL.
- Pantalla de **evidencia** con datos leídos en vivo desde Firestore.

### Configuración

Ver [docs/FIREBASE_SETUP.md](docs/FIREBASE_SETUP.md) y descripción técnica en [docs/EVIDENCIAS_TECNICAS.md](docs/EVIDENCIAS_TECNICAS.md).

### Estructura del módulo

```text
lib/
├── firebase_options.dart
├── models/universidad.dart
├── services/universidad_service.dart
├── providers/universidad_provider.dart
├── utils/universidad_validators.dart
├── widgets/universidad_card.dart
└── screens/
    ├── universidades_list_screen.dart
    ├── universidad_form_screen.dart
    └── universidades_evidence_screen.dart
```

---

## 🔄 GitFlow (Propuesta)

Para trabajar de manera profesional en este proyecto, se recomienda:
1. **Rama principal**: `main` (Código listo para producción).
2. **Rama de desarrollo**: `dev` (Integración de nuevas funciones).
3. **Flujo para esta tarea**:
   - `git checkout -b feature/taller_segundo_plano dev`
   - Realizar commits descriptivos de cada pantalla.
   - Subir la rama y crear un **Pull Request (PR)** hacia `dev`.
   - Una vez aprobado y probado, hacer merge a `main`.

---

