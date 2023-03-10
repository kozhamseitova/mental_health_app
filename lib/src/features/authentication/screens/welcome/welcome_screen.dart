import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mental_health_app/src/common_widgets/fade_in_animation/animation_controller.dart';
import 'package:mental_health_app/src/common_widgets/fade_in_animation/animation_design.dart';
import 'package:mental_health_app/src/constants/colors.dart';
import 'package:mental_health_app/src/constants/image_strings.dart';
import 'package:mental_health_app/src/constants/text_strings.dart';
import 'package:mental_health_app/src/constants/text_styles.dart';
import 'package:mental_health_app/src/features/authentication/screens/login/login_screen.dart';

import '../register/register_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FadeInAnimationController());
    controller.startAnimation();
    var heightScreen = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          TFadeInAnimation(
            durationInMs: 1200,
            animate: TAnimatePosition(bottomAfter: 0, bottomBefore: -100, leftAfter: 0, leftBefore: 0, rightAfter: 0, rightBefore: 0, topAfter: 0, topBefore: 0),
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(tWelcomePageImage),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(height: heightScreen * 0.25,),
                  Column(
                    children: [
                      Text(tWelcomeTitle, style: tsWelcomePageTitle,),
                      SizedBox(height: 15),
                      Text(tWelcomeSubTitle, style: tsWelcomePageSubTitle,),
                    ],
                  ),
                  Column(
                    children: [
                      ElevatedButton(style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(Size(275, 60)),
                        backgroundColor: MaterialStateProperty.all(cButtonColor),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ), onPressed: (){ Navigator.push(context,MaterialPageRoute(builder: (context) => LoginScreen())); }, child: Text(tLogin, style: tsButton,)),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(tHaveAccountQ, style: tsHaveAccount,),
                          TextButton(
                            onPressed: () { Navigator.push(context,MaterialPageRoute(builder: (context) => RegisterScreen())); },
                            child: Text(tSignUp, style: tsSignInSmall,),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }


}