import 'package:flutter/material.dart';

import '../models/universidad.dart';

class UniversidadCard extends StatelessWidget {
  final Universidad universidad;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const UniversidadCard({
    super.key,
    required this.universidad,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.school, color: Colors.indigo),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    universidad.nombre,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (onEdit != null)
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.blue),
                    onPressed: onEdit,
                    tooltip: 'Editar',
                  ),
                if (onDelete != null)
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.redAccent),
                    onPressed: onDelete,
                    tooltip: 'Eliminar',
                  ),
              ],
            ),
            const Divider(),
            _infoRow(Icons.badge, 'NIT', universidad.nit),
            _infoRow(Icons.location_on, 'Dirección', universidad.direccion),
            _infoRow(Icons.phone, 'Teléfono', universidad.telefono),
            _infoRow(Icons.language, 'Web', universidad.paginaWeb),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: Colors.blueGrey),
          const SizedBox(width: 8),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(color: Colors.black87, fontSize: 14),
                children: [
                  TextSpan(
                    text: '$label: ',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  TextSpan(text: value),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
