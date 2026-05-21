import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/universidad.dart';
import '../providers/universidad_provider.dart';
import '../utils/universidad_validators.dart';

class UniversidadFormScreen extends StatefulWidget {
  final Universidad? universidad;

  const UniversidadFormScreen({super.key, this.universidad});

  bool get isEditing => universidad != null;

  @override
  State<UniversidadFormScreen> createState() => _UniversidadFormScreenState();
}

class _UniversidadFormScreenState extends State<UniversidadFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nitController;
  late final TextEditingController _nombreController;
  late final TextEditingController _direccionController;
  late final TextEditingController _telefonoController;
  late final TextEditingController _paginaWebController;

  @override
  void initState() {
    super.initState();
    final u = widget.universidad;
    _nitController = TextEditingController(text: u?.nit ?? '');
    _nombreController = TextEditingController(text: u?.nombre ?? '');
    _direccionController = TextEditingController(text: u?.direccion ?? '');
    _telefonoController = TextEditingController(text: u?.telefono ?? '');
    _paginaWebController = TextEditingController(text: u?.paginaWeb ?? '');
  }

  @override
  void dispose() {
    _nitController.dispose();
    _nombreController.dispose();
    _direccionController.dispose();
    _telefonoController.dispose();
    _paginaWebController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final provider = context.read<UniversidadProvider>();
    provider.resetFormState();

    final universidad = Universidad(
      id: widget.universidad?.id,
      nit: _nitController.text.trim(),
      nombre: _nombreController.text.trim(),
      direccion: _direccionController.text.trim(),
      telefono: _telefonoController.text.trim(),
      paginaWeb: _paginaWebController.text.trim(),
    );

    final ok = widget.isEditing
        ? await provider.updateUniversidad(universidad)
        : await provider.createUniversidad(universidad);

    if (!mounted) return;

    if (ok) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            widget.isEditing
                ? 'Universidad actualizada'
                : 'Universidad creada',
          ),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(provider.errorMessage),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<UniversidadProvider>();
    final isSaving = provider.formState == UniversidadFormState.saving;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isEditing ? 'Editar Universidad' : 'Nueva Universidad',
        ),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nitController,
                decoration: const InputDecoration(
                  labelText: 'NIT',
                  prefixIcon: Icon(Icons.badge),
                  border: OutlineInputBorder(),
                ),
                validator: (v) =>
                    UniversidadValidators.requiredField(v, 'NIT'),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nombreController,
                decoration: const InputDecoration(
                  labelText: 'Nombre',
                  prefixIcon: Icon(Icons.school),
                  border: OutlineInputBorder(),
                ),
                validator: (v) =>
                    UniversidadValidators.requiredField(v, 'Nombre'),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _direccionController,
                decoration: const InputDecoration(
                  labelText: 'Dirección',
                  prefixIcon: Icon(Icons.location_on),
                  border: OutlineInputBorder(),
                ),
                validator: (v) =>
                    UniversidadValidators.requiredField(v, 'Dirección'),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _telefonoController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Teléfono',
                  prefixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder(),
                ),
                validator: (v) =>
                    UniversidadValidators.requiredField(v, 'Teléfono'),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _paginaWebController,
                keyboardType: TextInputType.url,
                decoration: const InputDecoration(
                  labelText: 'Página web',
                  hintText: 'https://www.ejemplo.edu.co',
                  prefixIcon: Icon(Icons.language),
                  border: OutlineInputBorder(),
                ),
                validator: UniversidadValidators.paginaWeb,
              ),
              const SizedBox(height: 32),
              ElevatedButton.icon(
                onPressed: isSaving ? null : _submit,
                icon: isSaving
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Icon(widget.isEditing ? Icons.save : Icons.add),
                label: Text(
                  isSaving
                      ? 'Guardando...'
                      : widget.isEditing
                          ? 'Actualizar'
                          : 'Guardar universidad',
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.indigo,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
