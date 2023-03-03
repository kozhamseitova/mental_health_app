import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mental_health_app/src/constants/image_strings.dart';
import 'package:mental_health_app/src/constants/text_strings.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(tWelcomePageImage),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Text(tWelcomeTitle),
            Text(tWelcomeSubTitle),
            ElevatedButton(onPressed: (){}, child: Text(tLogin)),
            Row(
              children: [
                Text(tHaveAccountQ),
                Text(tSignUp)
              ],
            )
          ],
        ),
      ),
    );
  }


}