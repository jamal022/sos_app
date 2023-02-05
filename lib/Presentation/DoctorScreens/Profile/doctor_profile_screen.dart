import 'package:flutter/material.dart';
import '../../../Data/Models/doctor.dart';
import '../../Constants/app_assets.dart';
import '../../Styles/colors.dart';
import '../../Styles/fonts.dart';
import 'doctor_edit_screen.dart';

class DoctorProfileScreen extends StatefulWidget {
  Doctor doctor;
  DoctorProfileScreen({Key? key, required this.doctor}) : super(key: key);

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
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 30),
        child: Column(children: [
          Stack(alignment: AlignmentDirectional.topStart, children: <Widget>[
            Container(
              width: size.width / 3,
              height: size.height / 5,
              margin: const EdgeInsets.fromLTRB(200, 55, 0, 0),
              child: Column(
                children: [
                  Flexible(
                    child: Text(widget.doctor.username,
                        style: const TextStyle(
                          color: black,
                          fontSize: contentFont,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Flexible(
                    child: Text(widget.doctor.field,
                        style: const TextStyle(
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DoctorEditScreen(
                                        doctor: widget.doctor,
                                      )),
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
              child: CircleAvatar(
                backgroundImage: NetworkImage(widget.doctor.image),
                backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                radius: 120,
              ),
            ),
          ]),
          const SizedBox(
            height: 30,
          ),
          Container(
              width: size.width / 0.7,
              color: const Color.fromARGB(239, 217, 225, 240),
              height: size.height / 5.4,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  widget.doctor.bio,
                  style: const TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              )),
          const SizedBox(height: 80),
          Column(
            children: [
              MaterialButton(
                  elevation: 6.0,
                  color: Colors.white,
                  shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  onPressed: () {},
                  child: const Text(
                    '               Q/A  History               ',
                    style: TextStyle(
                      color: black,
                      fontSize: formButtonFont,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
              const SizedBox(
                height: 10,
              ),
              MaterialButton(
                  elevation: 6.0,
                  color: Colors.white,
                  shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  onPressed: () {},
                  child: const Text(
                    '              Article  History                 ',
                    style: TextStyle(
                      color: black,
                      fontSize: formButtonFont,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
            ],
          ),
        ]),
      ),
    );
  }
}
