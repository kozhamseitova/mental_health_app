import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mental_health_app/src/constants/colors.dart';
import 'package:mental_health_app/src/constants/image_strings.dart';
import 'package:mental_health_app/src/constants/text_strings.dart';
import 'package:mental_health_app/src/features/authentication/screens/home/home_screen.dart';
import 'package:mental_health_app/src/features/authentication/screens/login/forgetPassword/forget_password_screen.dart';
import 'package:mental_health_app/src/features/authentication/screens/register/register_screen.dart';

import '../../../../constants/text_styles.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var widthScreen = MediaQuery.of(context).size.width;

    var heightScreen = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: cBackgroundColor,
      body: Center(
        child: Container(
          width: widthScreen * 0.85,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: heightScreen * 0.005,
              ),
              Image(
                image: AssetImage(tWelcomePageImageSunrise),
                height: 130,
              ),
              Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      tLogin,
                      style: tsLoginTitle,
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text(
                    tLoginSubTitle,
                    style: tsLoginSubTitle,
                  ),
                ],
              ),
              Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.person_outline_outlined),
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
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                        onPressed: (){ Navigator.push(context,MaterialPageRoute(builder: (context) => ForgetPasswordScreen())); }, child: Text(tForgetPassword)),
                  ),
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
                  ), onPressed: (){ Navigator.push(context,MaterialPageRoute(builder: (context) => HomeScreen())); }, child: Text(tLogin, style: tsButton,)),
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
              ),
              SizedBox(
                height: heightScreen * 0.1,
              )
            ],
          ),
        ),
      ),
    );
  }
}
