class User {
  final String name;
  final String email;
  final String password;
  final String carMake;
  final String carModel;
  final int carMileages;

  User({
    required this.name,
    required this.email,
    required this.password,
    required this.carMake,
    required this.carModel,
    required this.carMileages,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'car_make': carMake,
      'car_model': carModel,
      'car_mileages': carMileages,
    };
  }
}
