import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/universidad.dart';
import '../providers/universidad_provider.dart';
import '../services/universidad_service.dart';

/// Vista de evidencia: muestra en tiempo real los datos leídos desde Firestore.
class UniversidadesEvidenceScreen extends StatelessWidget {
  const UniversidadesEvidenceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final stream = context.watch<UniversidadProvider>().universidadesStream;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Evidencia — Firestore en vivo'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: Colors.teal.shade50,
            child: Column(
              children: [
                const Icon(Icons.cloud_sync, size: 48, color: Colors.teal),
                const SizedBox(height: 8),
                const Text(
                  'Datos sincronizados desde Cloud Firestore',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                Text(
                  'Colección: ${UniversidadService.collectionName}',
                  style: TextStyle(color: Colors.teal.shade700),
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<List<Universidad>>(
              stream: stream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                final data = snapshot.data ?? [];

                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Card(
                        color: Colors.teal.shade100,
                        child: ListTile(
                          leading: const Icon(Icons.storage, color: Colors.teal),
                          title: const Text('Registros en la base de datos'),
                          subtitle: Text(
                            '${data.length} documento(s) — actualización en tiempo real',
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: data.isEmpty
                          ? const Center(
                              child: Text(
                                'Sin datos en Firestore.\nCree universidades desde el formulario.',
                                textAlign: TextAlign.center,
                              ),
                            )
                          : ListView.builder(
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                final u = data[index];
                                return Card(
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 6,
                                  ),
                                  child: ExpansionTile(
                                    leading: const Icon(
                                      Icons.school,
                                      color: Colors.teal,
                                    ),
                                    title: Text(
                                      u.nombre,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    subtitle: Text('NIT: ${u.nit}'),
                                    children: [
                                      _evidenceTile('ID documento', u.id ?? '—'),
                                      _evidenceTile('NIT', u.nit),
                                      _evidenceTile('Nombre', u.nombre),
                                      _evidenceTile('Dirección', u.direccion),
                                      _evidenceTile('Teléfono', u.telefono),
                                      _evidenceTile('Página web', u.paginaWeb),
                                    ],
                                  ),
                                );
                              },
                            ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _evidenceTile(String label, String value) {
    return ListTile(
      dense: true,
      title: Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      subtitle: Text(value, style: const TextStyle(fontWeight: FontWeight.w500)),
    );
  }
}
