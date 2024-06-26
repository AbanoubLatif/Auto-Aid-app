import 'package:auto_aid/constants.dart';
import 'package:auto_aid/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key}) : super(key: key);
  static String id = 'FirstScreen';

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  bool isLoading = false;

  Future<void> _handleSignUp() async {
    setState(() {
      isLoading = true;
    });

    // Simulate a network request or any other async operation
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      isLoading = false;
    });

    // Navigate to the SignUp page
    Navigator.pushNamed(context, 'SignUp');
  }

  Future<void> _handleLogin() async {
    setState(() {
      isLoading = true;
    });

    // Simulate a network request or any other async operation
    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      isLoading = false;
    });

    // Navigate to the Login page
    Navigator.pushNamed(context, 'SignInPage');
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 40, right: 50),
              child: Image.asset(KeyLogo),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 120, right: 120),
              child: CustomButton(
                height: 30,
                text: 'Sign Up',
                color: KeySecondaryColor,
                textcolor: KeyPrimaryColor,
                onPressed: _handleSignUp,
              ),
            ),
            const SizedBox(height: 28),
            Padding(
              padding: const EdgeInsets.only(left: 120, right: 120),
              child: CustomButton(
                height: 30,
                text: 'Login',
                color: KeySecondaryColor,
                textcolor: KeyPrimaryColor,
                onPressed: _handleLogin,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
