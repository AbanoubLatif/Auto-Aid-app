import 'package:auto_aid/constants.dart';
import 'package:auto_aid/main_screens/account_settings.dart';
import 'package:auto_aid/main_screens/add_car.dart';
import 'package:auto_aid/main_screens/ai-chatbot.dart';
import 'package:auto_aid/main_screens/main_page.dart';
import 'package:auto_aid/main_screens/service_book.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  static String id='HomePage';
  @override
  HomeState createState() => HomeState();
}
class HomeState extends State<Home> {
  int currentIndex = 2;
  late double iconSize;

  final List<Widget> screens = [
  const AddCar(),
  const AiChatBot(),
  const MainPage(),
  const ServiceBook(),
  const AccountSettings(),
];

  @override
  void initState() {
    super.initState();
    iconSize = 45; // تحديد قيمة iconSize في initState
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: screens[currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        index: currentIndex,
        height: 65,
        animationCurve: Curves.easeOutSine,
        animationDuration: const Duration(milliseconds: 200),
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: KeySecondaryColor,
        color: KeyPrimaryColor,
        items: [
          // Icon(Icons.map,color: Colors.white,size: iconSize,),
          Image(image: const AssetImage('assets/images/map logo.png'), height: iconSize, width: iconSize),
          Image(image: const AssetImage('assets/images/boot_icon.png'), height: iconSize, width: iconSize),
          Image(image: const AssetImage('assets/images/home_icon.png'), height: iconSize, width: iconSize),
          Image(image: const AssetImage('assets/images/service_icon.png'), height: iconSize, width: iconSize),
          Image(image: const AssetImage('assets/images/settings_icon.png'), height: iconSize, width: iconSize),
        ],
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}

