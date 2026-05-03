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

## 🔄 GitFlow (Propuesta)

Para trabajar de manera profesional en este proyecto, se recomienda:
1. **Rama principal**: `main` (Código listo para producción).
2. **Rama de desarrollo**: `dev` (Integración de nuevas funciones).
3. **Flujo para esta tarea**:
   - `git checkout -b feature/taller_segundo_plano dev`
   - Realizar commits descriptivos de cada pantalla.
   - Subir la rama y crear un **Pull Request (PR)** hacia `dev`.
   - Una vez aprobado y probado, hacer merge a `main`.

### GitFlow — Distribución (Firebase App Distribution)

1. Asegurar ramas: `main` y `dev` (crear `dev` desde `main` si aún no existe en remoto).
2. `git checkout dev` → `git pull`
3. `git checkout -b feature/app_distribution dev`
4. Trabajar, commit y `git push -u origin feature/app_distribution`
5. Abrir **Pull Request**: `feature/app_distribution` → `dev`
6. Tras revisión: merge a `dev`, luego integrar `dev` → `main` cuando corresponda.

**Repositorio de la asignatura:** [https://github.com/andresperea01/moviles](https://github.com/andresperea01/moviles)

---

## 📦 Publicación (Firebase App Distribution)

Flujo resumido: **Generar APK → Firebase App Distribution → Testers → Instalación → Actualización**.

### 1. Generar APK de release

En la raíz del proyecto:

```bash
flutter pub get
flutter build apk
```

El APK queda en `build/app/outputs/flutter-apk/app-release.apk`.

### 2. Versionado (Flutter)

En `pubspec.yaml`, el campo `version` usa el formato **`versionName+versionCode`** (ej. `1.0.1+2`):

- **versionName** (antes del `+`): lo ven los usuarios (ej. 1.0.1).
- **versionCode** (después del `+`): entero incremental obligatorio para que Android acepte actualizaciones sobre una instalación anterior.

Para una segunda entrega en App Distribution, sube siempre un **versionCode mayor** (y, si aplica, sube también el versionName). Referencia: [Despliegue Android — Flutter](https://docs.flutter.dev/deployment/android).

### 3. Firebase Console

1. Crear o abrir el proyecto en [Firebase Console](https://console.firebase.google.com/).
2. **Registrar la app Android** con el mismo **applicationId** que en `android/app/build.gradle.kts` (`applicationId`, actualmente `com.example.moviles3`).
3. Ir a **App Distribution** → **Testers y grupos**:
   - Crear un grupo (ej. **QA_Clase**).
   - Añadir el tester **dduran@uceva.edu.co** (y los correos que indique el equipo).
4. **Releases** → Subir `app-release.apk` → asignar el grupo **QA_Clase** → **Release notes** claras → distribuir.
5. Copiar el **enlace de instalación** para las evidencias.

Documentación oficial: [Firebase App Distribution](https://firebase.google.com/docs/app-distribution).

### 4. Release notes (buena práctica)

Incluir en cada release, de forma breve:

- Fecha y responsable(s).
- **Qué cambió** (funcionalidad, correcciones).
- Credenciales o pasos de prueba si aplica.
- Número de versión alineado con `pubspec.yaml` (ej. 1.0.1 build 2).

### 5. Evidencias y QA

- Comprobar invitación por correo y/o instalación por enlace.
- Probar en **dispositivo físico** Android.
- Para evidenciar **actualización** (ej. 1.0.0 → 1.0.1): subir primero un build con versión anterior, instalar; luego subir el build nuevo con **versionCode** mayor y verificar en Firebase **Releases** el historial antes/después.
- **Bitácora de QA** (recomendado, máx. ~1 página): versión, fecha, cambios, incidencias encontradas/resueltas, estado de pruebas.

### 6. Entregables académicos

- Código en el repo con la rama/PR según GitFlow acordado.
- **PDF unificado** con: URL del repo en la primera página, capturas de Releases y testers (visible **dduran@uceva.edu.co**), correo de invitación, app instalada en dispositivo, evidencia de actualización y bitácora de QA.

---

