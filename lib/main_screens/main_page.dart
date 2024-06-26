import 'dart:convert';
import 'package:auto_aid/constants.dart';
import 'package:auto_aid/decoration/car_container.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'add_car.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);
  static String id = 'MainPage';

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  String userName = 'Loading...';
  List<Map<String, dynamic>> cars = [];

  @override
  void initState() {
    super.initState();
    _fetchUserName();
    fetchUserCars();
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

  Future<void> fetchUserCars() async {
    final token = await _storage.read(key: 'token');

    if (token == null) {
      print('No token found');
      return;
    }

    final url = Uri.parse('https://autoaid-store.preview-domain.com/api/user/cars');
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

  Future<void> addCar(String carMake, String carModel, int carMileages) async {
    final token = await _storage.read(key: 'token');

    if (token == null) {
      print('No token found');
      return;
    }

    final url = Uri.parse('https://autoaid-store.preview-domain.com/api/user/add-car');
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'car_make': carMake,
        'car_model': carModel,
        'car_mileages': carMileages,
      }),
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      if (responseBody['status']) {
        // إضافة السيارة الجديدة إلى القائمة
        final newCar = responseBody['car'];
        setState(() {
          cars.add(newCar);
        });
        print('Car added successfully');
      } else {
        print('Failed to add car: ${responseBody['message']}');
      }
    } else {
      print('Request failed with status: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10,top: 50),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: KeySecondaryColor,
                    maxRadius: 35,
                    child: Image.asset(
                      'assets/images/Profile Photo 1.png',
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    userName,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(width: 50,),
                  TextButton(
                    onPressed: () async {
                      final addedCar = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AddCarScreen(),
                        ),
                      );
                      if (addedCar != null) {
                        await addCar(addedCar['car_make'], addedCar['car_model'], addedCar['car_mileages']);
                      }
                    },
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.add),
                        SizedBox(width: 8), // توسيع الفراغ بين الأيقونة والنص
                        Text('Add New Car',
                        style: TextStyle(color: KeyPrimaryColor),),
                      ],
                    ),
                  ),

                ],
              ),
            ),
            CarContainer(
              StackHeight: 550,
              CustomContainerHeight: 250,
              TopPadding: 10,
              EditDeleteTopPadding: 400,
              cars: cars,
            ),
          ],
        ),
      ),
    );
  }
}
