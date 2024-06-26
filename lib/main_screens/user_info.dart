import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../constants.dart';
import '../decoration/custom_container.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_icon_back.dart';
import '../widgets/custom_textfield.dart';

class UserInfo extends StatefulWidget {
  const UserInfo({Key? key}) : super(key: key);
  static String id = 'UserInfoPage';

  @override
  // ignore: library_private_types_in_public_api
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    final token = await _storage.read(key: 'token');

    if (token == null) {
      print('No token found');
      return;
    }

    final url = Uri.parse('https://autoaid-store.preview-domain.com/api/user/data');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      if (responseBody['status']) {
        setState(() {
          _nameController.text = responseBody['data']['name'];
          _emailController.text = responseBody['data']['email'];
          _passwordController.text = ''; // password is null in the response
        });
      } else {
        _showErrorDialog('Failed to retrieve user data: ${responseBody['message']}');
      }
    } else {
      _showErrorDialog('Request failed with status: ${response.statusCode}');
    }
  }

  Future<void> _updateUserData() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final token = await _storage.read(key: 'token');
    final url = Uri.parse('https://autoaid-store.preview-domain.com/api/user/updateuser');

    final Map<String, dynamic> updateData = {
      'name': _nameController.text,
      'email': _emailController.text,
    };

    if (_passwordController.text.isNotEmpty) {
      updateData['password'] = _passwordController.text;
    }

    final response = await http.put(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(updateData),
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      if (responseBody['status']) {
        _showSuccessDialog('User data updated successfully');
      } else {
        _showErrorDialog('Failed to update user data: ${responseBody['message']}');
      }
    } else {
      _showErrorDialog('Request failed with status: ${response.statusCode}');
    }
  }

  void _showSuccessDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Success'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomIconBack(),
            Padding(
              padding: const EdgeInsets.only(top: 60, right: 20, left: 20),
              child: CustomContainer(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: CustomTextField(
                          text: 'User Name',
                          controller: _nameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: CustomTextField(
                          text: 'Email',
                          controller: _emailController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: CustomTextField(
                          text: 'New Password',
                          controller: _passwordController,
                          obscureText: true,
                          validator: (value) {
                            return null; // Password is not required
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 20,
                          bottom: 15,
                          right: 110,
                          left: 110,
                        ),
                        child: CustomButton(
                          text: 'Confirm',
                          color: KeyPrimaryColor,
                          textcolor: Colors.white,
                          height: 35,
                          onPressed: _updateUserData,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
