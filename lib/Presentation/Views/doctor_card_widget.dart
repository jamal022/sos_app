import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:sos_app/Presentation/PatientScreens/Home/Doctors/doctor_page_screen.dart';
import '../../Data/Models/doctor.dart';
import '../Styles/colors.dart';

class DoctorCardWidget extends StatelessWidget {
  Doctor doctor;
  DoctorCardWidget({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      child: Card(
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DoctorPageScreen(
                      doctor: doctor,
                    ),
                  ));
            },
            child: Column(children: [
              Container(
                padding: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 0.0),
                child: Image.network(
                  doctor.image,
                  height: size.height / 9,
                  width: size.width / 1.5,
                  fit: BoxFit.fill,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    doctor.username,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ), //Textstyle
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  doctor.verified == 1
                      ? Icon(
                          Icons.verified,
                          color: Colors.lightBlueAccent.shade700,
                        )
                      : Icon(
                          Icons.do_not_disturb_alt_sharp,
                          color: Colors.redAccent.shade700,
                        )
                ],
              ), //Text
              const SizedBox(
                height: 5,
              ), //SizedBox
              Text(
                doctor.field,
                style: const TextStyle(
                  fontSize: 16,
                  color: Color.fromARGB(255, 90, 84, 84),
                ), //Textstyle
              ), //Text
              const SizedBox(
                height: 10,
              ),
              RatingBar(
                  //initialRating: 0,
                  direction: Axis.horizontal,
                  itemSize: 25.0,
                  allowHalfRating: true,
                  itemCount: 5,
                  ratingWidget: RatingWidget(
                      full: const Icon(
                        Icons.star,
                        color: primaryColor,
                      ),
                      half: const Icon(
                        Icons.star_half,
                        color: primaryColor,
                      ),
                      empty: const Icon(
                        Icons.star_outline,
                        color: primaryColor,
                      )),
                  onRatingUpdate: (value) {}),
            ]),
          ),
        ),
      ),
    );
  }
}
