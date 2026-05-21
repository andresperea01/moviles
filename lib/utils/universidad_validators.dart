class UniversidadValidators {
  static String? requiredField(String? value, String label) {
    if (value == null || value.trim().isEmpty) {
      return '$label no puede estar vacío';
    }
    return null;
  }

  static String? paginaWeb(String? value) {
    final requiredError = requiredField(value, 'Página web');
    if (requiredError != null) return requiredError;

    final uri = Uri.tryParse(value!.trim());
    final isValid = uri != null &&
        uri.hasScheme &&
        (uri.scheme == 'http' || uri.scheme == 'https') &&
        uri.host.isNotEmpty;

    if (!isValid) {
      return 'Ingrese una URL válida (http o https)';
    }
    return null;
  }
}
