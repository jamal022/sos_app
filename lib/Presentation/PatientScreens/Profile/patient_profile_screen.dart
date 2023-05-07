import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sos_app/Presentation/PatientScreens/Profile/BurnReports/burn_reports_screen.dart';
import 'package:sos_app/Presentation/PatientScreens/Profile/community_history_screen.dart';
import 'package:sos_app/Presentation/PatientScreens/Profile/patient_edit_screen.dart';
import '../../../Data/Models/patient.dart';
import '../../Styles/colors.dart';
import '../../Styles/fonts.dart';

class PatientProfileScreen extends StatefulWidget {
  PatientProfileScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<PatientProfileScreen> createState() => _PatientProfileScreen();
}

class _PatientProfileScreen extends State<PatientProfileScreen> {
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
  var rate;
  var verified;
  Patient patient = Patient();

  _getPrefs() async {
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

    setState(() {
      patient = Patient(
          id: id,
          username: name,
          email: email,
          phoneNumber: phone,
          password: password,
          age: age,
          gender: gender,
          image: image);
    });
  }

  @override
  void initState() {
    super.initState();
    _getPrefs();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: back,
        body: SingleChildScrollView(
          child: patient.username != null
              ? Center(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 50, horizontal: 30),
                      child: Column(children: <Widget>[
                        Container(
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(140.0)),
                              border: Border.all(
                                color: primaryColor,
                                width: size.width / 35,
                              ),
                            ),
                            child: CircleAvatar(
                              maxRadius: 80,
                              backgroundImage: NetworkImage(
                                patient.image,
                              ),
                            )),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(patient.username,
                            style: const TextStyle(
                              color: black,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            )),
                        SizedBox(height: size.height / 50),
                        Text(
                          patient.email,
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
                          onPressed: () async {
                            var result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PatientEditScreen(
                                        patient: patient,
                                      )),
                            );
                            if (result == "refresh") {
                              _getPrefs();
                            }
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
                        SizedBox(height: size.height / 6),
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
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          CommunityHistoryScreen(),
                                    ));
                              },
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
                                      patient: patient,
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
                )
              : Center(),
        ));
  }
}
