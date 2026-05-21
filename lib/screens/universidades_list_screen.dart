import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/universidad.dart';
import '../providers/universidad_provider.dart';
import '../widgets/universidad_card.dart';
import 'universidad_form_screen.dart';

class UniversidadesListScreen extends StatelessWidget {
  const UniversidadesListScreen({super.key});

  Future<void> _confirmDelete(
    BuildContext context,
    Universidad universidad,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Eliminar universidad'),
        content: Text('¿Eliminar "${universidad.nombre}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Eliminar', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      final ok = await context
          .read<UniversidadProvider>()
          .deleteUniversidad(universidad.id!);
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            ok ? 'Universidad eliminada' : 'Error al eliminar',
          ),
          backgroundColor: ok ? Colors.green : Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final stream = context.watch<UniversidadProvider>().universidadesStream;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Listado de Universidades'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: StreamBuilder<List<Universidad>>(
        stream: stream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  'Error al cargar datos:\n${snapshot.error}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final universidades = snapshot.data ?? [];

          if (universidades.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.school_outlined, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'No hay universidades registradas',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Use el botón + para agregar una',
                    style: TextStyle(color: Colors.blueGrey),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: universidades.length,
            itemBuilder: (context, index) {
              final u = universidades[index];
              return UniversidadCard(
                universidad: u,
                onEdit: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => UniversidadFormScreen(universidad: u),
                    ),
                  );
                },
                onDelete: () => _confirmDelete(context, u),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const UniversidadFormScreen(),
            ),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('Nueva'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
    );
  }
}
