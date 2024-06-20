import 'package:auto_aid/constants.dart';
import 'package:auto_aid/decoration/car_container.dart';
import 'package:auto_aid/main_screens/add_car.dart';
import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);
  static String id = 'MainPage';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 80, left: 10),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: KeySecondaryColor,
                    maxRadius: 35,
                    child: Image.asset(
                      'assets/images/36280650-defaut-avatar.jpg',
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    'userName',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  )
                ],
              ),
            ),
            const CarContainer(
              StackHeight: 290,
              CustomContainerHeight: 250,
              TopPadding: 10,
              EditDeleteTopPadding: 250,
            ),
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                    context: context, builder:(context)
                {
                  return const AddCar();
                });
              },
              child: const Padding(
                padding: EdgeInsets.only(top: 25,bottom: 25),
                child: Text(
                  'Add Car',
                  style: TextStyle(
                    color: KeyPrimaryColor,
                    fontSize: 15,
                    decoration: TextDecoration.underline,
                    decorationThickness: 2,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
