import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataRepository {
  final Dio _dio = Dio();
  final String type;
  DataRepository(this.type);

  Future<Map<String, dynamic>> fetchData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs
          .getString('access_token'); // Retrieve token from shared preferences

      _dio.options.headers['Authorization'] = 'Bearer $token';
      // _dio.options.headers['Authorization'] = 'Bearer $token';
      final response = await _dio.get(
          'https://backend.almowafraty.com/api/v1/markets/suppliers?type=$type');
      return response.data;
    } catch (e) {
      throw Exception('Failed to load data');
    }
  }
}
