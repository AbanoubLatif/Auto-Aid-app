import 'package:flutter/material.dart';
import '../constants.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_textfield.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);
  static String id = 'SignUp';
  @override
  SignUpState createState() => SignUpState();
}

class SignUpState extends State<SignUp> {
  TextEditingController carMakeController= TextEditingController();
  TextEditingController carModelController= TextEditingController();
  @override
  void dispose() {
    carMakeController.dispose();
    carModelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KeySecondaryColor,
      body: ListView(
        children: [
          Image.asset(KeyLogo, height: 210,),
          CustomTextField(text: 'User Name'),
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: CustomTextField(text: 'Email',),
          ),
          Padding(
            padding: const EdgeInsets.only(top:15),
            child: CarMakeTextField(),
          ),
          Padding(
            padding: const EdgeInsets.only(top:15),
            child: CarModelTextField(),
          ),// Use the custom method to build Car Make field
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: CustomTextField(text: 'Car milage',),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: CustomTextField(text: 'Password',),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: CustomTextField(text: 'Tiers make date',),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: CustomTextField(text: 'Your avg daily milage',),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 130, right: 130, bottom: 150,top: 15),
            child: CustomButton(height:30,
              text: 'Sign Up',
              color:KeyPrimaryColor,
              textcolor: Colors.white,
              numberofPop: 2,
              navigateTo: 'HomePage',
            ),
          ),
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget CarMakeTextField() {
    return CustomTextField(
      text: 'Car Make',
      controller: carMakeController,
      suffixIcon: PopupMenuButton<String>(
        icon: const Icon(Icons.arrow_downward_outlined, color: Colors.blue),
        itemBuilder: (BuildContext context) {
          return <PopupMenuEntry<String>>[
            const PopupMenuItem<String>(
              value: 'Toyota',
              child: Text('Toyota'),
            ),
            const PopupMenuItem<String>(
              value: 'Honda',
              child: Text('Honda'),
            ),
            const PopupMenuItem<String>(
              value: 'Ford',
              child: Text('Ford'),
            ),
            // Add more items as needed
          ];
        },
        onSelected: (String value) {
          // When an item is selected, update the text field value
          setState(() {
            carMakeController.text = value;
          });
        },
      ),
    );
  }
  // ignore: non_constant_identifier_names
  Widget CarModelTextField() {
    return CustomTextField(
      text: 'Car Model',
      controller: carModelController,
      suffixIcon: PopupMenuButton<String>(
        icon: const Icon(Icons.arrow_downward_outlined, color: Colors.blue),
        itemBuilder: (BuildContext context) {
          return <PopupMenuEntry<String>>[
            const PopupMenuItem<String>(
              value: '2000',
              child: Text('2000'),
            ),
            const PopupMenuItem<String>(
              value: '2002',
              child: Text('2002'),
            ),
            const PopupMenuItem<String>(
              value: '2006',
              child: Text('2006'),
            ),
            // Add more items as needed
          ];
        },
        onSelected: (String value) {
          // When an item is selected, update the text field value
          setState(() {
            carModelController.text = value;
          });
        },
      ),
    );
  }

}
