import 'package:flutter/material.dart';
import 'package:sos_app/Presentation/PatientScreens/Home/DetectScreens/recommended_doctors_screen.dart';
import 'package:sos_app/Presentation/Styles/colors.dart';

import '../../../../Data/Models/ReportModel.dart';
import '../../../Constants/app_assets.dart';
import '../../../Screens/App_Layout/bottom_nav_bar.dart';
import '../../../Screens/Chats/chats_screen.dart';
import '../../../Screens/Notifications/notifications_screen.dart';
import '../../../Screens/Settings/settings_screen.dart';
import '../../../Styles/fonts.dart';
import '../../Profile/patient_profile_screen.dart';
import '../patient_home_screen.dart';

class ReportScreen extends StatefulWidget {
  Report report;

  ReportScreen({Key? key, required this.report}) : super(key: key);

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: back,
        appBar: AppBar(
          backgroundColor: primaryColor,
          elevation: 0,
          centerTitle: true,
          toolbarHeight: 64.5,
          title: const Text('Report',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            Container(
              margin: const EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 10.0),
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Column(children: <Widget>[
                const SizedBox(height: 10),
                Container(
                    margin: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 5.0),
                    child: Center(
                      child: Padding(
                          padding: const EdgeInsets.all(10.5),
                          child: Image.network(
                            widget.report.image,
                            width: size.width / 2,
                            height: size.height / 4,
                          )),
                    )),
                Container(
                    margin: const EdgeInsets.all(20),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          const SizedBox(height: 10),
                          //Degree of burn
                          Row(children: <Widget>[
                            const Text('Degree of burn:',
                                style: TextStyle(
                                    fontSize: fontfonty,
                                    fontWeight: FontWeight.bold)),
                            Text("   ${widget.report.burnDegree}",
                                style: const TextStyle(
                                    fontSize: fontfonty,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey)),
                          ]),
                          const SizedBox(height: 10),
                          //Patient Name
                          Row(children: <Widget>[
                            const Text('Patient Name:',
                                style: TextStyle(fontSize: fontfonty)),
                            Text("   ${widget.report.name}",
                                style: const TextStyle(
                                    fontSize: fontfonty, color: Colors.grey)),
                          ]),
                          const SizedBox(height: 10),
                          //Age
                          Row(children: <Widget>[
                            const Text('Age:',
                                style: TextStyle(fontSize: fontfonty)),
                            Text("   ${widget.report.age}",
                                style: const TextStyle(
                                    fontSize: fontfonty, color: Colors.grey)),
                          ]),
                          const SizedBox(height: 10),
                          //Gender
                          Row(children: <Widget>[
                            const Text('Gender:',
                                style: TextStyle(fontSize: fontfonty)),
                            Text("   ${widget.report.gender}",
                                style: const TextStyle(
                                    fontSize: fontfonty, color: Colors.grey)),
                          ]),
                          const SizedBox(height: 10),
                          //Phone Number
                          Row(children: <Widget>[
                            const Text('Phone Number:',
                                style: TextStyle(fontSize: fontfonty)),
                            Text("   ${widget.report.phoneNumber}",
                                style: const TextStyle(
                                    fontSize: fontfonty, color: Colors.grey)),
                          ]),
                          const SizedBox(height: 10),

                          //Diabetes
                          Row(children: <Widget>[
                            const Text('Diabetes:',
                                style: TextStyle(fontSize: fontfonty)),
                            Text("   ${widget.report.diabates}",
                                style: const TextStyle(
                                    fontSize: fontfonty, color: Colors.grey)),
                          ]),
                          const SizedBox(height: 10),
                          //Blood Pressure
                          Row(children: <Widget>[
                            const Text('Blood Pressure:',
                                style: TextStyle(fontSize: fontfonty)),
                            Text("   ${widget.report.pressure}",
                                style: const TextStyle(
                                    fontSize: fontfonty, color: Colors.grey)),
                          ]),
                          const SizedBox(height: 10),
                          //Cause of burn
                          Row(children: const <Widget>[
                            Text('Cause of burn:',
                                style: TextStyle(fontSize: fontfonty)),
                          ]),
                          Text("   ${widget.report.causeOfBurn}",
                              style: const TextStyle(
                                  fontSize: fontfonty, color: Colors.grey)),
                          const SizedBox(height: 10),
                          //First aid
                          Row(children: const <Widget>[
                            Text('First aid:',
                                style: TextStyle(fontSize: fontfonty)),
                          ]),

                          const Text('Bla Bla Bla',
                              style: TextStyle(
                                  fontSize: fontfonty, color: Colors.grey)),
                        ])),
                const SizedBox(height: 20),
              ]),
            ),
            Container(
                margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: Row(children: <Widget>[
                  ElevatedButton.icon(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(primaryColor),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ))),
                      onPressed: () {},
                      icon: const Icon(Icons.download, color: white, size: 30),
                      label: const Text('Save',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                          ))),
                  const Spacer(),
                  ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(primaryColor),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ))),
                      onPressed: () {
                        List<Widget> patientScreens = [
                          const SettingScreen(),
                          ChatsScreen(),
                          const PatientHomeScreen(),
                          NotificationsScreen(),
                          PatientProfileScreen(),
                        ];
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BottomNavBar(
                                    screens: patientScreens,
                                  )),
                          (Route<dynamic> route) => false,
                        );
                      },
                      child: const Text(
                        'Back to Home',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                ])),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(primaryColor),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ))),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RecommendedDoctorsScreen()),
                  );
                },
                child: const Text(
                  'View Recommended Doctors',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                )),
            const SizedBox(
              height: 10,
            ),
          ]),
        ));
  }
}
