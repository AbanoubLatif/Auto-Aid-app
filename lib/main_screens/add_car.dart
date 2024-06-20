import 'package:auto_aid/constants.dart';
import 'package:auto_aid/decoration/custom_container.dart';
import 'package:auto_aid/widgets/custom_button.dart';
import 'package:auto_aid/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

class AddCar extends StatefulWidget {
  const AddCar({Key? key}) : super(key: key);
  static String id='AddCarPage';

  @override
  State<AddCar> createState() => AddCarState();
}

class AddCarState extends State<AddCar> {
  TextEditingController carMakeController= TextEditingController();
  TextEditingController carModelController= TextEditingController();
  TextEditingController carYearController= TextEditingController();

  @override
  void dispose() {
    carMakeController.dispose();
    carModelController.dispose();
    carYearController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomContainer(
              borderRadius: 0,
              height: 470,column: Column(
              children: [

                Padding(
                  padding: const EdgeInsets.only(right:50,top: 20),
                  child: CarMakeTextField()
                ),
                Padding(
                  padding: const EdgeInsets.only(right:80,top: 10),
                  child:CarModelTextField()
                ),
                Padding(
                    padding: const EdgeInsets.only(right:80,top: 10),
                    child:CarYearTextField()
                ),
                Padding(
                  padding: const EdgeInsets.only(right:80,top: 10),
                  child: CustomTextField(
                    text: 'Milage in km',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right:80,top: 10),
                  child: CustomTextField(
                    text: 'Last service',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right:80,top: 10),
                  child: CustomTextField(
                    text: 'Tiers make date',
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top:30,left: 110,right: 110),
                  child: CustomButton(height:30,
                    text:'Confirm',
                    color:KeyPrimaryColor,
                    textcolor:Colors.white,
                    numberofPop: 1,
                  ),
                )
              ],
            ),),
            SizedBox(height: MediaQuery.of(context).viewInsets.bottom), // Adjust the padding when the keyboard appears
          ],
        ),
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
            carModelController.text = value;
          });
        },
      ),
    );
  }
  // ignore: non_constant_identifier_names
  Widget CarYearTextField() {
    return CustomTextField(
      text: 'Model Year',
      controller: carYearController,
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
            carYearController.text = value;
          });
        },
      ),
    );
  }
}
