import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Taller Asincronía Flutter'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: Container(
        padding: const EdgeInsets.all(24.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.indigo.shade50, Colors.white],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(Icons.flash_on, size: 80, color: Colors.indigo),
            const SizedBox(height: 20),
            const Text(
              'Bienvenido al Taller',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.indigo),
            ),
            const SizedBox(height: 10),
            const Text(
              'Explora las capacidades de Flutter en segundo plano y asincronía',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.blueGrey),
            ),
            const SizedBox(height: 48),
            _buildNavButton(
              context, 
              'Future Demo', 
              Icons.hourglass_empty, 
              '/future',
              Colors.blue,
            ),
            const SizedBox(height: 16),
            _buildNavButton(
              context, 
              'Timer Demo', 
              Icons.timer, 
              '/timer',
              Colors.orange,
            ),
            const SizedBox(height: 16),
            _buildNavButton(
              context, 
              'Isolate Demo', 
              Icons.memory, 
              '/isolate',
              Colors.deepPurple,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavButton(BuildContext context, String title, IconData icon, String route, Color color) {
    return ElevatedButton.icon(
      icon: Icon(icon, size: 28),
      label: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
      onPressed: () => Navigator.pushNamed(context, route),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        backgroundColor: color,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 4,
      ),
    );
  }
}
