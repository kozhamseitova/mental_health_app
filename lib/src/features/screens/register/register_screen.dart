import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mental_health_app/src/constants/colors.dart';
import 'package:mental_health_app/src/constants/image_strings.dart';
import 'package:mental_health_app/src/constants/text_strings.dart';
import 'package:mental_health_app/src/features/screens/login/login_screen.dart';
import 'package:mental_health_app/src/features/screens/register/check_box.dart';

import '../../../constants/sizes.dart';
import '../../../constants/text_styles.dart';
import '../home/home_screen.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isPsychologist = false;

    var widthScreen = MediaQuery.of(context).size.width;

    var heightScreen = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        backgroundColor: cBackgroundColor,
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              width: widthScreen * 0.85,
              child: Column(
                children: [
                  SizedBox(height: heightScreen * 0.05,),
                  Column(
                    children: [
                      Image(
                        image: AssetImage(tWelcomePageImageSunrise),
                        height: 130,
                      ),
                      SizedBox(height: 20,),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          tSignUp,
                          style: tsLoginTitle,
                        ),
                      ),
                      SizedBox(height: 10,),
                      Text(
                        tRegisterSubTitle,
                        style: tsLoginSubTitle,
                      ),
                    ],
                  ),
                  SizedBox(height: heightScreen * 0.05,),
                  Column(
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.person_outline_outlined),
                          labelText: tName,
                          hintText: tName,
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(width: 1.0, color: Colors.grey),
                          ),),
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.email),
                          labelText: tEmail,
                          hintText: tEmail,
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(width: 1.0, color: Colors.grey),
                          ),),
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.fingerprint),
                          labelText: tPassword,
                          hintText: tPassword,
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(width: 1.0, color: Colors.grey),
                          ),
                          suffixIcon: IconButton(
                            onPressed: null,
                            icon: Icon(Icons.remove_red_eye_sharp),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          CheckBoxR(),
                          Text(tPsychologist, style: tsPsychologist,)
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: heightScreen * 0.05,),
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
                      ), onPressed: (){ Navigator.push(context,MaterialPageRoute(builder: (context) => HomeScreen())); }, child: Text(tLogin, style: tsButton,)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(tHaveAccount, style: tsHaveAccount,),
                          TextButton(
                            onPressed: () { Navigator.push(context,MaterialPageRoute(builder: (context) => LoginScreen())); },
                            child: Text(tLogin, style: tsSignInSmall,),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: heightScreen * 0.1,),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
