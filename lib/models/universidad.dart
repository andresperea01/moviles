class Universidad {
  final String? id;
  final String nit;
  final String nombre;
  final String direccion;
  final String telefono;
  final String paginaWeb;

  const Universidad({
    this.id,
    required this.nit,
    required this.nombre,
    required this.direccion,
    required this.telefono,
    required this.paginaWeb,
  });

  factory Universidad.fromFirestore(String id, Map<String, dynamic> data) {
    return Universidad(
      id: id,
      nit: data['nit'] as String? ?? '',
      nombre: data['nombre'] as String? ?? '',
      direccion: data['direccion'] as String? ?? '',
      telefono: data['telefono'] as String? ?? '',
      paginaWeb: data['pagina_web'] as String? ?? '',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'nit': nit,
      'nombre': nombre,
      'direccion': direccion,
      'telefono': telefono,
      'pagina_web': paginaWeb,
    };
  }

  Universidad copyWith({
    String? id,
    String? nit,
    String? nombre,
    String? direccion,
    String? telefono,
    String? paginaWeb,
  }) {
    return Universidad(
      id: id ?? this.id,
      nit: nit ?? this.nit,
      nombre: nombre ?? this.nombre,
      direccion: direccion ?? this.direccion,
      telefono: telefono ?? this.telefono,
      paginaWeb: paginaWeb ?? this.paginaWeb,
    );
  }
}
