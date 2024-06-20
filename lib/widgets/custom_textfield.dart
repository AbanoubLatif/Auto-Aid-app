import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextField extends StatelessWidget {
  CustomTextField({super.key, required this.text, this.suffixIcon,this.controller});

  String text;
  Widget? suffixIcon;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 40, right: 40),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 0.1,
                blurRadius: 15,
                offset: const Offset(0,10)
            )
          ]
        ),
        child: TextFormField(
          controller: controller,
          cursorColor: Colors.black,
          style: const TextStyle(
            color: Colors.black, // لون النص داخل حقل النص

          ),
          decoration: InputDecoration(
            filled: true, // تحديد ملء الخلفية
            fillColor: Colors.white, // لون الخلفية
            contentPadding: const EdgeInsets.symmetric(horizontal: 10), // تعديل حجم البادنج
            hintText: text,
            hintStyle: const TextStyle(fontSize: 14, color: Color(0xffCECECE)), // لون النص للنص التلميحي
            prefixText: '  ',
            suffixIcon: suffixIcon,
            border: OutlineInputBorder(
             borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: Colors.white), // لون الحافة الخارجية
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: Colors.white), // لون الحافة عندما يكون الحقل غير محدد
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: Colors.white), // لون الحافة عندما يكون الحقل محددًا
            ),
          ),
        ),
      ),
    );
  }
}
