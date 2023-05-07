import 'package:flutter/material.dart';
import 'package:sos_app/Presentation/Screens/Login/login_screen.dart';
import 'package:sos_app/Presentation/Screens/SignUp/signup_screen.dart';
import 'package:sos_app/Presentation/Styles/colors.dart';
import 'package:sos_app/Presentation/Styles/fonts.dart';
import '../../Constants/app_assets.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: back,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 30),
            child: Column(
              children: <Widget>[
                const Spacer(),
                const Text(
                  "Hello There!",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 42),
                ),
                const Spacer(),
                const Text(
                  "Automatic burn degree detection which help you to detect your burn degree",
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 19,
                    color: black,
                  ),
                ),
                const Spacer(),
                Image.asset(sosLogoImage),
                const Spacer(),
                MaterialButton(
                    elevation: 6.0,
                    color: primaryColor,
                    shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ));
                    },
                    child: const Text(
                      '                 Login                  ',
                      style: TextStyle(
                        color: white,
                        fontSize: formButtonFont,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                const SizedBox(
                  height: 5,
                ),
                MaterialButton(
                    elevation: 6.0,
                    color: blueColor,
                    shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUpScreen(),
                          ));
                    },
                    child: const Text(
                      '                SignUp                 ',
                      style: TextStyle(
                        color: black,
                        fontSize: formButtonFont,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
              ],
            ),
          ),
        ));
  }
}
