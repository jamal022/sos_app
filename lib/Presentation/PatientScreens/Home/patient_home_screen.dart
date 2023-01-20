import 'package:flutter/material.dart';
import 'package:sos_app/Presentation/PatientScreens/Home/appointments_screen.dart';
import 'package:sos_app/Presentation/PatientScreens/Home/articles_screen.dart';
import 'package:sos_app/Presentation/PatientScreens/Home/commuinty_screen.dart';
import 'package:sos_app/Presentation/PatientScreens/Home/detect_screen.dart';
import 'package:sos_app/Presentation/PatientScreens/Home/doctors_screen.dart';
import 'package:sos_app/Presentation/PatientScreens/Home/hopsitals_screen.dart';
import 'package:sos_app/Presentation/Views/home_card_widget.dart';
import '../../Styles/colors.dart';

class PatientHomeScreen extends StatefulWidget {
  const PatientHomeScreen({Key? key}) : super(key: key);

  @override
  State<PatientHomeScreen> createState() => _PatientHomeScreen();
}

List<String> texts = [
  "Detect",
  "Appointments",
  "Q/A Community",
  "Articles",
  "Doctors",
  "Hospitals"
];

List<IconData> listIcons = [
  Icons.camera_alt_outlined,
  Icons.calendar_month_outlined,
  Icons.chat_bubble_outline_outlined,
  Icons.newspaper_outlined,
  Icons.medical_services_outlined,
  Icons.factory_outlined
];

List<Widget> screens = [
  DetectScreen(),
  AppointmentsScreen(),
  CommunityScreen(),
  ArticlesScreen(),
  DoctorsScreen(),
  HospitalsScreen()
];

class _PatientHomeScreen extends State<PatientHomeScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: back,
        body: Container(
          color: back,
          child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(children: <Widget>[
                GridView.extent(
                  shrinkWrap: true,
                  primary: false,
                  padding:
                      const EdgeInsets.symmetric(vertical: 60, horizontal: 5),
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  maxCrossAxisExtent: 200.0,
                  children: <Widget>[
                    for (var i = 0; i < 6; i++)
                      HomeCardWidget(
                        text: texts[i],
                        cardIcon: listIcons[i],
                        screen: screens[i],
                      ),
                  ],
                )
              ])),
        ));
  }
}
