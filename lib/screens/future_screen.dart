import 'package:flutter/material.dart';
import '../services/fake_api_service.dart';

class FutureScreen extends StatefulWidget {
  const FutureScreen({super.key});

  @override
  State<FutureScreen> createState() => _FutureScreenState();
}

class _FutureScreenState extends State<FutureScreen> {
  final FakeApiService _apiService = FakeApiService();
  String _status = "Listo para iniciar";
  bool _isLoading = false;
  String? _result;
  String? _error;

  /// Función asincrónica usando async/await
  Future<void> _handleFetchData() async {
    setState(() {
      _isLoading = true;
      _status = "Cargando...";
      _result = null;
      _error = null;
    });

    try {
      // Llamada al servicio simulado
      final data = await _apiService.fetchData();
      
      setState(() {
        _result = data;
        _status = "Éxito";
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _status = "Error";
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Future & Async/Await'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildStatusCard(),
            const SizedBox(height: 40),
            if (_isLoading)
              const CircularProgressIndicator(color: Colors.blue)
            else
              ElevatedButton.icon(
                onPressed: _handleFetchData,
                icon: const Icon(Icons.cloud_download),
                label: const Text("Consultar Datos", style: TextStyle(fontSize: 18)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusCard() {
    Color statusColor;
    IconData statusIcon;

    switch (_status) {
      case "Éxito":
        statusColor = Colors.green;
        statusIcon = Icons.check_circle;
        break;
      case "Error":
        statusColor = Colors.red;
        statusIcon = Icons.error;
        break;
      case "Cargando...":
        statusColor = Colors.orange;
        statusIcon = Icons.sync;
        break;
      default:
        statusColor = Colors.grey;
        statusIcon = Icons.info_outline;
    }

    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        padding: const EdgeInsets.all(32),
        width: double.infinity,
        child: Column(
          children: [
            Icon(statusIcon, size: 60, color: statusColor),
            const SizedBox(height: 16),
            Text(
              _status,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: statusColor),
            ),
            const SizedBox(height: 12),
            if (_result != null)
              Text(_result!, textAlign: TextAlign.center, style: const TextStyle(fontSize: 16)),
            if (_error != null)
              Text("Error: $_error", textAlign: TextAlign.center, style: TextStyle(color: Colors.red.shade700)),
          ],
        ),
      ),
    );
  }
}
