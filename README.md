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

## ⚙️ Cómo ejecutar el proyecto

1. Asegúrate de tener Flutter instalado (`flutter doctor`).
2. Clona o abre el proyecto en tu editor favorito.
3. Ejecuta `flutter pub get` para descargar dependencias.
4. Conecta un emulador o dispositivo físico.
5. Ejecuta:
   ```bash
   flutter run
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

## 📸 Evidencias solicitadas

Deberás capturar las siguientes pantallas durante la ejecución:
1. **Cronómetro**: Captura al iniciar, pausar y reiniciar el tiempo.
2. **Future Screen**: Captura del estado "Cargando..." y del resultado final "Éxito".
3. **Isolate Screen**: Captura del resultado tras la computación pesada y los mensajes correspondientes en la **consola de depuración**.
