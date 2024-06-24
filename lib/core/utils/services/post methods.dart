import 'dart:convert';
import 'package:http/http.dart'as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// إنشاء كائن FlutterSecureStorage
final storage = FlutterSecureStorage();

Future<void> saveToken(String token) async {
  await storage.write(key: 'token', value: token);
}

Future<String?> getToken() async {
  return await storage.read(key: 'token');
}

Future<void> deleteToken() async {
  await storage.delete(key: 'token');
}

Future<void> registerUser(String name, String email, String password, String carMake, String carModel, double carMileages) async {
  final url = Uri.parse('https://autoaid-store.preview-domain.com/api/auth/register');
  final response = await http.post(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      'name': name,
      'email': email,
      'password': password,
      'car_make': carMake,
      'car_model': carModel,
      'car_mileages': carMileages,
    }),
  );

  if (response.statusCode == 200) {
    final responseBody = jsonDecode(response.body);
    if (responseBody['status']) {
      final token = responseBody['token'];
      await saveToken(token);
      print('Registration successful, token: $token');
    } else {
      print('Registration failed: ${responseBody['message']}');
    }
  } else {
    print('Request failed with status: ${response.statusCode}');
  }
}

Future<void> loginUser(String email, String password) async {
  final url = Uri.parse('https://autoaid-store.preview-domain.com/api/auth/login');
  final response = await http.post(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'email': email,
      'password': password,
    }),
  );

  if (response.statusCode == 200) {
    final responseBody = jsonDecode(response.body);
    if (responseBody['status']) {
      final token = responseBody['token'];
      await saveToken(token);
      print('Login successful, token: $token');
    } else {
      print('Login failed: ${responseBody['message']}');
    }
  } else {
    print('Request failed with status: ${response.statusCode}');
  }
}

Future<void> addCar(String carMake, String carModel, double carMileages) async {
  final token = await getToken();
  if (token == null) {
    print('No token found');
    return;
  }

  final url = Uri.parse('https://autoaid-store.preview-domain.com/api/user/add-car');
  final response = await http.post(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    },
    body: jsonEncode(<String, dynamic>{
      'car_make': carMake,
      'car_model': carModel,
      'car_mileages': carMileages,
    }),
  );

  if (response.statusCode == 200) {
    final responseBody = jsonDecode(response.body);
    if (responseBody['status']) {
      print('Car added successfully');
    } else {
      print('Failed to add car: ${responseBody['message']}');
    }
  } else {
    print('Request failed with status: ${response.statusCode}');
  }
}

Future<void> logoutUser() async {
  final token = await getToken();
  if (token == null) {
    print('No token found');
    return;
  }

  final url = Uri.parse('https://autoaid-store.preview-domain.com/api/auth/logout');
  final response = await http.post(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    final responseBody = jsonDecode(response.body);
    if (responseBody['status']) {
      print('Logout successful');
      await deleteToken();
    } else {
      print('Logout failed: ${responseBody['message']}');
    }
  } else {
    print('Request failed with status: ${response.statusCode}');
  }
}