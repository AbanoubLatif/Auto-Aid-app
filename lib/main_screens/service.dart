import 'package:auto_aid/constants.dart';
import 'package:auto_aid/decoration/custom_container.dart';
import 'package:auto_aid/widgets/custom_icon_back.dart';
import 'package:flutter/material.dart';

class ServicePage extends StatelessWidget {
  const ServicePage({Key? key}) : super(key: key);
  static String id='ServicePage';
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          CustomIconBack(),
          Padding(
            padding: EdgeInsets.only(top:40,right: 20,left: 20),
            child: CustomContainer(height: 350,width: 360,
              column: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 25,left: 40),
                  child: Text('Next Service:',
                  style: TextStyle(
                    fontSize: 23,color: Colors.white,fontWeight: FontWeight.bold,
                  ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15,left: 70),
                  child: Text('Front Tiers',
                    style: TextStyle(
                      fontSize: 20,color:KeyPrimaryColor,fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10,left: 70),
                  child: Text('brake system',
                    style: TextStyle(
                      fontSize: 20,color:KeyPrimaryColor,fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10,left: 70),
                  child: Text('Engine oil',
                    style: TextStyle(
                      fontSize: 20,color:KeyPrimaryColor,fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),),
          )

        ],
      ),
    );
  }
}
