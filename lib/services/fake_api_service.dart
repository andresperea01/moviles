import 'dart:async';

class FakeApiService {
  Future<String> fetchData() async {
    print('--- FakeApiService: Antes de la llamada ---');
    
    // Simulamos una demora de red
    await Future.delayed(Duration(seconds: 3), () {
      print('--- FakeApiService: Durante la ejecución (procesando...) ---');
    });

    // Simulación de éxito
    print('--- FakeApiService: Después de recibir la respuesta ---');
    return "¡Datos obtenidos con éxito!";
    
    // Descomentar para probar el estado de error
    // throw Exception("Error al conectar con el servidor.");
  }
}
