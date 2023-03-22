import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sos_app/Presentation/AdminScreens/Home/admin_home_screen.dart';
import 'package:sos_app/Presentation/DoctorScreens/Profile/doctor_profile_screen.dart';
import 'package:sos_app/Presentation/PatientScreens/Home/patient_home_screen.dart';
import 'package:sos_app/Presentation/PatientScreens/Profile/patient_profile_screen.dart';
import 'package:sos_app/Presentation/Screens/App_Layout/bottom_nav_bar.dart';
import 'package:sos_app/Presentation/Screens/Start/start_screen.dart';
import '../../Constants/app_assets.dart';
import 'package:sos_app/Presentation/Styles/colors.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import '../../DoctorScreens/Home/doctor_home_screen.dart';
import '../Chats/chats_screen.dart';
import '../Notifications/notifications_screen.dart';
import '../Settings/settings_screen.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);

  var role;

  getPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    role = prefs.getString("Role");
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: lightwhite,
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: size.height / 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Image.asset(
                sosLogoImage,
                width: size.width / 2,
                height: size.height / 2,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              width: 15.0,
              child: TextLiquidFill(
                text: 'SOS',
                waveColor: primaryColor,
                boxBackgroundColor: lightwhite,
                textStyle: const TextStyle(
                  fontSize: 50.0,
                  fontWeight: FontWeight.bold,
                ),
                boxHeight: 200.0,
              ),
            ),
            SizedBox(height: size.height / 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: LinearPercentIndicator(
                  animation: true,
                  lineHeight: 7.0,
                  animationDuration: 6000,
                  percent: 1,
                  barRadius: const Radius.circular(50),
                  progressColor: primaryColor,
                  onAnimationEnd: () async {
                    await getPrefs();
                    role == null
                        ? Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const StartScreen(),
                            ),
                            (Route<dynamic> route) => false,
                          )
                        : role == "admin"
                            ? Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const AdminHomeScreen()),
                                (Route<dynamic> route) => false,
                              )
                            : Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BottomNavBar(
                                    screens: [
                                      SettingScreen(),
                                      ChatsScreen(),
                                      role == "Patient"
                                          ? PatientHomeScreen()
                                          : DoctorHomeScreen(),
                                      NotificationsScreen(),
                                      role == "Patient"
                                          ? PatientProfileScreen()
                                          : DoctorProfileScreen(),
                                    ],
                                  ),
                                ),
                                (Route<dynamic> route) => false,
                              );
                  }),
            ),
          ]),
    );
  }
}
