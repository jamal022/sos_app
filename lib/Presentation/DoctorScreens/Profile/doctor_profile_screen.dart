import 'package:flutter/material.dart';
import '../../../Data/Models/doctor.dart';
import '../../Constants/app_assets.dart';
import '../../Styles/colors.dart';
import '../../Styles/fonts.dart';
import 'doctor_edit_screen.dart';

class DoctorProfileScreen extends StatefulWidget {
  Doctor? doctor;
  DoctorProfileScreen({Key? key, @required this.doctor}) : super(key: key);

  @override
  State<DoctorProfileScreen> createState() => _DoctorProfileScreen();
}

class _DoctorProfileScreen extends State<DoctorProfileScreen> {
  final maxLines = 5;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: back,
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 30),
        child: Column(children: [
          Stack(alignment: AlignmentDirectional.topStart, children: <Widget>[
            Container(
              width: size.width / 3,
              height: size.height / 5,
              margin: const EdgeInsets.fromLTRB(200, 55, 0, 0),
              child: Column(
                children: [
                  const Flexible(
                    child: Text("Doctor Name",
                        style: TextStyle(
                          color: black,
                          fontSize: contentFont,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  const Flexible(
                    child: Text("Field",
                        style: TextStyle(
                          color: Color.fromARGB(255, 88, 82, 82),
                          fontSize: contentFont,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  const Spacer(),
                  Flexible(
                    child: SizedBox(
                      height: size.height / 10,
                      width: size.width / 2,
                      child: MaterialButton(
                          elevation: 4.0,
                          color: Colors.white,
                          shape: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DoctorEditScreen(
                                        doctor: widget.doctor,
                                      )),
                              (Route<dynamic> route) => false,
                            );
                          },
                          child: const Text(
                            'Edit Profile',
                            style: TextStyle(
                              color: black,
                              fontSize: contentFont,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              height: size.height / 6,
              width: size.width / 3,
              alignment: Alignment.center,
              padding: const EdgeInsets.all(2.0),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(160.0)),
                color: Color.fromARGB(255, 255, 255, 255),
              ),
              margin: const EdgeInsets.fromLTRB(8.0, 50.0, 10.0, 30.0),
              child: const CircleAvatar(
                backgroundImage: AssetImage(sosLogoImage),
                backgroundColor: Color.fromARGB(255, 255, 255, 255),
                radius: 120,
              ),
            ),
          ]),
          Container(
              width: size.width / 0.7,
              color: const Color.fromARGB(239, 217, 225, 240),
              height: size.height / 5.4,
              child: Column(children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    child: Row(
                      children: const <Widget>[
                        Icon(
                          Icons.mode_edit_outline_sharp,
                          color: Colors.black,
                        ),
                        Center(
                          child: Text(
                            'Brief description about the doctor...',
                            style: TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    )),
              ])),
          const SizedBox(height: 100),
          Stack(
            children: [
              Flexible(
                child: MaterialButton(
                    elevation: 6.0,
                    color: Colors.white,
                    shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    onPressed: () {},
                    child: const Text(
                      '              Q/A  History                 ',
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
              Flexible(
                child: MaterialButton(
                    elevation: 6.0,
                    color: Colors.white,
                    shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    onPressed: () {},
                    child: const Text(
                      '            Article  History                 ',
                      style: TextStyle(
                        color: black,
                        fontSize: formButtonFont,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
              )
            ],
          ),
        ]),
      ),
    );
  }
}
