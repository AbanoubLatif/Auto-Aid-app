import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../constants.dart';
import '../decoration/custom_container.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_textfield.dart';

class SignIn extends StatefulWidget {
   SignIn({Key? key}) : super(key: key);

  static String id = 'SignInPage';

  @override
  // ignore: library_private_types_in_public_api
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool isLoading=false;
  final formKey = GlobalKey<FormState>();
  final storage = FlutterSecureStorage();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> loginUser(String email, String password) async {
    final url = Uri.parse('https://autoaid-store.preview-domain.com/api/auth/login');

    // بيانات الطلب
    final bodyData = {
      'email': email,
      'password': password,
    };

    print('Request URL: $url');
    print('Request Headers: Content-Type: application/x-www-form-urlencoded');
    print('Request Body: $bodyData');

    isLoading=true;
    setState(() {

    });
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: bodyData,
    );

    print('Response Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      if (responseBody['status']) {
        final token = responseBody['token'];
        await storage.write(key: 'token', value: token);
        print('Login successful, token: $token');
        Navigator.pushNamed(context, 'HomePage'); // Navigate to HomePage on success
      } else {
        print('Login failed: ${responseBody['message']}');
      }
    } else {
      print('Request failed with status: ${response.statusCode}');
      print('Response Body: ${response.body}');
    }
    isLoading=false;
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Stack(
            children: [
              Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Stack(
                      children: [
                        Positioned(
                          top: screenHeight * -0.18,
                          left: 100,
                          child: Container(
                            width: 640,
                            height: 250,
                            decoration: const BoxDecoration(
                              color: KeyPrimaryColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 90),
                          child: Center(
                            child: Image.asset(
                              KeyLogo,
                              height: 200,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30, right: 30, bottom: 240),
                      child: CustomContainer(
                         child: Column(
                          children: [
                            const SizedBox(height: 45),
                            CustomTextField(
                              text: 'Email',
                              controller: emailController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'This field is required';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 25),
                            CustomTextField(
                              text: 'Password',
                              obscureText: true,
                              controller: passwordController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'This field is required';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 25),
                            Padding(
                              padding: const EdgeInsets.only(left: 110, right: 110),
                              child: CustomButton(
                                height: 30,
                                text: 'Login',
                                // navigateTo: 'HomePage',
                                color: KeyPrimaryColor,
                                textcolor: Colors.white,
                                formKey: formKey,
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    loginUser(
                                      emailController.text,
                                      passwordController.text,
                                    );
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: screenHeight * -0.1,
                right: 100,
                child: Container(
                  width: 640,
                  height: 260,
                  decoration: const BoxDecoration(
                    color: KeySecondaryColor,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
