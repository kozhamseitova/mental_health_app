import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:mental_health_app/firebase_options.dart';
import 'package:mental_health_app/src/constants/colors.dart';
import 'package:mental_health_app/src/screens/appointment_request/appointment_request_screen.dart';
import 'package:mental_health_app/src/screens/home/home_screen.dart';
import 'package:mental_health_app/src/screens/login/login_screen.dart';
import 'package:mental_health_app/src/screens/main/main_screen_widget.dart';
import 'package:mental_health_app/src/screens/meditation/meditation_screen.dart';
import 'package:mental_health_app/src/screens/profile/user_profile_screen.dart';
import 'package:mental_health_app/src/screens/register/register_screen.dart';
import 'package:mental_health_app/src/screens/sleep/sleep_screen.dart';
import 'package:mental_health_app/src/screens/welcome/welcome_screen.dart';
import 'package:mental_health_app/src/services/navigation_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Mental Health',
      debugShowCheckedModeBanner: false,
      navigatorKey: NavigationService.instance.navigatorKey,
      // defaultTransition: Transition.leftToRightWithFade,
      // transitionDuration: const Duration(milliseconds: 500),
      theme: ThemeData(
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: cItemColor,
            unselectedItemColor: cIconColor,
            selectedItemColor: cSelectedIconColor,
            type: BottomNavigationBarType.fixed),
        primarySwatch: primary,
        brightness: Brightness.dark,
      ),
      initialRoute: "welcome",
      routes: {
        "main": (BuildContext context) => MainScreenWidget(),
        "welcome": (BuildContext context) => WelcomeScreen(),
        "login": (BuildContext context) => LoginScreen(),
        "register": (BuildContext context) => RegisterScreen(),
        "home": (BuildContext context) => HomeScreen(),
        "meditation": (BuildContext context) => MeditationScreen(),
        "sleep": (BuildContext context) => SleepScreen(),
        "appointment": (BuildContext context) => AppointmentRequestScreen(),
        "profile": (BuildContext context) => UserProfileScreen(),
      },
    );
  }
}