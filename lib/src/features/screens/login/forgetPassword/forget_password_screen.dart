import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mental_health_app/src/constants/colors.dart';
import 'package:mental_health_app/src/constants/text_strings.dart';
import 'package:mental_health_app/src/constants/text_styles.dart';
import 'package:mental_health_app/src/features/screens/login/login_screen.dart';

import '../../../../common_widgets/fade_in_animation/animation_controller.dart';
import '../../../../common_widgets/fade_in_animation/animation_design.dart';
import '../../../../constants/image_strings.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FadeInAnimationController());
    controller.startAnimation();


    var heightScreen = MediaQuery.of(context).size.height;
    var widthScreen = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: cBackgroundColor,
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            height: heightScreen,
            width: widthScreen * 0.85,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image(image: AssetImage(tForgetPasswordImage)),
                  TextFormField(
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.person_outline_outlined),
                      labelText: tEmail,
                      hintText: tEmail,
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(width: 1.0, color: Colors.grey),
                      ),),
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
                      ), onPressed: (){ }, child: Text(tForgetPasswordButton, style: tsButton,)),
                      TextButton(
                        onPressed: () { Navigator.push(context,MaterialPageRoute(builder: (context) => LoginScreen())); },
                        child: Text(tForgetPasswordBack, style: tsForgetPassword,),
                      ),
                    ],
                  ),
                ]),
          ),
        ),
      ),
    );
  }


}