import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key,
    required this.text,
    required this.color,
    required this.textcolor,
    required this.height,
    this.navigateTo, // قم بتحديد المتغير كاختياري
    this.numberofPop = 0,
    this.logout = false,
  });

  final String text;
  final Color color;
  final Color textcolor;
  final double height;
  final int numberofPop;
  final bool logout;
  final String? navigateTo;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (logout) {
          Navigator.pushNamedAndRemoveUntil(
              context, 'FirstScreen', (route) => false);
        } else {
          for (int i = 0; i < numberofPop; i++) {
            Navigator.pop(context);
          }
          if (navigateTo != null) {
            Navigator.pushNamed(context, navigateTo!); // استخدم navigateTo!
          }
        }
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 8,
                offset: const Offset(0,2)
            )
          ],
          color: color,
        ),
        height: height,
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: textcolor,
              fontSize: 17,
            ),
          ),
        ),
      ),
    );
  }
}
