import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sos_app/Presentation/DoctorScreens/Profile/doctor_profile_screen.dart';
import 'package:sos_app/Presentation/PatientScreens/Home/patient_home_screen.dart';
import 'package:sos_app/Presentation/PatientScreens/Profile/patient_profile_screen.dart';
import 'package:sos_app/Presentation/Screens/App_Layout/bottom_nav_bar.dart';
import 'package:sos_app/Presentation/Screens/Start/start_screen.dart';
import '../../../Data/Models/doctor.dart';
import '../../../Data/Models/patient.dart';
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
  var name;
  var email;
  var password;
  var phone;
  var image;
  var age;
  var gender;
  var bio;
  var field;
  var price;
  var experience;
  var addLat;
  var addLong;
  var id;
  late Patient patient;
  late Doctor doctor;

  getPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    id = prefs.getString("Id");
    role = prefs.getString("Role");
    name = prefs.getString("FullName");
    email = prefs.getString("Email");
    password = prefs.getString("Password");
    phone = prefs.getString("PhoneNumber");
    age = prefs.getString("Age");
    gender = prefs.getString("Gender");
    image = prefs.getString("Image");
    field = prefs.getString("Field");
    experience = prefs.getString("YearsOfExperience");
    price = prefs.getString("TicketPrice");
    bio = prefs.getString("Bio");
    addLat = prefs.getString("AddressLatitude");
    addLong = prefs.getString("AddressLongitude");

    patient = Patient(
        id: id,
        username: name,
        email: email,
        phoneNumber: phone,
        password: password,
        age: age,
        gender: gender,
        image: image);

    doctor = Doctor(
        id: id,
        username: name,
        email: email,
        phoneNumber: phone,
        password: password,
        age: age,
        gender: gender,
        image: image,
        field: field,
        experience: experience,
        price: price,
        addressLat: addLat,
        addressLong: addLong,
        bio: bio);
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
                                      ? PatientProfileScreen(
                                          patient: patient,
                                        )
                                      : DoctorProfileScreen(
                                          doctor: doctor,
                                        ),
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
