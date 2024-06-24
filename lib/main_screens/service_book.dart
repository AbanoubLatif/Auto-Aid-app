import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:auto_aid/constants.dart';
import 'package:auto_aid/decoration/custom_container.dart';
import 'package:auto_aid/widgets/custom_button.dart';
import 'package:auto_aid/widgets/custom_textfield.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ServiceBook extends StatefulWidget {
  const ServiceBook({Key? key}) : super(key: key);
  static String id = 'ServiceBookPage';

  @override
  State<ServiceBook> createState() => ServiceBookState();
}

class ServiceBookState extends State<ServiceBook> {
  bool isLoading = false;
  final formKey = GlobalKey<FormState>();
  TextEditingController carMakeController = TextEditingController();
  TextEditingController carModelController = TextEditingController();

  List<Map<String, String>> userCars = [];
  List<String> selectedCarModels = [];

  @override
  void initState() {
    super.initState();
    fetchUserCars();
  }

  @override
  void dispose() {
    carMakeController.dispose();
    carModelController.dispose();
    super.dispose();
  }

  Future<void> fetchUserCars() async {
    final storage = FlutterSecureStorage();
    final token = await storage.read(key: 'token');

    if (token == null) {
      print('No token found');
      return;
    }

    final url = Uri.parse('https://autoaid-store.preview-domain.com/api/cars');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      if (responseBody['status']) {
        setState(() {
          userCars = List<Map<String, String>>.from(responseBody['cars'].map((car) {
            return {
              'car_make': car['car_make'].toString(),
              'car_model': car['car_model'].toString(),
            };
          }));
        });
      } else {
        print('Failed to retrieve user cars: ${responseBody['message']}');
      }
    } else {
      print('Request failed with status: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  }

  Future<void> handleConfirm() async {
    if (formKey.currentState?.validate() ?? false) {
      try {
        await sendCarMakeModel(carMakeController.text, carModelController.text);
        Navigator.pushNamed(context, 'ServicePage');
      } catch (e) {
        print('Failed to send car make and model: $e');
        _showErrorDialog('Failed to send car make and model. Please try again later.');
      }
    }
  }

  Future<void> sendCarMakeModel(String carMake, String carModel) async {
    final storage = FlutterSecureStorage();
    final token = await storage.read(key: 'token');
    final url =
    Uri.parse('https://autoaid-store.preview-domain.com/api/maintenance?car_make=$carMake&car_model=$carModel');

    print('Sending request to $url with token: $token');

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    print('Response status code: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode != 200) {
      throw Exception('Failed to send car make and model with status: ${response.statusCode}');
    }

    final responseBody = jsonDecode(response.body);
    if (!responseBody['status']) {
      throw Exception('Failed to retrieve maintenance data: ${responseBody['message']}');
    }

    // Store the retrieved data in secure storage for use in ServicePage
    await storage.write(key: 'maintenance_data', value: jsonEncode(responseBody['data']));
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 180, left: 30, right: 30),
              child: CustomContainer(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Text(
                          'Choose car to show its service book',
                          style: TextStyle(
                            fontSize: 30,
                            color: KeyPrimaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: CarMakeTextField(),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: CarModelTextField(),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30, left: 100, right: 100),
                        child: CustomButton(
                          height: 30,
                          text: 'Confirm',
                          color: KeyPrimaryColor,
                          textcolor: Colors.white,
                          onPressed: handleConfirm,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).viewInsets.bottom), // Adjust the padding when the keyboard appears
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
          if (userCars.isEmpty) {
            return [
              const PopupMenuItem<String>(
                value: '',
                child: Text('No cars available'),
              ),
            ];
          }
          return userCars.map((car) {
            return PopupMenuItem<String>(
              value: car['car_make']!,
              child: Text(car['car_make']!),
            );
          }).toList();
        },
        onSelected: (String value) {
          setState(() {
            carMakeController.text = value;
            selectedCarModels = userCars
                .where((car) => car['car_make'] == value)
                .map((car) => car['car_model']!)
                .toList();
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
          if (selectedCarModels.isEmpty) {
            return [
              const PopupMenuItem<String>(
                value: '',
                child: Text('No models available'),
              ),
            ];
          }
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
