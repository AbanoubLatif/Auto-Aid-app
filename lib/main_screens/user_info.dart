import 'package:flutter/material.dart';

import '../constants.dart';
import '../decoration/custom_container.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_icon_back.dart';
import '../widgets/custom_textfield.dart';

class UserInfo extends StatelessWidget {
   const UserInfo({Key? key}) : super(key: key);
  static String id='UserInfoPage';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomIconBack(),
            Padding(
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
              padding: EdgeInsets.only(top: 10, right: 20, left: 20),
              child: CustomContainer(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: CustomTextField(text: 'New User Name'),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: CustomTextField(text: 'New Email'),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: CustomTextField(text: 'New Password'),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: 20,
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
