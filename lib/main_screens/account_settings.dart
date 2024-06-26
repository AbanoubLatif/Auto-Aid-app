import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import '../constants.dart';
import '../widgets/custom_button.dart';
import '../decoration/custom_container.dart';

class AccountSettings extends StatefulWidget {
  const AccountSettings({Key? key}) : super(key: key);
  static String id = 'AccountSettingsPage';

  @override
  _AccountSettingsState createState() => _AccountSettingsState();
}

class _AccountSettingsState extends State<AccountSettings> {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  String userName = 'Loading...';

  @override
  void initState() {
    super.initState();
    _fetchUserName();
  }

  Future<void> _fetchUserName() async {
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
          userName = responseBody['data']['name'];
        });
      } else {
        print('Failed to retrieve user data: ${responseBody['message']}');
      }
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
  }

  Future<void> logoutUser(BuildContext context) async {
    // Delete token from secure storage
    await _storage.delete(key: 'token');
    print('Logged out successfully');
    // Navigate to the first screen or login screen
    Navigator.pushNamedAndRemoveUntil(context, 'FirstScreen', (route) => false);
  }

  void deleteCar(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        TextEditingController carIdController = TextEditingController();

        return AlertDialog(
          title: const Text('Delete Car'),
          content: TextField(
            controller: carIdController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Enter Car ID to delete',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                int carId = int.tryParse(carIdController.text) ?? 0;
                if (carId != 0) {
                  final token = await _storage.read(key: 'token');
                  if (token != null) {
                    final url = Uri.parse('https://autoaid-store.preview-domain.com/api/user/car-user');
                    final response = await http.post(
                      url,
                      headers: {
                        'Authorization': 'Bearer $token',
                        'Content-Type': 'application/json',
                      },
                      body: jsonEncode({
                        'car_id': carId,
                      }),
                    );

                    if (response.statusCode == 200) {
                      final responseBody = jsonDecode(response.body);
                      if (responseBody['status']) {
                        print('Car deleted successfully');
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Car deleted successfully'),
                            duration: Duration(seconds: 3),
                          ),
                        );
                        // Assuming you have a way to update the car list on the screen
                        // after deletion. If not, you need to implement it here.
                      } else {
                        print('Failed to delete car: ${responseBody['message']}');
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Failed to delete car: ${responseBody['message']}'),
                            duration: const Duration(seconds: 3),
                          ),
                        );
                      }
                    } else {
                      print('Request failed with status: ${response.statusCode}');
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Request failed with status: ${response.statusCode}'),
                          duration: const Duration(seconds: 3),
                        ),
                      );
                    }
                  } else {
                    print('No token found');
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('No token found'),
                        duration: Duration(seconds: 3),
                      ),
                    );
                  }
                } else {
                  print('Invalid Car ID');
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Invalid Car ID'),
                      duration: Duration(seconds: 3),
                    ),
                  );
                }
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 60, left: 40),
            child: Text(
              'Hello!',
              style: TextStyle(
                color: KeyPrimaryColor,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 40),
            child: Text(
              userName,
              style: const TextStyle(
                color: KeySecondaryColor,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, right: 20, left: 20),
            child: CustomContainer(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 30, right: 70, left: 30),
                    child: CustomButton(
                      height: 40,
                      text: 'Edit user info',
                      color: KeyPrimaryColor,
                      textcolor: Colors.white,
                      navigateTo: 'UserInfoPage',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, right: 80, left: 30),
                    child: CustomButton(
                      height: 40,
                      text: 'Delete a car',
                      color: KeyPrimaryColor,
                      textcolor: Colors.white,
                      onPressed: () {
                        deleteCar(context);
                      },
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 20, right: 110, left: 30),
                    child: CustomButton(
                      height: 40,
                      text: 'Contact with us',
                      color: KeyPrimaryColor,
                      textcolor: Colors.white,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 20, right: 120, left: 30),
                    child: CustomButton(
                      height: 40,
                      text: 'Rate us',
                      color: KeyPrimaryColor,
                      textcolor: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, right: 140, left: 30),
                    child: CustomButton(
                      height: 40,
                      text: 'Log out',
                      color: KeyPrimaryColor,
                      textcolor: Colors.white,
                      logout: true,
                      onPressed: () {
                        logoutUser(context);
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 20,),
          const Center(child: Text('All copyrights saved to Auto Aid app team')),
        ],
      ),
    );
  }
}
