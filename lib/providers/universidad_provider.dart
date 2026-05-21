import 'package:flutter/material.dart';

import '../models/universidad.dart';
import '../services/universidad_service.dart';

enum UniversidadFormState { idle, saving, success, error }

class UniversidadProvider with ChangeNotifier {
  final UniversidadService _service = UniversidadService();

  UniversidadFormState _formState = UniversidadFormState.idle;
  String _errorMessage = '';

  UniversidadFormState get formState => _formState;
  String get errorMessage => _errorMessage;

  Stream<List<Universidad>> get universidadesStream =>
      _service.watchUniversidades();

  Future<bool> createUniversidad(Universidad universidad) async {
    _formState = UniversidadFormState.saving;
    _errorMessage = '';
    notifyListeners();

    try {
      await _service.create(universidad);
      _formState = UniversidadFormState.success;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      _formState = UniversidadFormState.error;
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateUniversidad(Universidad universidad) async {
    _formState = UniversidadFormState.saving;
    _errorMessage = '';
    notifyListeners();

    try {
      await _service.update(universidad);
      _formState = UniversidadFormState.success;
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      _formState = UniversidadFormState.error;
      notifyListeners();
      return false;
    }
  }

  Future<bool> deleteUniversidad(String id) async {
    try {
      await _service.delete(id);
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  void resetFormState() {
    _formState = UniversidadFormState.idle;
    _errorMessage = '';
    notifyListeners();
  }
}
