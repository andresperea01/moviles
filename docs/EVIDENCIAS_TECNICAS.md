# Descripción técnica — Módulo Firebase Universidades

## Arquitectura

El módulo sigue una arquitectura en capas alineada con el resto del proyecto:

| Capa        | Responsabilidad                                      |
|------------|-------------------------------------------------------|
| **Model**  | `Universidad` — mapeo Firestore ↔ objeto Dart          |
| **Service**| `UniversidadService` — CRUD y stream de Firestore    |
| **Provider**| `UniversidadProvider` — estado del formulario y orquestación |
| **UI**     | Pantallas de listado, formulario y evidencia         |

```
HomeScreen
    ├── UniversidadesListScreen  → Stream (tiempo real)
    │       └── UniversidadFormScreen (crear / editar)
    └── UniversidadesEvidenceScreen → Stream (evidencia)
```

## Conexión con Firebase

- Inicialización en `main()` con `Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)`.
- Paquetes: `firebase_core`, `cloud_firestore` (FlutterFire).
- Colección: `universidades` en Cloud Firestore.

## Estado

- **Listado y evidencia**: `StreamBuilder` sobre `UniversidadService.watchUniversidades()`, que escucha `snapshots()` de Firestore (sincronización en tiempo real).
- **Formulario**: `UniversidadProvider` expone `UniversidadFormState` (`idle`, `saving`, `success`, `error`) para feedback al guardar.

## Operaciones CRUD

| Operación | Implementación                          | UI                          |
|-----------|-----------------------------------------|-----------------------------|
| Create    | `collection.add()`                      | Nueva Universidad (FAB +)   |
| Read      | `snapshots()` + `orderBy('nombre')`     | Listado + Evidencia         |
| Update    | `doc(id).update()`                      | Editar desde tarjeta        |
| Delete    | `doc(id).delete()`                      | Icono eliminar + confirmación |

## Validaciones

Archivo: `lib/utils/universidad_validators.dart`

- **Campos obligatorios**: nit, nombre, direccion, telefono — no pueden estar vacíos (trim).
- **pagina_web**: obligatorio y debe ser URL válida con esquema `http` o `https` y host no vacío (`Uri.tryParse`).

## Rutas

- `/universidades` — Listado de Universidades
- `/universidades-evidence` — Evidencia Firestore en vivo
- Formulario: navegación con `MaterialPageRoute` (crear/editar)
