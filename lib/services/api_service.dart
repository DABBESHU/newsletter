import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/constants.dart';

class ApiService {
  Future<Map<String, dynamic>> fetchNews({
    String category = 'general',
    int page = 1,
    String? query,
  }) async {
    final Uri uri = Uri.parse(
      '${AppConstants.baseUrl}/top-headlines?'
      'country=${AppConstants.country}&'
      'category=$category&'
      'pageSize=${AppConstants.pageSize}&'
      'page=$page&'
      'apiKey=${AppConstants.apiKey}${query != null ? '&q=$query' : ''}',
    );

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load news');
    }
  }
}
