import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mental_health_app/src/features/auth.dart';
import 'package:flutter/material.dart';
import 'package:mental_health_app/src/constants/colors.dart';
import 'package:mental_health_app/src/constants/image_strings.dart';
import 'package:mental_health_app/src/constants/text_strings.dart';
import 'package:mental_health_app/src/providers/auth_provider.dart';
import 'package:mental_health_app/src/services/db_service.dart';
import 'package:provider/provider.dart';

import '../../constants/text_styles.dart';
import '../login/login_screen.dart';
import 'check_box.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String? errorMessage = '';
  bool isPsychologist = false;

  late AuthProvider _auth;

  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  bool passwordVisible = false;

  @override
  void initState() {
    super.initState();
    passwordVisible = true;
  }

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await Auth().registerUser(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
        name: _controllerName.text,
        isPsychologist: isPsychologist,
      );
      if (context.mounted) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LoginScreen()));
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  void showErrorMessage(String msg) {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: Text("Ошибка регистрации"),
            content: Text(msg),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: Text("OK"))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    var widthScreen = MediaQuery.of(context).size.width;
    var heightScreen = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        backgroundColor: cBackgroundColor,
        body: ChangeNotifierProvider<AuthProvider>.value(
          value: AuthProvider.instance,
          child: registerPageUI(widthScreen, heightScreen),
        ),
      ),
    );
  }

  Widget registerPageUI(double widthScreen, double heightScreen) {
    return Builder(
      builder: (BuildContext context) {
        _auth = Provider.of<AuthProvider>(context);
        return SingleChildScrollView(
          child: Center(
            child: Container(
              width: widthScreen * 0.85,
              child: Column(
                children: [
                  SizedBox(
                    height: heightScreen * 0.05,
                  ),
                  Column(
                    children: [
                      Image(
                        image: AssetImage(tWelcomePageImageSunrise),
                        height: 130,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          tSignUp,
                          style: tsLoginTitle,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        tRegisterSubTitle,
                        style: tsLoginSubTitle,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: heightScreen * 0.05,
                  ),
                  Column(
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.person_outline_outlined),
                          labelText: tName,
                          hintText: tName,
                          enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(width: 1.0, color: Colors.grey),
                          ),
                        ),
                        controller: _controllerName,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.email),
                          labelText: tEmail,
                          hintText: tEmail,
                          enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(width: 1.0, color: Colors.grey),
                          ),
                        ),
                        controller: _controllerEmail,
                      ),
                      TextFormField(
                        obscureText: passwordVisible,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.fingerprint),
                          labelText: tPassword,
                          hintText: tPassword,
                          enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(width: 1.0, color: Colors.grey),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                passwordVisible = !passwordVisible;
                              });
                            },
                            icon: Icon(passwordVisible
                                ? Icons.remove_red_eye_sharp
                                : Icons.visibility_off_sharp),
                          ),
                        ),
                        controller: _controllerPassword,
                      ),
                      Row(
                        children: [
                          CheckBoxR(
                            callback: (value) {
                              setState(() {
                                isPsychologist = value;
                              });
                            },
                          ),
                          Text(
                            tPsychologist,
                            style: tsPsychologist,
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: heightScreen * 0.05,
                  ),
                  Column(
                    children: [
                      _auth.status != AuthStatus.Authenticating ? ElevatedButton(
                          style: ButtonStyle(
                            minimumSize:
                            MaterialStateProperty.all(Size(275, 60)),
                            backgroundColor:
                            MaterialStateProperty.all(cButtonColor),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          onPressed: () {
                            var name = _controllerName.text;
                            var email = _controllerEmail.text;
                            var password = _controllerPassword.text;
                            if (name.isEmpty) {
                              return showErrorMessage("Пожалуйста, напишите свое имя");
                            }
                            if (email.isEmpty || !email.contains("@")) {
                              return showErrorMessage("Пожалуйста, введите валидную почту");
                            }
                            if (password.length < 6) {
                              return showErrorMessage("Пароль должен состоять минимум из 6 символов");
                            }

                            _auth.registerUserWithEmailAndPassword(email, password, (String uid) async {
                              await DBService.instance.createUserInDB(uid, name, email, isPsychologist);
                            });
                          },
                          child: Text(
                            tSignUp,
                            style: tsButton,
                          )) : Align(
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            tHaveAccount,
                            style: tsHaveAccount,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreen()));
                            },
                            child: Text(
                              tLogin,
                              style: tsSignInSmall,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: heightScreen * 0.1,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
