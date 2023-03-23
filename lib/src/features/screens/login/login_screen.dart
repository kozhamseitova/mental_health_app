import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mental_health_app/src/features/auth.dart';
import 'package:mental_health_app/src/constants/colors.dart';
import 'package:mental_health_app/src/constants/image_strings.dart';
import 'package:mental_health_app/src/constants/sizes.dart';
import 'package:mental_health_app/src/constants/text_strings.dart';
import 'package:mental_health_app/src/features/screens/home/home_screen.dart';
import 'package:mental_health_app/src/features/screens/login/forgetPassword/forget_password_screen.dart';
import 'package:mental_health_app/src/features/screens/main/main_screen_widget.dart';
import 'package:mental_health_app/src/features/screens/register/register_screen.dart';

import '../../../constants/text_styles.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();

}

class _LoginScreenState extends State<LoginScreen> {
  String? errorMessage = '';
  bool isLogin = true;

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();


  bool passwordVisible = false;

  @override
  void initState(){
    super.initState();
    passwordVisible = true;
  }


  Future<void> signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(
          email: _controllerEmail.text, password: _controllerPassword.text);
      if (context.mounted) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const MainScreenWidget()));
      }
    } on FirebaseAuthException catch(e) {
      showDialog(context: context, builder: (ctx) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text("Ошибка авторизации"),
          content: Text("Почта или пароль введены неверно. Пожалуйста, попробуйте еще"),
          actions: <Widget>[
            TextButton(onPressed: () {
              Navigator.of(ctx).pop();
            }, child: Text("OK"))
          ],
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var widthScreen = MediaQuery
        .of(context)
        .size
        .width;
    var heightScreen = MediaQuery
        .of(context)
        .size
        .height;



    return SafeArea(
      child: Scaffold(
        backgroundColor: cBackgroundColor,
        body: SingleChildScrollView(
          child: Center(

            child: Container(
              width: widthScreen * 0.85,
              height: heightScreen,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Image(
                    image: AssetImage(tWelcomePageImageSunrise),
                    height: 130,
                  ),
                  Column(
                    children: const [
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
                            borderSide: BorderSide(
                                width: 1.0, color: Colors.grey),
                          ),),
                        controller: _controllerEmail,
                      ),
                      TextFormField(
                        obscureText: passwordVisible,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.fingerprint),
                          labelText: tPassword,
                          hintText: tPassword,
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                width: 1.0, color: Colors.grey),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                passwordVisible = !passwordVisible;
                              });
                            },
                            icon: Icon(passwordVisible ? Icons.remove_red_eye_sharp : Icons.visibility_off_sharp),
                          ),
                        ),
                        controller: _controllerPassword,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) =>
                                      ForgetPasswordScreen()));
                            }, child: const Text(tForgetPassword)),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      ElevatedButton(style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(Size(275, 60)),
                        backgroundColor: MaterialStateProperty.all(
                            cButtonColor),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ), onPressed: () {
                        signInWithEmailAndPassword();
                      }, child: Text(tLogin, style: tsButton,)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(tHaveAccountQ, style: tsHaveAccount,),
                          TextButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => RegisterScreen()));
                            },
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
        ),
      ),
    );
  }
}


