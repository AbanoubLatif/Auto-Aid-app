import 'package:auto_aid/constants.dart';
import 'package:auto_aid/decoration/custom_container.dart';
import 'package:auto_aid/widgets/custom_button.dart';
import 'package:auto_aid/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

class ServiceBook extends StatefulWidget {
  const ServiceBook({Key? key}) : super(key: key);
  static String id='ServiceBookPage';

  @override
  State<ServiceBook> createState() => ServiceBookState();
}

class ServiceBookState extends State<ServiceBook> {
  // ignore: non_constant_identifier_names
  TextEditingController YourCarController=TextEditingController();
  @override
  void dispose() {
    YourCarController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top:180,left:30,right:30),
              child: CustomContainer(height: 250,column: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top:20),
                    child: Text('choose car to show        its service book',
                      style: TextStyle(fontSize: 30,color: KeyPrimaryColor,fontWeight:FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:20),
                    child: YourCarTextField(),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 30,left: 100,right: 100),
                    child: CustomButton(height:30,
                      text:'Confirm',
                      color:KeyPrimaryColor,
                      textcolor:Colors.white,
                      navigateTo: 'ServicePage',
                    ),
                  )
                ],
              ),),
            ),
            SizedBox(height: MediaQuery.of(context).viewInsets.bottom), // Adjust the padding when the keyboard appears
          ],
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget YourCarTextField() {
    return CustomTextField(
      text: 'Your car',
      controller: YourCarController,
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
            YourCarController.text = value;
          });
        },
      ),
    );
  }
}
