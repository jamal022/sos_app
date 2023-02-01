import 'package:flutter/material.dart';
import '../../../Data/Authentication/login.dart';
import '../../../Data/Models/doctor.dart';
import '../../Styles/colors.dart';
import '../../Styles/fonts.dart';
import 'doctor_edit_screen.dart';

class DoctorProfileScreen extends StatefulWidget {
  final doctor;
  const DoctorProfileScreen({Key? key, @required this.doctor})
      : super(key: key);

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
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 30),
            child: Column(children: [
              Stack(alignment: AlignmentDirectional.topStart, children: <
                  Widget>[
                Container(
                  width: size.width / 3,
                  height: size.height / 5,
                  margin: const EdgeInsets.fromLTRB(200, 55, 0, 0),
                  child: Column(
                    children: [
                      Expanded(
                        child: Text(widget.doctor.username,
                            style: const TextStyle(
                              color: black,
                              fontSize: contentFont,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                      Expanded(
                        child: Text(widget.doctor.field,
                            style: const TextStyle(
                              color: Color.fromARGB(255, 88, 82, 82),
                              fontSize: contentFont,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                      Expanded(
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
                    width: size.width / 2.1,
                    height: size.height / 5,
                    decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(100, 46, 47, 51),
                          offset: Offset(
                            3.0,
                            3.0,
                          ),
                          blurRadius: 10.0,
                          spreadRadius: 2.0,
                        ),
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(140.0)),
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                    margin: const EdgeInsets.fromLTRB(8.0, 50.0, 10.0, 30.0),
                    child: Image.network(
                      widget.doctor.image,
                      width: size.width / 2.5,
                      height: size.height / 5,
                    )),
              ]),
              Container(
                  width: size.width / 0.7,
                  color: const Color.fromARGB(239, 217, 225, 240),
                  height: size.height / 5.4,
                  child: Column(children: const <Widget>[
                    TextField(
                      maxLines: 6,
                      minLines: 1,
                      decoration: InputDecoration(
                          hintText: "Brief description about the doctor...",
                          hintStyle: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                          border: InputBorder.none,
                          icon: Icon(
                            Icons.mode_edit_outline_sharp,
                            color: Colors.black,
                          )),
                      autofocus: true,
                      keyboardType: TextInputType.multiline,
                    ),
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
        ));
  }
}
