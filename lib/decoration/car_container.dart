import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../constants.dart';
import 'custom_container.dart';

class CarContainer extends StatefulWidget {
  const CarContainer({
    super.key,
    required this.StackHeight,
    required this.CustomContainerHeight,
    required this.TopPadding,
    required this.EditDeleteTopPadding,
  });

  final double StackHeight, CustomContainerHeight, TopPadding, EditDeleteTopPadding;

  @override
  _CarContainerState createState() => _CarContainerState();
}

class _CarContainerState extends State<CarContainer> {
  final storage = const FlutterSecureStorage();
  List<Map<String, dynamic>> cars = [];

  @override
  void initState() {
    super.initState();
    fetchUserCars();
  }

  Future<void> fetchUserCars() async {
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
          cars = List<Map<String, dynamic>>.from(responseBody['cars']);
        });
      } else {
        print('Failed to retrieve cars: ${responseBody['message']}');
      }
    } else {
      print('Request failed with status: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  }

  Future<void> updateCarMileage(int carId, int carMileages) async {
    final token = await storage.read(key: 'token');
    if (token == null) {
      print('No token found');
      return;
    }

    final url = Uri.parse('https://autoaid-store.preview-domain.com/api/user/updatecar');
    final response = await http.put(
      url,
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization': 'Bearer $token',
      },
      body: {
        'car_id': carId.toString(),
        'car_mileages': carMileages.toString(),
      },
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      if (responseBody['status']) {
        setState(() {
          cars = cars.map((car) {
            if (car['id'] == carId) {
              car['car_mileages'] = carMileages;
            }
            return car;
          }).toList();
          print('Car Mileage Updated Successfully');
        });
      } else {
        print('Failed to update car mileage: ${responseBody['message']}');
      }
    } else {
      print('Request failed with status: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  }

  void showUpdateMileageDialog(int carId, int currentMileage) {
    final TextEditingController mileageController = TextEditingController(text: currentMileage.toString());

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Update Car Mileage'),
          content: TextField(
            controller: mileageController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Enter new mileage'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final newMileage = int.parse(mileageController.text);
                updateCarMileage(carId, newMileage);
                Navigator.of(context).pop();
              },
              child: const Text('Update'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.StackHeight,
      child: Stack(
        children: [
          if (cars.isNotEmpty)
            for (var car in cars)
              Positioned(
                left: 15,
                right: 20,
                top: 30,
                child: Padding(
                  padding: EdgeInsets.only(top: widget.TopPadding),
                  child: CustomContainer(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 10, bottom: 10),
                          child: Text(
                            'Your car Details:              ',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 27,
                            ),
                          ),
                        ),
                        const Text(
                          'Car ID:',
                          style: TextStyle(
                            color: KeyPrimaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 27,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 27),
                          child: Text(
                            car['id'].toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                          ),
                        ),
                        const Text(
                          'Name:',
                          style: TextStyle(
                            color: KeyPrimaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 27,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 17),
                          child: Text(
                            car['car_make'].toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                          ),
                        ),
                        const Text(
                          'Model:',
                          style: TextStyle(
                            color: KeyPrimaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 27,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 27),
                          child: Text(
                            car['car_model'].toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                          ),
                        ),
                        const Text(
                          'Mileages:',
                          style: TextStyle(
                            color: KeyPrimaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 27,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 27),
                          child: Text(
                            car['car_mileages'].toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          if (cars.isNotEmpty)
            for (var car in cars)
              Positioned(
                top: widget.EditDeleteTopPadding,
                right: 60,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        showUpdateMileageDialog(car['id'], car['car_mileages']);
                      },
                      child: const Text(
                        'Edit',
                        style: TextStyle(
                          color: KeyPrimaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                          decorationColor: KeyPrimaryColor,
                          decorationThickness: 2,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          Positioned(
            top: 100,
            right: 5,
            child: Image.asset(
              'assets/images/toyota icon 1.png',
              height: 110,
              width: 177,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
