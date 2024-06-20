import 'package:flutter/material.dart';

import '../constants.dart';
import '../decoration/custom_container.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_icon_back.dart';
import '../widgets/custom_textfield.dart';

class UserInfo extends StatelessWidget {
   UserInfo({Key? key}) : super(key: key);
  static String id='UserInfoPage';

  // قائمة النصوص التي ترغب في إظهارها في CustomTextField
  final List<String> textFieldLabels = [
    'User name',
    'Old password',
    'New password',
    'Confirm password',
    'Change email',
    'Your avg daily mileage',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomIconBack(),
            const Padding(
              padding: EdgeInsets.only(top: 10, left: 40),
              child: Text(
                'User name',
                style: TextStyle(
                  color: KeySecondaryColor,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, right: 20, left: 20),
              child: CustomContainer(
                height: 470,
                column: Column(
                  children: [
                    // استخدم ListView.builder لإنشاء CustomTextField بناءً على القائمة textFieldLabels
                    Expanded(
                      child: ListView.builder(
                        itemCount: textFieldLabels.length,
                        itemBuilder: (context, index) {
                          // استخدم عنصر القائمة في كل CustomTextField
                          return Padding(
                            padding:  EdgeInsets.only(
                              right: 40,
                              bottom: index == textFieldLabels.length - 1 ? 0 : 15, // لتجنب إضافة padding إضافي في العناصر غير الأخيرة
                            ),
                            child: CustomTextField(text: textFieldLabels[index]),
                          );
                        },
                      ),
                    ),

                    const Padding(
                      padding: EdgeInsets.only(
                        bottom: 15,
                        right: 110,
                        left: 110,
                      ),
                      child: CustomButton(
                        text: 'Confirm',
                        color: KeyPrimaryColor,
                        textcolor: Colors.white,
                        height: 35,
                        numberofPop: 1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
