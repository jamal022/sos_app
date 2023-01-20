import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sos_app/Presentation/Screens/SignUp/doctorSignup_screen.dart';
import 'package:sos_app/Presentation/Screens/SignUp/signup_screen.dart';
import 'package:sos_app/Presentation/Screens/Splash/splash_screen.dart';
import 'package:sos_app/Presentation/Styles/colors.dart';
import './Presentation/Screens/Login/login_screen.dart';
import 'Presentation/Screens/SignUp/signup_screen.dart';
import 'Presentation/Styles/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SOS',
        home: SplashScreen(),
        routes: {
          "login": (context) => LoginScreen(),
        });
  }
}
