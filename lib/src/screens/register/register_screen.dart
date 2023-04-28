import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:mental_health_app/src/features/auth.dart';
import 'package:flutter/material.dart';
import 'package:mental_health_app/src/constants/colors.dart';
import 'package:mental_health_app/src/constants/image_strings.dart';
import 'package:mental_health_app/src/constants/text_strings.dart';
import 'package:mental_health_app/src/providers/auth_provider.dart';
import 'package:mental_health_app/src/services/cloud_storage_service.dart';
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
  final TextEditingController _controllerExp = TextEditingController();

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
            backgroundColor: cItemColor,
            icon: Icon(Icons.error_outline),
            iconColor: Colors.red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: Text("Тіркеу қатесі"),
            content: Text(msg),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: Text(
                    "OK",
                    style: tsAudioSubTitle,
                  ))
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
                          tSignUpQaz,
                          style: tsLoginTitle,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          tRegisterSubTitleQaz,
                          style: tsLoginSubTitle,
                        ),
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
                          labelText: tNameQaz,
                          hintText: tNameQaz,
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
                          labelText: tPasswordQaz,
                          hintText: tPasswordQaz,
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
                            tPsychologistQaz,
                            style: tsPsychologist,
                          )
                        ],
                      ),
                      if (isPsychologist)
                        TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.star),
                            labelText: tExpQaz,
                            hintText: "Ваш опыт в годах",
                            enabledBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(width: 1.0, color: Colors.grey),
                            ),
                          ),
                          controller: _controllerExp,
                        ),
                    ],
                  ),
                  SizedBox(
                    height: heightScreen * 0.05,
                  ),
                  Column(
                    children: [
                      _auth.status != AuthStatus.Authenticating
                          ? ElevatedButton(
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
                                var exp = _controllerExp.text;
                                var expInt = 0;
                                if (name.isEmpty) {
                                  return showErrorMessage(
                                      "Өз атыңызды жазыңыз");
                                }
                                if (email.isEmpty || !email.contains("@")) {
                                  return showErrorMessage(
                                      "Жарамды поштаны енгізіңіз");
                                }
                                if (password.length < 6) {
                                  return showErrorMessage(
                                      "Құпия сөз кем дегенде 6 таңбадан тұруы керек");
                                }
                                if (isPsychologist) {
                                  if (exp.isEmpty || exp.length > 2) {
                                    return showErrorMessage(
                                      "Тәжірибеңізді енгізіңіз"
                                    );
                                  } else {
                                    expInt = int.parse(exp);
                                  }
                                }

                                _auth.registerUserWithEmailAndPassword(
                                    email, password, (String uid) async {
                                  await DBService.instance.createUserInDB(
                                      uid, name, email, isPsychologist, expInt);
                                });
                                if (_auth.status == AuthStatus.Error) {
                                  _controllerEmail.text = "";
                                  showErrorMessage(
                                      "Мұндай поштасы бар пайдаланушы қазірдің өзінде бар");
                                }

                              },
                              child: Text(
                                tSignUpQaz,
                                style: tsButton,
                              ))
                          : Align(
                              alignment: Alignment.center,
                              child: CircularProgressIndicator(),
                            ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            tHaveAccountQQaz,
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
                              tLoginQaz,
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
