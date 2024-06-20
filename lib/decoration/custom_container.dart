import 'package:flutter/material.dart';
import 'package:auto_aid/constants.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({super.key, required this.column,
    required this.height,
    this.width,
    this.borderRadius=40});

  final Widget? column;
  final double? height;
  final double? width;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: height,
      decoration: BoxDecoration(
        color: KeySecondaryColor,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // لون الظل
            spreadRadius: 2, // نطاق الظل
            blurRadius: 9, // قوة التمويه
            offset: const Offset(0,6), // مكان الظل بالنسبة للحاوية
          ),
        ],
      ),
      child: column,
    );
  }
}
