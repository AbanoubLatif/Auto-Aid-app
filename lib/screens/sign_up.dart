import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../constants.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_textfield.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);
  static String id = 'SignUp';

  @override
  SignUpState createState() => SignUpState();
}

class SignUpState extends State<SignUp> {
  bool isLoading = false;
  final formKey = GlobalKey<FormState>();
  final storage = const FlutterSecureStorage();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController carMakeController = TextEditingController();
  TextEditingController carModelController = TextEditingController();
  TextEditingController carMileagesController = TextEditingController();

  Map<String, List<String>> carModels = {
    'Kia': [
      'Cerato 2012-2017',
      'Grand Cerato 2018-2023',
      'Carens 2010-2013',
      'Sportage 2012-2022',
      'Rio 2010-2017',
      'Sportage Turbo GDI 2022-2024',
      'Picanto 2004-2017',
      'Soul 2009-2017'
    ],
    'Hyundai': [
      'Tucson GDI 2017-2023',
      'Accent RB 2011-2024',
      'verna',
      'Elantra MD',
      'Elantra AD',
      'Elantra HD',
      'Accent HCI'
    ],
    'Toyota': ['Corolla', 'Yaris'],
    'Nissan': ['Sunny', 'Patrol'],
    'Chevrolet': ['Lanos', 'Optra', 'New Optra', 'Captiva', 'Curze', 'New Curze'],
    'Mitsubishi': ['Eclipse', 'Lancer', 'Pajero'],
    'Peugeot': ['208', '301', '508'],
    'Renault': ['Logan', 'Megan'],
    'MG': ['MG5', 'MG6'],
  };
  List<String> selectedCarModels = [];

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    carMakeController.dispose();
    carModelController.dispose();
    carMileagesController.dispose();
    super.dispose();
  }

  Future<void> registerUser(String name, String email, String password, String carMake, String carModel, int carMileages) async {
    final url = Uri.parse('https://autoaid-store.preview-domain.com/api/auth/register');

    // بيانات الطلب
    final bodyData = {
      'name': name,
      'email': email,
      'password': password,
      'car_make': carMake,
      'car_model': carModel,
      'car_mileages': carMileages.toString(), // Convert double to string
    };

    print('Request URL: $url');
    print('Request Headers: Content-Type: application/x-www-form-urlencoded');
    print('Request Body: $bodyData');

    setState(() {
      isLoading = true;
    });

    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: bodyData,
    );

    setState(() {
      isLoading = false;
    });

    print('Response Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode >= 200) {
      final responseBody = jsonDecode(response.body);
      if (responseBody['status']) {
        final token = responseBody['token'];
        await storage.write(key: 'token', value: token);
        print('Registration successful, token: $token');
        Navigator.pushNamed(context, 'HomePage'); // Navigate to HomePage on success
      } else {
        print('Registration failed: ${responseBody['message']}');
        // Show error message dialog
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Registration Failed'),
            content: Text(responseBody['message']),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      }
    } else {
      print('Request failed with status: ${response.statusCode}');
      print('Response Body: ${response.body}');
      // Show error message dialog
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Request Failed'),
          content: Text('Failed to register. Status Code: ${response.statusCode}'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: KeySecondaryColor,
        body: ListView(
          children: [
            Image.asset(KeyLogo, height: 210),
            Form(
              key: formKey,
              child: Column(
                children: [
                  CustomTextField(
                    text: 'User Name',
                    controller: nameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This field is required';
                      }
                      return null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: CustomTextField(
                      text: 'Email',
                      controller: emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This field is required';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: CustomTextField(
                      obscureText: true,
                      text: 'Password',
                      controller: passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This field is required';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters long';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: CarMakeTextField(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: CarModelTextField(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: CustomTextField(
                      text: 'Car mileages',
                      controller: carMileagesController,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This field is required';
                        }
                        if (!RegExp(r'^\d+$').hasMatch(value)) {
                          return 'Car mileages must be a number';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 130, right: 130, bottom: 150, top: 15),
                    child: CustomButton(
                      height: 30,
                      text: 'Sign Up',
                      color: KeyPrimaryColor,
                      textcolor: Colors.white,
                      formKey: formKey,
                      navigateTo: 'HomePage',
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          registerUser(
                            nameController.text,
                            emailController.text,
                            passwordController.text,
                            carMakeController.text,
                            carModelController.text,
                            int.parse(carMileagesController.text),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget CarMakeTextField() {
    return CustomTextField(
      text: 'Car Make',
      controller: carMakeController,
      suffixIcon: PopupMenuButton<String>(
        icon: const Icon(Icons.arrow_downward_outlined, color: Colors.blue),
        itemBuilder: (BuildContext context) {
          return carModels.keys.map((String carMake) {
            return PopupMenuItem<String>(
              value: carMake,
              child: Text(carMake),
            );
          }).toList();
        },
        onSelected: (String value) {
          setState(() {
            carMakeController.text = value;
            selectedCarModels = carModels[value]!;
            carModelController.clear();
          });
        },
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'This field is required';
        }
        return null;
      },
    );
  }

  Widget CarModelTextField() {
    return CustomTextField(
      text: 'Car Model',
      controller: carModelController,
      suffixIcon: PopupMenuButton<String>(
        icon: const Icon(Icons.arrow_downward_outlined, color: Colors.blue),
        itemBuilder: (BuildContext context) {
          return selectedCarModels.map((String carModel) {
            return PopupMenuItem<String>(
              value: carModel,
              child: Text(carModel),
            );
          }).toList();
        },
        onSelected: (String value) {
          setState(() {
            carModelController.text = value;
          });
        },
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'This field is required';
        }
        return null;
      },
    );
  }
}
