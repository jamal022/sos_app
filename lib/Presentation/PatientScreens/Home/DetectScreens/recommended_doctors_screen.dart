import 'package:flutter/material.dart';
import 'package:sos_app/Presentation/Views/recommended_doctor_card.dart';
import '../../../../Data/Models/doctor.dart';
import '../../../Styles/colors.dart';

class RecommendedDoctorsScreen extends StatefulWidget {
  List<Doctor> doctors;
  RecommendedDoctorsScreen({Key? key, required this.doctors}) : super(key: key);

  @override
  State<RecommendedDoctorsScreen> createState() =>
      _RecommendedDoctorsScreenState();
}

class _RecommendedDoctorsScreenState extends State<RecommendedDoctorsScreen> {
  int currentIndex = 0;
  double? _ratingValue;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: const Color.fromARGB(253, 243, 222, 195),
        appBar: AppBar(
          title: const Text(
            "\t\tRecommeded Doctors",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
          ),
          centerTitle: true,
          toolbarHeight: 60.2,
          elevation: 4,
          backgroundColor: primaryColor,
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                image: AssetImage("assets/images/R.jpg"),
                fit: BoxFit.fill,
              )),
              height: 310,
            ),
            Container(
              height: 313,
              color: Color.fromARGB(253, 243, 222, 195),
              //width: MediaQuery.of(context).size.width * 0.65,

              child: Column(children: <Widget>[
                Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.all(11),
                          child: Column(
                            children: [
                              for (var doctor in widget.doctors)
                                RecommendedDoctorCard(doctor: doctor)
                            ],
                          ))
                    ])
              ]),
            )
          ]),
        ));
  }
}
