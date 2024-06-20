import 'package:auto_aid/decoration/car_container.dart';
import 'package:flutter/material.dart';
class CarDetails extends StatelessWidget {
  const CarDetails({Key? key}) : super(key: key);
  static String id='CarPage';
  @override
  Widget build(BuildContext context) {
    return const CarContainer(
      StackHeight:500,
      CustomContainerHeight: 450,TopPadding:0,
      EditDeleteTopPadding: 440,
    );
  }
}
