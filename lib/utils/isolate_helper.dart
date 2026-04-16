import 'dart:isolate';

class IsolateHelper {
  /// Función pesada que se ejecutará en un Isolate secundario.
  static void heavyComputation(SendPort sendPort) {
    print('--- Isolate: Iniciando tarea pesada en Isolate secundario ---');
    
    int count = 0;
    // Tarea pesada: Suma masiva
    for (int i = 0; i <= 1000000000; i++) {
      count += i;
    }
    
    print('--- Isolate: Tarea terminada, enviando resultado ---');
    sendPort.send(count);
  }

  /// Método para iniciar el Isolate y recibir el resultado.
  static Future<int> runHeavyTask() async {
    final receivePort = ReceivePort();
    
    try {
      await Isolate.spawn(heavyComputation, receivePort.sendPort);
      // Esperamos el primer mensaje emitido por el SendPort
      final result = await receivePort.first;
      return result as int;
    } catch (e) {
      print('Error en Isolate: $e');
      rethrow;
    } finally {
      receivePort.close();
    }
  }
}
