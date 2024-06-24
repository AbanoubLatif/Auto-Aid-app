import 'package:http/http.dart' as http;
import '../models/user_model.dart';

class AuthService {
  final String baseUrl = 'https://autoaid-store.preview-domain.com/api/auth';

  Future<void> register(User user) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: user.toJson(),
    );

    if (response.statusCode >= 200) {
      // Handle success
    } else {
      // Handle error
    }
  }

  Future<void> login(String email, String password) async {
    var request = http.MultipartRequest('POST', Uri.parse('$baseUrl/login'));
    request.fields['email'] = email;
    request.fields['password'] = password;
    var response = await request.send();

    if (response.statusCode >= 200) {
      // Handle success
      print('Login successful');
    } else {
      // Handle error
      print('Login failed: ${response.statusCode}');
      throw Exception('Failed to login');
    }
  }

  Future<void> logout(String token) async {
    final response = await http.post(
      Uri.parse('$baseUrl/logout'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode >= 200) {
      // Handle success
    } else {
      // Handle error
    }
  }
}
