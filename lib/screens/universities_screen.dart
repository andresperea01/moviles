import 'package:flutter/material.dart';
import '../models/university.dart';
import '../services/university_service.dart';

class UniversitiesScreen extends StatefulWidget {
  const UniversitiesScreen({super.key});

  @override
  State<UniversitiesScreen> createState() => _UniversitiesScreenState();
}

class _UniversitiesScreenState extends State<UniversitiesScreen> {
  final UniversityService _universityService = UniversityService();
  final _formKey = GlobalKey<FormState>();
  
  final _nitController = TextEditingController();
  final _nombreController = TextEditingController();
  final _direccionController = TextEditingController();
  final _telefonoController = TextEditingController();
  final _webController = TextEditingController();
  
  String _searchQuery = '';
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _nitController.dispose();
    _nombreController.dispose();
    _direccionController.dispose();
    _telefonoController.dispose();
    _webController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  // Validador de URL
  String? _validateUrl(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Por favor ingresa la página web';
    }
    final cleanValue = value.trim();
    final urlRegExp = RegExp(
      r'^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?$',
      caseSensitive: false,
    );
    if (!urlRegExp.hasMatch(cleanValue)) {
      return 'Por favor ingresa una URL válida (ej: https://uceva.edu.co)';
    }
    return null;
  }

  // Validador genérico de campo obligatorio
  String? _validateRequired(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return 'El campo $fieldName es obligatorio';
    }
    return null;
  }

  // Mostrar el diálogo/formulario de creación o edición
  void _showFormDialog({University? university}) {
    final isEditing = university != null;
    
    if (isEditing) {
      _nitController.text = university.nit;
      _nombreController.text = university.nombre;
      _direccionController.text = university.direccion;
      _telefonoController.text = university.telefono;
      _webController.text = university.paginaWeb;
    } else {
      _nitController.clear();
      _nombreController.clear();
      _direccionController.clear();
      _telefonoController.clear();
      _webController.clear();
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(28),
              topRight: Radius.circular(28),
            ),
          ),
          padding: EdgeInsets.only(
            left: 24,
            right: 24,
            top: 24,
            bottom: MediaQuery.of(context).viewInsets.bottom + 24,
          ),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        isEditing ? 'Editar Universidad' : 'Nueva Universidad',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.grey),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                  const Divider(height: 20),
                  const SizedBox(height: 10),
                  
                  // Campo NIT
                  TextFormField(
                    controller: _nitController,
                    decoration: InputDecoration(
                      labelText: 'NIT (ej: 890.123.456-7)',
                      prefixIcon: const Icon(Icons.assignment_ind, color: Colors.indigo),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.indigo, width: 2),
                      ),
                    ),
                    validator: (val) => _validateRequired(val, 'NIT'),
                  ),
                  const SizedBox(height: 16),
                  
                  // Campo Nombre
                  TextFormField(
                    controller: _nombreController,
                    decoration: InputDecoration(
                      labelText: 'Nombre de la Universidad',
                      prefixIcon: const Icon(Icons.school, color: Colors.indigo),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.indigo, width: 2),
                      ),
                    ),
                    validator: (val) => _validateRequired(val, 'Nombre'),
                  ),
                  const SizedBox(height: 16),
                  
                  // Campo Dirección
                  TextFormField(
                    controller: _direccionController,
                    decoration: InputDecoration(
                      labelText: 'Dirección física',
                      prefixIcon: const Icon(Icons.place, color: Colors.indigo),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.indigo, width: 2),
                      ),
                    ),
                    validator: (val) => _validateRequired(val, 'Dirección'),
                  ),
                  const SizedBox(height: 16),
                  
                  // Campo Teléfono
                  TextFormField(
                    controller: _telefonoController,
                    decoration: InputDecoration(
                      labelText: 'Teléfono de contacto',
                      prefixIcon: const Icon(Icons.phone, color: Colors.indigo),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.indigo, width: 2),
                      ),
                    ),
                    keyboardType: TextInputType.phone,
                    validator: (val) => _validateRequired(val, 'Teléfono'),
                  ),
                  const SizedBox(height: 16),
                  
                  // Campo Página Web
                  TextFormField(
                    controller: _webController,
                    decoration: InputDecoration(
                      labelText: 'Página Web (ej: https://uceva.edu.co)',
                      prefixIcon: const Icon(Icons.language, color: Colors.indigo),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.indigo, width: 2),
                      ),
                    ),
                    keyboardType: TextInputType.url,
                    validator: _validateUrl,
                  ),
                  const SizedBox(height: 24),
                  
                  // Botón Guardar
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final uni = University(
                          id: isEditing ? university.id : '',
                          nit: _nitController.text.trim(),
                          nombre: _nombreController.text.trim(),
                          direccion: _direccionController.text.trim(),
                          telefono: _telefonoController.text.trim(),
                          paginaWeb: _webController.text.trim(),
                        );
                        
                        try {
                          if (isEditing) {
                            await _universityService.updateUniversity(uni);
                            if (mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Universidad actualizada exitosamente'),
                                  backgroundColor: Colors.indigo,
                                ),
                              );
                            }
                          } else {
                            await _universityService.addUniversity(uni);
                            if (mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Universidad registrada exitosamente'),
                                  backgroundColor: Colors.indigo,
                                ),
                              );
                            }
                          }
                          if (mounted) Navigator.pop(context);
                        } catch (e) {
                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Error al guardar datos: $e'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: Colors.indigo,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 3,
                    ),
                    child: Text(
                      isEditing ? 'Guardar Cambios' : 'Registrar Universidad',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // Eliminar Universidad
  void _confirmDelete(University university) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirmar Eliminación'),
          content: Text('¿Estás seguro de que deseas eliminar la universidad "${university.nombre}"? Esta acción no se puede deshacer.'),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar', style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  await _universityService.deleteUniversity(university.id);
                  if (mounted) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Universidad eliminada correctamente'),
                        backgroundColor: Colors.redAccent,
                      ),
                    );
                  }
                } catch (e) {
                  if (mounted) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Error al eliminar: $e'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                foregroundColor: Colors.white,
              ),
              child: const Text('Eliminar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Universidades Firestore'),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.indigo.shade50, Colors.white],
          ),
        ),
        child: Column(
          children: [
            // Banner de Estado Firebase / Mock
            _buildConnectionBanner(),

            // Buscador
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _searchController,
                  onChanged: (val) {
                    setState(() {
                      _searchQuery = val.trim().toLowerCase();
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Buscar universidad por nombre o NIT...',
                    prefixIcon: const Icon(Icons.search, color: Colors.indigo),
                    suffixIcon: _searchQuery.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear, color: Colors.grey),
                            onPressed: () {
                              _searchController.clear();
                              setState(() {
                                _searchQuery = '';
                              });
                            },
                          )
                        : null,
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
                  ),
                ),
              ),
            ),

            // Stream en Tiempo Real
            Expanded(
              child: StreamBuilder<List<University>>(
                stream: _universityService.getUniversities(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(color: Colors.indigo),
                    );
                  }
                  
                  if (snapshot.hasError) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.error_outline, size: 60, color: Colors.redAccent),
                            const SizedBox(height: 16),
                            const Text(
                              'Error de Conexión',
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              snapshot.error.toString(),
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: Colors.blueGrey),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  final universities = snapshot.data ?? [];
                  
                  // Filtrar lista
                  final filteredList = universities.where((u) {
                    final nombre = u.nombre.toLowerCase();
                    final nit = u.nit.toLowerCase();
                    return nombre.contains(_searchQuery) || nit.contains(_searchQuery);
                  }).toList();

                  if (filteredList.isEmpty) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              _searchQuery.isNotEmpty ? Icons.search_off : Icons.school_outlined,
                              size: 80,
                              color: Colors.indigo.withValues(alpha: 0.4),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              _searchQuery.isNotEmpty
                                  ? 'No se encontraron resultados'
                                  : 'No hay universidades registradas',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueGrey,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              _searchQuery.isNotEmpty
                                  ? 'Prueba buscando con otros términos o registra una universidad'
                                  : 'Presiona el botón "+" para registrar la primera universidad',
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 80),
                    itemCount: filteredList.length,
                    itemBuilder: (context, index) {
                      final uni = filteredList[index];
                      return _buildUniversityCard(uni);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showFormDialog(),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        tooltip: 'Registrar Universidad',
        child: const Icon(Icons.add, size: 28),
      ),
    );
  }

  // Banner de Estado
  Widget _buildConnectionBanner() {
    final isMock = UniversityService.useMock;
    return Container(
      width: double.infinity,
      color: isMock ? Colors.amber.shade800 : Colors.teal.shade700,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isMock ? Icons.cloud_off : Icons.cloud_done,
            color: Colors.white,
            size: 18,
          ),
          const SizedBox(width: 8),
          Text(
            isMock
                ? 'Modo Simulación (Sin Firebase - Almacenamiento Temporal)'
                : 'Firebase Activo - Sincronización en Tiempo Real',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  // Tarjeta de Universidad
  Widget _buildUniversityCard(University uni) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => _showFormDialog(university: uni),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Encabezado: Nombre y Botones de Acción
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Inicial del Nombre de la Universidad
                  Container(
                    width: 46,
                    height: 46,
                    decoration: BoxDecoration(
                      color: Colors.indigo.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.indigo.shade100),
                    ),
                    child: Center(
                      child: Text(
                        uni.nombre.isNotEmpty ? uni.nombre[0].toUpperCase() : 'U',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  
                  // Nombre y NIT
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          uni.nombre,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.indigo,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'NIT: ${uni.nit}',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Botones de acción rápidos
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit_outlined, color: Colors.blueGrey, size: 22),
                        onPressed: () => _showFormDialog(university: uni),
                        tooltip: 'Editar',
                        constraints: const BoxConstraints(),
                        padding: const EdgeInsets.all(8),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete_outline, color: Colors.redAccent, size: 22),
                        onPressed: () => _confirmDelete(uni),
                        tooltip: 'Eliminar',
                        constraints: const BoxConstraints(),
                        padding: const EdgeInsets.all(8),
                      ),
                    ],
                  ),
                ],
              ),
              const Divider(height: 24, thickness: 0.8),
              
              // Detalles: Dirección
              _buildDetailItem(Icons.location_on_outlined, uni.direccion),
              const SizedBox(height: 8),
              
              // Detalles: Teléfono
              _buildDetailItem(Icons.phone_outlined, uni.telefono),
              const SizedBox(height: 8),
              
              // Detalles: Página Web (URL con styling de enlace clickable)
              Row(
                children: [
                  const Icon(Icons.language_outlined, size: 18, color: Colors.indigo),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      uni.paginaWeb,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Componente de detalle
  Widget _buildDetailItem(IconData icon, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18, color: Colors.blueGrey.shade600),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14,
              color: Colors.blueGrey.shade800,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
