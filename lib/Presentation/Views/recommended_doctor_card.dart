import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:sos_app/Presentation/PatientScreens/Home/Doctors/doctor_page_screen.dart';
import '../../Data/Models/doctor.dart';
import '../Styles/colors.dart';

class RecommendedDoctorCard extends StatefulWidget {
  Doctor doctor;
  RecommendedDoctorCard({super.key, required this.doctor});

  @override
  State<RecommendedDoctorCard> createState() => _RecommendedDoctorCardState();
}

class _RecommendedDoctorCardState extends State<RecommendedDoctorCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: ListTile(
          leading: Container(
            height: 100,
            width: 100,
            child: Image.network(
              widget.doctor.image,
              fit: BoxFit.fill,
            ),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DoctorPageScreen(
                        doctor: widget.doctor,
                      )),
            );
          },
          title: Column(
            children: [
              Text(
                widget.doctor.username,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                ), //Textstyle
              ), //Text
              const SizedBox(
                height: 5,
              ), //SizedBox
              Text(
                widget.doctor.field,
                style: const TextStyle(
                  fontSize: 17,
                  color: Color.fromARGB(255, 90, 84, 84),
                ), //Textstyle
              ), //Text
              const SizedBox(
                height: 5,
              ),
              RatingBar(
                ignoreGestures: true,
                initialRating: double.parse(widget.doctor.rate),
                itemSize: 20,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                tapOnlyMode: true,
                ratingWidget: RatingWidget(
                    full: const Icon(Icons.star, color: primaryColor),
                    half: const Icon(
                      Icons.star_half,
                      color: primaryColor,
                    ),
                    empty: const Icon(
                      Icons.star_outline,
                      color: primaryColor,
                    )),
                onRatingUpdate: ((value) {}),
              )
            ],
          ),
        ));
  }
}
