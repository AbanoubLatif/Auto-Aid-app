class Car {
  final String carMake;
  final String carModel;
  final int carMileages;

  Car({
    required this.carMake,
    required this.carModel,
    required this.carMileages,
  });

  Map<String, dynamic> toJson() {
    return {
      'car_make': carMake,
      'car_model': carModel,
      'car_mileages': carMileages,
    };
  }
}
