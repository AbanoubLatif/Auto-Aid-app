import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/car_model.dart';


class CarService {
  final String baseUrl = 'http://127.0.0.1:8000/api/user';

  Future<void> addCar(Car car, String token) async {
    final response = await http.post(
      Uri.parse('$baseUrl/add-car'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode(car.toJson()),
    );

    if (response.statusCode == 200) {
      // Handle success
    } else {
      // Handle error
    }
  }

  Future<void> updateCar(int carId, int carMileages, String token) async {
    final response = await http.put(
      Uri.parse('$baseUrl/updatecar'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode({
        'car_id': carId,
        'car_mileages': carMileages,
      }),
    );

    if (response.statusCode == 200) {
      // Handle success
    } else {
      // Handle error
    }
  }

  Future<void> deleteCar(Car car, String token) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/car-user'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode(car.toJson()),
    );

    if (response.statusCode == 200) {
      // Handle success
    } else {
      // Handle error
    }
  }

  Future<void> displayCars(String token) async {
    final response = await http.get(
      Uri.parse('https://autoaid-store.preview-domain.com/api/cars'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      // Handle success
    } else {
      // Handle error
    }
  }
}
