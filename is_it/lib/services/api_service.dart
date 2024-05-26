import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:is_it/models/idea.dart';

class ApiService {
  final String _baseUrl = 'http://localhost:8080/api';

  Future<List<Idea>> findSimilarIdeas(String title, String details) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/find-similar-ideas'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'serviceName': title,
        'serviceDetail': details,
      }),
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((item) => Idea.fromJson(item)).toList();
    } else {
      throw Exception('Failed to get similarity data');
    }
  }
}
