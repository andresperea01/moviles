# Configuración de Firebase — Taller Universidades

## 1. Crear proyecto en Firebase Console

1. Ir a [Firebase Console](https://console.firebase.google.com/).
2. Crear un proyecto (o usar el existente de la asignatura).
3. Activar **Cloud Firestore** en modo de prueba (o con reglas que permitan lectura/escritura para desarrollo).

### Reglas sugeridas (solo desarrollo)

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /universidades/{docId} {
      allow read, write: if true;
    }
  }
}
```

## 2. Registrar la app Flutter

1. En Firebase Console → **Agregar app** → Android.
2. Package name: `com.example.moviles3` (debe coincidir con `applicationId` en `android/app/build.gradle.kts`).
3. Descargar `google-services.json` y colocarlo en:

   `android/app/google-services.json`

4. (Opcional iOS) Registrar app iOS y colocar `GoogleService-Info.plist` en `ios/Runner/`.

## 3. FlutterFire CLI (recomendado)

```bash
dart pub global activate flutterfire_cli
flutterfire configure
```

Esto regenera `lib/firebase_options.dart` con las credenciales correctas.

Si no usa la CLI, edite manualmente los valores `REPLACE_WITH_*` en `lib/firebase_options.dart`.

## 4. Instalar dependencias y ejecutar

```bash
flutter pub get
flutter run
```

## 5. Colección Firestore

| Campo        | Tipo   | Ejemplo                          |
|-------------|--------|----------------------------------|
| nit         | string | 890.123.456-7                    |
| nombre      | string | UCEVA                            |
| direccion   | string | Cra 27A #48-144, Tuluá - Valle   |
| telefono    | string | +57 602 2242202                  |
| pagina_web  | string | https://www.uceva.edu.co         |

Nombre de colección: **`universidades`**

## 6. Evidencias para el PDF

Incluir capturas de:

- Firebase Console: proyecto y apps registradas.
- Firestore: colección `universidades` con documentos.
- App: pantalla **Listado de Universidades** y formulario **Nueva Universidad**.
- App: pantalla **Evidencia — Firestore en vivo**.
