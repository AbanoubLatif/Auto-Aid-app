import 'package:flutter/material.dart';
import 'package:auto_aid/constants.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    super.key,
    required this.child,
    this.width,
    this.borderRadius = 40,
  });

  final Widget? child;
  final double? width;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      decoration: BoxDecoration(
        color: KeySecondaryColor,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // لون الظل
            spreadRadius: 2, // نطاق الظل
            blurRadius: 9, // قوة التمويه
            offset: const Offset(0, 6), // مكان الظل بالنسبة للحاوية
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0), // يمكنك ضبط الحواف حسب الحاجة
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (child != null) child!,
          ],
        ),
      ),
    );
  }
}
