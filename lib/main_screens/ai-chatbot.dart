import 'dart:convert';
import 'package:auto_aid/constants.dart';
import 'package:auto_aid/decoration/custom_container.dart';
import 'package:auto_aid/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AiChatBot extends StatefulWidget {
  const AiChatBot({Key? key}) : super(key: key);
  static String id = 'AiChatBotPage';

  @override
  State<AiChatBot> createState() => AiChatBotState();
}

class AiChatBotState extends State<AiChatBot> {
  TextEditingController YourCarController = TextEditingController();
  List<String> userCarMakes = [];

  @override
  void initState() {
    super.initState();
    fetchUserCars();
  }

  @override
  void dispose() {
    YourCarController.dispose();
    super.dispose();
  }

  Future<void> fetchUserCars() async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: 'token');

    if (token == null) {
      print('No token found');
      return;
    }

    final url = Uri.parse('https://autoaid-store.preview-domain.com/api/user/cars');
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
          userCarMakes = List<String>.from(responseBody['cars'].map((car) => car['car_make'].toString()));
        });
      } else {
        print('Failed to retrieve user cars: ${responseBody['message']}');
      }
    } else {
      print('Request failed with status: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 70, left: 30, right: 30),
                child: CustomContainer(
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Text(
                          'Try to solve your car problem',
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
                        child: userCarMakes.isEmpty
                            ? const Text(
                          'No cars available',
                          style: TextStyle(fontSize: 20, color: Colors.red),
                        )
                            : Column(
                          children: userCarMakes
                              .map((carMake) => Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                              carMake,
                              style: const TextStyle(
                                fontSize: 27,
                                color: Colors.white,
                              ),
                            ),
                          ))
                              .toList(),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 30, left: 100, right: 100),
                        child: CustomButton(
                          height: 40,
                          text: 'Confirm',
                          color: KeyPrimaryColor,
                          textcolor: Colors.white,
                          navigateTo: 'ChatPage',
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).viewInsets.bottom), // Adjust the padding when the keyboard appears
            ],
          ),
        ],
      ),
    );
  }
}
