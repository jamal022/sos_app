import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sos_app/Presentation/PatientScreens/Profile/BurnReports/burn_reports_screen.dart';
import 'package:sos_app/Presentation/PatientScreens/Profile/patient_edit_screen.dart';
import '../../../Data/Models/ReportModel.dart';
import '../../../Data/Models/patient.dart';
import '../../Styles/colors.dart';
import '../../Styles/fonts.dart';

class PatientProfileScreen extends StatefulWidget {
  Patient? patient;
  PatientProfileScreen({Key? key, required this.patient}) : super(key: key);

  @override
  State<PatientProfileScreen> createState() => _PatientProfileScreen();
}

class _PatientProfileScreen extends State<PatientProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: back,
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 50, horizontal: 30),
                child: Column(children: <Widget>[
                  Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(140.0)),
                        border: Border.all(
                          color: primaryColor,
                          width: size.width / 30,
                        ),
                        color: const Color.fromARGB(255, 255, 255, 255),
                      ),
                      padding: const EdgeInsets.all(0.0),
                      margin: const EdgeInsets.fromLTRB(50.0, 40.0, 50.0, 30.0),
                      child: CircleAvatar(
                        maxRadius: 100,
                        backgroundImage: NetworkImage(
                          widget.patient!.image,
                        ),
                      )),
                  Text(widget.patient!.username,
                      style: const TextStyle(
                        color: black,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      )),
                  SizedBox(height: size.height / 50),
                  Text(
                    widget.patient!.email,
                    style: const TextStyle(
                      color: black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: size.height / 50),
                  MaterialButton(
                    elevation: 4.0,
                    color: Colors.white,
                    shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PatientEditScreen(
                                  patient: widget.patient!,
                                )),
                      );
                    },
                    child: const Text(
                      'Edit Profile',
                      style: TextStyle(
                        color: black,
                        fontSize: formButtonFont,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: size.height / 15),
                  Container(
                    width: size.width / 1.2,
                    height: size.height / 18,
                    child: MaterialButton(
                        elevation: 6.0,
                        color: Colors.white,
                        shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        onPressed: () {},
                        child: const Text(
                          'Q/A History',
                          style: TextStyle(
                            color: black,
                            fontSize: formButtonFont,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                  ),
                  SizedBox(
                    height: size.height / 35,
                  ),
                  Container(
                    width: size.width / 1.2,
                    height: size.height / 18,
                    child: MaterialButton(
                      elevation: 6.0,
                      color: Colors.white,
                      shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      onPressed: () async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BurnReportsScreen(
                                patient: widget.patient!,
                              ),
                            ));
                      },
                      child: const Text(
                        'Burn Reports',
                        style: TextStyle(
                          color: black,
                          fontSize: formButtonFont,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ])),
          ),
        ));
  }
}
