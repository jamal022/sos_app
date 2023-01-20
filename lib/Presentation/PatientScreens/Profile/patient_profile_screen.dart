import 'package:flutter/material.dart';
import 'package:sos_app/Presentation/Constants/app_assets.dart';
import 'package:sos_app/Presentation/PatientScreens/Profile/patient_edit_screen.dart';
import '../../Styles/colors.dart';
import '../../Styles/fonts.dart';

class PatientProfileScreen extends StatefulWidget {
  final patient;
  const PatientProfileScreen({Key? key, @required this.patient})
      : super(key: key);

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
                          widget.patient.image,
                        ),
                      )),
                  Stack(
                    children: [
                      Expanded(
                        child: Text(widget.patient.username,
                            style: const TextStyle(
                              color: black,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            )),
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  Stack(
                    children: [
                      Expanded(
                          child: Text(
                        widget.patient.email,
                        style: const TextStyle(
                          color: black,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ))
                    ],
                  ),
                  const SizedBox(height: 10),
                  Stack(
                    children: [
                      Expanded(
                        child: MaterialButton(
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
                                    builder: (context) =>
                                        const PatientEditScreen()),
                              );
                            },
                            child: const Text(
                              'Edit Profile',
                              style: TextStyle(
                                color: black,
                                fontSize: formButtonFont,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                      )
                    ],
                  ),
                  const SizedBox(height: 50),
                  Stack(
                    children: [
                      Expanded(
                        child: MaterialButton(
                            elevation: 6.0,
                            color: Colors.white,
                            shape: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none,
                            ),
                            onPressed: () {},
                            child: const Text(
                              '                Q/A History                  ',
                              style: TextStyle(
                                color: black,
                                fontSize: formButtonFont,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Stack(
                    children: [
                      Expanded(
                        child: MaterialButton(
                            elevation: 6.0,
                            color: Colors.white,
                            shape: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none,
                            ),
                            onPressed: () {},
                            child: const Text(
                              '                Burn Reports                 ',
                              style: TextStyle(
                                color: black,
                                fontSize: formButtonFont,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                      )
                    ],
                  ),
                ])),
          ),
        ));
  }
}
