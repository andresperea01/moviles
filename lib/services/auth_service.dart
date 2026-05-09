import 'package:dio/dio.dart';

class AuthService {
  final Dio _dio = Dio();
  final String _baseUrl = 'https://parking.visiontic.com.co/api';

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await _dio.post(
        '$_baseUrl/login',
        data: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      } else {
        throw Exception('Error en autenticación');
      }
    } on DioException catch (e) {
      if (e.response != null && e.response?.data != null) {
        final data = e.response!.data;
        if (data is Map && data.containsKey('message')) {
          throw Exception(data['message']);
        }
      }
      throw Exception('Fallo la conexión con el servidor.');
    } catch (e) {
      throw Exception('Ocurrió un error inesperado.');
    }
  }
}
