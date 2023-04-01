import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mental_health_app/src/features/auth.dart';
import 'package:mental_health_app/src/constants/colors.dart';
import 'package:mental_health_app/src/constants/image_strings.dart';
import 'package:mental_health_app/src/constants/sizes.dart';
import 'package:mental_health_app/src/constants/text_strings.dart';

import 'package:provider/provider.dart';

import '../../constants/text_styles.dart';
import '../../providers/auth_provider.dart';
import '../main/main_screen_widget.dart';
import '../register/register_screen.dart';
import 'forgetPassword/forget_password_screen.dart';
import '../../services/navigation_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? errorMessage = '';
  bool isLogin = true;

  late AuthProvider _auth;

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  bool passwordVisible = false;

  @override
  void initState() {
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
    } on FirebaseAuthException catch (e) {
      showErrorMessage(
          "Почта или пароль введены неверно. Пожалуйста, попробуйте еще");
      _controllerPassword.text = "";
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
            title: Text("Ошибка авторизации"),
            content: Text(msg),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                  },
                  child: Text("OK", style: tsAudioSubTitle,))
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
          child: _loginPageUI(widthScreen, heightScreen),
        ),
      ),
    );
  }

  Widget _loginPageUI(double widthScreen, double heightScreen) {
    return Builder(
      builder: (BuildContext context) {
        _auth = Provider.of<AuthProvider>(context);
        print(_auth.user);
        return SingleChildScrollView(
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
                      SizedBox(
                        height: 10,
                      ),
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
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ForgetPasswordScreen()));
                            },
                            child: const Text(tForgetPassword)),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      ((_auth.status == AuthStatus.Authenticating))
                          ? Align(
                              alignment: Alignment.center,
                              child: CircularProgressIndicator(),
                            )
                          : ElevatedButton(
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
                              onPressed: () async {
                                var email = _controllerEmail.text;
                                var password = _controllerPassword.text;
                                if (email.isEmpty || !email.contains("@")) {
                                  return showErrorMessage(
                                      "Пожалуйста, введите валидную почту.");
                                }
                                if (password.isEmpty) {
                                  return showErrorMessage(
                                      "Пожалуйста, введите пароль");
                                }
                                await _auth.loginUserWithEmailAndPassword(
                                    email, password);
                                if (_auth.status == AuthStatus.Error) {
                                  showErrorMessage(
                                      "Почта или пароль введены неверно. Пожалуйста, попробуйте еще");
                                  _controllerPassword.text = "";
                                }
                              },
                              child: Text(
                                tLogin,
                                style: tsButton,
                              )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            tHaveAccountQ,
                            style: tsHaveAccount,
                          ),
                          TextButton(
                            onPressed: () {
                              NavigationService.instance.navigateToRoute(MaterialPageRoute(builder: (context) => RegisterScreen()));
                            },
                            child: Text(
                              tSignUp,
                              style: tsSignInSmall,
                            ),
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
      },
    );
  }
}
