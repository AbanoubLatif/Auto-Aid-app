import 'package:flutter/material.dart';

import '../constants.dart';

class CustomIconBack extends StatelessWidget {
  const CustomIconBack({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:50,left:5),
      child: GestureDetector(
        onTap: (){
          Navigator.pop(context);
        },
        child: const Row(
          children: [
            Icon(Icons.arrow_back,
              size: 30,color: KeyPrimaryColor,
            ),
            Text('Back',
              style: TextStyle(
                  fontSize: 20,color: KeyPrimaryColor
              ),
            ),
          ],
        ),
      ),
    );
  }
}
