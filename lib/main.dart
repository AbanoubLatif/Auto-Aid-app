import 'package:auto_aid/main_screens/account_settings.dart';
import 'package:auto_aid/main_screens/add_car.dart';
import 'package:auto_aid/main_screens/ai-chatbot.dart';
import 'package:auto_aid/main_screens/chat.dart';
import 'package:auto_aid/main_screens/google_map.dart';
import 'package:auto_aid/main_screens/home.dart';
import 'package:auto_aid/main_screens/main_page.dart';
import 'package:auto_aid/main_screens/service.dart';
import 'package:auto_aid/main_screens/service_book.dart';
import 'package:auto_aid/main_screens/user_info.dart';
import 'package:auto_aid/screens/first_screen.dart';
import 'package:auto_aid/screens/sign_up.dart';
import 'package:flutter/material.dart';
import 'screens/sign_in.dart';

void main() {
  runApp(const AutoAid());
}

class AutoAid extends StatelessWidget {
  const AutoAid({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        SignIn.id:(context)=> SignIn(),
        SignUp.id:(context)=>const SignUp(),
        FirstScreen.id:(context)=>const FirstScreen(),
        ServiceBook.id:(context)=>const ServiceBook(),
        ServicePage.id:(context)=>const ServicePage(),
        AiChatBot.id:(context)=>const AiChatBot(),
        AddCarScreen.id:(context)=>const AddCarScreen(),
        AccountSettings.id:(context)=> const AccountSettings(),
        UserInfo.id:(context)=>const UserInfo(),
        ChatScreen.id:(context)=>  const ChatScreen(),
        Home.id:(context)=>const Home(),
        MainPage.id:(context)=>const MainPage(),
        GoogleMapScreen.id:(context)=> const GoogleMapScreen()
      },
      initialRoute:'FirstScreen',
    );
  }
}
