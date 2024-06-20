import 'package:auto_aid/constants.dart';
import 'package:auto_aid/decoration/custom_container.dart';
import 'package:auto_aid/widgets/custom_button.dart';
import 'package:auto_aid/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
class SignIn extends StatelessWidget {
  const SignIn({Key? key}) : super(key: key);
  static String id='SignInPage';
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Stack(
                    children: [
                      Positioned(
                        top: screenHeight * -0.18,
                        left: 100,
                        child: Container(
                          width: 640,
                          height: 250,
                          decoration: const BoxDecoration(
                            color:KeyPrimaryColor, // لون الخلفية للـ Container
                            shape: BoxShape.circle, // نوع الشكل للـ Container
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 90),
                        child: Center(child: Image.asset(KeyLogo,height: 200,)),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left:30,right:30,bottom: 240),//علشان اتحكم في ال container اللي تحت
                    child: CustomContainer(height:230,column:Column(
                      children: [
                        const SizedBox(height: 45),
                        CustomTextField(text:'Email',),
                        const SizedBox(height: 25),
                        CustomTextField(text:'Password',),
                        const SizedBox(height: 25),
                        const Padding(
                          padding: EdgeInsets.only(left: 110,right: 110),
                          child: CustomButton(height:30,
                            text:'Login',
                            color:KeyPrimaryColor,
                            textcolor: Colors.white,
                            numberofPop: 2,
                            navigateTo: 'HomePage',
                          ),
                        ),
                      ],
                    )),
                  ),
                ],
              ),
              Positioned(
                bottom: screenHeight * -0.1, // ارتفاع 10% من أسفل الصفحة
                right: 100,
                child: Container(
                  width: 640,
                  height: 260,
                  decoration: const BoxDecoration(
                    color: KeySecondaryColor, // لون الخلفية للـ Container
                    shape: BoxShape.circle, // نوع الشكل للـ Container
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }
}
