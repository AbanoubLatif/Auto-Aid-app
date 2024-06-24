import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String text;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final Function(String)? onChange;
  final String? Function(String?)? validator;
  final bool obscureText; // إضافة خاصية للسماح بإظهار وإخفاء كلمة المرور

  const CustomTextField({
    Key? key,
    required this.text,
    this.suffixIcon,
    this.controller,
    this.onChange,
    this.validator,
    this.obscureText = false, // القيمة الافتراضية لـ obscureText هي false
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true; // حالة محلية للتحكم في إظهار وإخفاء كلمة المرور

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 0.1,
              blurRadius: 15,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: TextFormField(
          onChanged: widget.onChange,
          controller: widget.controller,
          obscureText: widget.obscureText ? _obscureText : false, // تحديد الـ obscureText
          cursorColor: Colors.black,
          style: const TextStyle(
            color: Colors.black, // لون النص داخل حقل النص
          ),
          validator: widget.validator,
          decoration: InputDecoration(
            filled: true, // تحديد ملء الخلفية
            fillColor: Colors.white, // لون الخلفية
            contentPadding: const EdgeInsets.symmetric(horizontal: 10), // تعديل حجم البادنج
            hintText: widget.text,
            hintStyle: const TextStyle(fontSize: 14, color: Color(0xffCECECE)), // لون النص للنص التلميحي
            prefixText: '  ',
            suffixIcon: widget.suffixIcon,
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
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: Colors.red), // لون الحافة عندما يكون هناك خطأ
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(color: Colors.red), // لون الحافة عندما يكون الحقل محددًا وهناك خطأ
            ),
          ),
        ),
      ),
    );
  }
}
