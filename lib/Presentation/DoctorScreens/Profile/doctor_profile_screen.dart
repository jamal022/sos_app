import 'package:flutter/material.dart';
import 'package:sos_app/Presentation/DoctorScreens/Profile/articles_history_screen.dart';
import 'package:sos_app/Presentation/DoctorScreens/Profile/community_history_screen.dart';
import '../../../Data/Models/doctor.dart';
import '../../Styles/colors.dart';
import '../../Styles/fonts.dart';
import 'doctor_edit_screen.dart';

class DoctorProfileScreen extends StatefulWidget {
  Doctor? doctor;
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
        padding: const EdgeInsets.fromLTRB(10.0, 40.0, 10.0, 0.0),
        child: Column(children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                child: CircleAvatar(
                    backgroundImage: NetworkImage(
                      widget.doctor!.image,
                    ),
                    maxRadius: 80,
                    backgroundColor: primaryColor),
              ),
              Container(
                width: 200,
                height: 200,
                margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Column(
                  children: [
                    Text(
                      '\n${widget.doctor!.username}\n',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget.doctor!.field,
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(
                      height: 14,
                    ),
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
                              builder: (context) => DoctorEditScreen(
                                    doctor: widget.doctor!,
                                  )),
                        );
                      },
                      child: const Text(
                        'Edit Profile',
                        style: TextStyle(
                          color: black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white60,
                ),
                width: size.width / 0.7,
                height: size.height / 5.4,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child: Text(
                    widget.doctor!.bio,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                )),
          ),
          const SizedBox(height: 80),
          Column(
            children: [
              SizedBox(
                height: size.height / 17,
                width: size.width / 1.3,
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
                            builder: (context) => CommunityHistoryScreen()),
                      );
                    },
                    child: const Text(
                      'Q/A  History',
                      style: TextStyle(
                        color: black,
                        fontSize: formButtonFont,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: size.height / 17,
                width: size.width / 1.3,
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
                            builder: (context) => ArticlesHistoryScreen(
                                  doctor: widget.doctor!,
                                )),
                      );
                    },
                    child: const Text(
                      'Articles  History',
                      style: TextStyle(
                        color: black,
                        fontSize: formButtonFont,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
