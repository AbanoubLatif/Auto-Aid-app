import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../constants.dart';
import '../widgets/custom_button.dart';
import '../decoration/custom_container.dart';

class AccountSettings extends StatelessWidget {
   const AccountSettings({Key? key}) : super(key: key);
  static String id = 'AccountSettingsPage';

  final storage = const FlutterSecureStorage();

  Future<void> logoutUser(BuildContext context) async {
    // Delete token from secure storage
    await storage.delete(key: 'token');
    print('Logged out successfully');
    // Navigate to the first screen or login screen
    Navigator.pushNamedAndRemoveUntil(context, 'FirstScreen', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 60, left: 40),
            child: Text(
              'Hello!',
              style: TextStyle(
                color: KeyPrimaryColor,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 40),
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

              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 30, right: 70, left: 30),
                    child: CustomButton(
                      height: 40,
                      text: 'Edit user info',
                      color: KeyPrimaryColor,
                      textcolor: Colors.white,
                      navigateTo: 'UserInfoPage',
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 20, right: 80, left: 30),
                    child: CustomButton(
                      height: 40,
                      text: 'Delete your account',
                      color: KeyPrimaryColor,
                      textcolor: Colors.white,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 20, right: 110, left: 30),
                    child: CustomButton(
                      height: 40,
                      text: 'Contact with us',
                      color: KeyPrimaryColor,
                      textcolor: Colors.white,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 20, right: 120, left: 30),
                    child: CustomButton(
                      height: 40,
                      text: 'Rate us',
                      color: KeyPrimaryColor,
                      textcolor: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, right: 140, left: 30),
                    child: CustomButton(
                      height: 40,
                      text: 'Log out',
                      color: KeyPrimaryColor,
                      textcolor: Colors.white,
                      logout: true,
                      onPressed: () {
                        logoutUser(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 5,),
          const Center(child: Text('All copyrights saved to Auto Aid app team')),
        ],
      ),
    );
  }
}
