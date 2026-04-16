import 'package:flutter/material.dart';
import '../utils/isolate_helper.dart';

class IsolateScreen extends StatefulWidget {
  const IsolateScreen({super.key});

  @override
  State<IsolateScreen> createState() => _IsolateScreenState();
}

class _IsolateScreenState extends State<IsolateScreen> {
  bool _isComputing = false;
  int? _result;

  Future<void> _startComputation() async {
    setState(() {
      _isComputing = true;
      _result = null;
    });

    try {
      // Ejecutamos la tarea en un isolate separado para no bloquear la UI
      final result = await IsolateHelper.runHeavyTask();
      
      setState(() {
        _result = result;
      });
    } catch (e) {
      debugPrint("Error al ejecutar Isolate: $e");
    } finally {
      setState(() {
        _isComputing = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Isolate Demo'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Computación en Segundo Plano',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              const Text(
                'Esta tarea suma de 1 a 1,000,000,000. Sin Isolate, la app se congelaría.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 48),
              if (_isComputing) ...[
                const CircularProgressIndicator(color: Colors.deepPurple),
                const SizedBox(height: 16),
                const Text("Calculando en Isolate...", style: TextStyle(fontStyle: FontStyle.italic)),
              ] else ...[
                ElevatedButton.icon(
                  onPressed: _startComputation,
                  icon: const Icon(Icons.bolt),
                  label: const Text("Iniciar Tarea Pesada"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ],
              const SizedBox(height: 40),
              if (_result != null)
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.shade50,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.deepPurple.shade100),
                  ),
                  child: Column(
                    children: [
                      const Text("Resultado:", style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(
                        _result.toString(),
                        style: const TextStyle(fontSize: 18, fontFamily: 'Courier'),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
