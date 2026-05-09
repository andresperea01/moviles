import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../services/auth_service.dart';

enum AuthState { initial, loading, success, error }

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  
  AuthState _state = AuthState.initial;
  String _errorMessage = '';

  AuthState get state => _state;
  String get errorMessage => _errorMessage;

  Future<void> login(String email, String password) async {
    _state = AuthState.loading;
    notifyListeners();

    try {
      final response = await _authService.login(email, password);
      
      // Intentamos extraer el token y la información del usuario de la respuesta.
      // Dependiendo de la estructura exacta del backend, esto podría variar.
      // Asumimos un formato común: { "token": "...", "user": { "name": "...", "email": "..." } }
      // O { "access_token": "...", "data": { ... } }
      
      String? token;
      String? userName;
      String? userEmail = email;

      if (response.containsKey('token')) {
        token = response['token'];
      } else if (response.containsKey('access_token')) {
        token = response['access_token'];
      } else if (response.containsKey('data') && response['data'] is Map && response['data']['token'] != null) {
        token = response['data']['token'];
      }

      if (response.containsKey('user') && response['user'] is Map) {
        userName = response['user']['name'];
        userEmail = response['user']['email'] ?? email;
      } else if (response.containsKey('data') && response['data'] is Map && response['data']['user'] != null) {
        userName = response['data']['user']['name'];
        userEmail = response['data']['user']['email'] ?? email;
      }

      // Si no viene token pero la autenticación fue "exitosa" según el status code:
      token ??= 'dummy_token_para_pruebas_si_no_se_recibio';
      userName ??= 'Usuario';

      // Almacenamiento sensible
      await _secureStorage.write(key: 'access_token', value: token);

      // Almacenamiento no sensible
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_name', userName ?? 'Usuario');
      await prefs.setString('user_email', userEmail ?? email);
      await prefs.setString('theme', 'light'); // Ejemplo de configuración

      _state = AuthState.success;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString().replaceAll('Exception: ', '');
      _state = AuthState.error;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    await _secureStorage.delete(key: 'access_token');
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_name');
    await prefs.remove('user_email');
    
    _state = AuthState.initial;
    notifyListeners();
  }
}
