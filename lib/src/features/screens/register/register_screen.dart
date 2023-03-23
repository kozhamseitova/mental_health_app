import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mental_health_app/src/features/auth.dart';
import 'package:flutter/material.dart';
import 'package:mental_health_app/src/constants/colors.dart';
import 'package:mental_health_app/src/constants/image_strings.dart';
import 'package:mental_health_app/src/constants/text_strings.dart';
import 'package:mental_health_app/src/features/screens/login/login_screen.dart';
import 'package:mental_health_app/src/features/screens/register/check_box.dart';
import '../../../constants/text_styles.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String? errorMessage = '';
  bool isPsychologist = false;

  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await Auth().registerUser(
          email: _controllerEmail.text,
          password: _controllerPassword.text,
          name: _controllerName.text,
          isPsychologist: isPsychologist,
      );
      if (context.mounted) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
      }
    } on FirebaseAuthException catch(e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  // postDetailsToFirestore(String email, String role) async {
  //   print("in register");
  //   FirebaseFirestore firestore = FirebaseFirestore.instance;
  //   var user = Auth().currentUser;
  //   CollectionReference ref = firestore.collection('users');
  //   print("REGISTERING ${ref.doc(user!.uid).id}");
  //   ref.doc(user!.uid).set({'email': email, 'role': role});
  //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
  // }

  @override
  Widget build(BuildContext context) {
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
                        controller: _controllerName,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.email),
                          labelText: tEmail,
                          hintText: tEmail,
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(width: 1.0, color: Colors.grey),
                          ),),
                        controller: _controllerEmail,
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
                        controller: _controllerPassword,
                      ),
                      Row(
                        children: [
                          CheckBoxR(callback: (value) { setState(() {
                            isPsychologist = value;
                          }); },),
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
                      ), onPressed: (){ createUserWithEmailAndPassword(); }, child: Text(tSignUp, style: tsButton,)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(tHaveAccount, style: tsHaveAccount,),
                          TextButton(
                            onPressed: () { Navigator.push(context,MaterialPageRoute(builder: (context) => LoginScreen())); },
                            child: Text(tSignUp, style: tsSignInSmall,),
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
