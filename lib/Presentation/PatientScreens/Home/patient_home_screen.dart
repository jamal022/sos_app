import 'package:flutter/material.dart';
import 'package:sos_app/Presentation/PatientScreens/Home/appointments_screen.dart';
import 'package:sos_app/Presentation/PatientScreens/Home/articles_screen.dart';
import 'package:sos_app/Presentation/PatientScreens/Home/Community/commuinty_screen.dart';
import 'package:sos_app/Presentation/PatientScreens/Home/DetectScreens/detect_screen.dart';
import 'package:sos_app/Presentation/PatientScreens/Home/Doctors/doctors_screen.dart';
import 'package:sos_app/Presentation/Views/home_card_widget.dart';
import '../../Styles/colors.dart';
import 'Hospitals/hospitals_screen.dart';

class PatientHomeScreen extends StatefulWidget {
  const PatientHomeScreen({Key? key}) : super(key: key);

  @override
  State<PatientHomeScreen> createState() => _PatientHomeScreen();
}

List<String> texts = [
  "Detect",
  "Appointments",
  "Community",
  "Articles",
  "Doctors",
  "Hospitals"
];

List<IconData> listIcons = [
  Icons.camera_alt_outlined,
  Icons.calendar_month_outlined,
  Icons.question_answer_outlined,
  Icons.newspaper_outlined,
  Icons.medical_services_outlined,
  Icons.factory_outlined
];

List<Widget> screens = [
  const DetectScreen(),
  AppointmentsScreen(),
  const CommunityScreen(),
  const ArticlesScreen(),
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
                      )
                  ],
                )
              ])),
        ));
  }
}
