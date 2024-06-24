import 'package:auto_aid/constants.dart';
import 'package:auto_aid/decoration/custom_container.dart';
import 'package:auto_aid/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class AiChatBot extends StatefulWidget {
  const AiChatBot({Key? key}) : super(key: key);
  static String id='AiChatBotPage';

  @override
  State<AiChatBot> createState() => AiChatBotState();
}

class AiChatBotState extends State<AiChatBot> {
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
            const Padding(
              padding: EdgeInsets.only(top:280,left:30,right:30),
              child: CustomContainer(child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top:20),
                    child: Text('try to solve your car problem',
                      style: TextStyle(fontSize: 30,color: KeyPrimaryColor,fontWeight:FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 30,left: 100,right: 100),
                    child: CustomButton(height:40,
                      text:'Confirm',
                      color:KeyPrimaryColor,
                      textcolor:Colors.white,
                      navigateTo: 'ChatPage',
                    ),
                  ),
                  SizedBox(
                    height: 20,
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

}

