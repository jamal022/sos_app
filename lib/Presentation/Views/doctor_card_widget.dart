import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../Styles/colors.dart';

class DoctorCardWidget extends StatelessWidget {
  final name;
  final field;
  final image;
  DoctorCardWidget(
      {super.key,
      @required this.field,
      @required this.name,
      @required this.image});

  double? _ratingValue;

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {},
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                    child: Image.network(
                      image,
                      height: 90,
                      width: 90,
                      fit: BoxFit.fitWidth,
                    ),
                  ),

                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    name,
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
                    field,
                    style: const TextStyle(
                      fontSize: 17,
                      color: Color.fromARGB(255, 90, 84, 84),
                    ), //Textstyle
                  ), //Text
                  const SizedBox(
                    height: 5,
                  ),

                  RatingBar(
                      initialRating: 0,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 4,
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
                      onRatingUpdate: (value) {}),
                ]),
          ),
        ));
  }
}

// Card(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(20.0),
//                   ),
//                   child: InkWell(
//                     onTap: () {},
//                     child: Column(children: [
//                       Image.asset(
//                         'assets/images/logo.png',
//                         height: 70,
//                         width: 70,
//                       ),

//                       const SizedBox(
//                         height: 5,
//                       ),
//                       Text(
//                         'Doctor name',
//                         style: TextStyle(
//                           fontSize: 18,
//                           color: Colors.black,
//                           fontWeight: FontWeight.w500,
//                         ), //Textstyle
//                       ), //Text
//                       const SizedBox(
//                         height: 5,
//                       ), //SizedBox
//                       const Text(
//                         'Field',
//                         style: TextStyle(
//                           fontSize: 17,
//                           color: Color.fromARGB(255, 90, 84, 84),
//                         ), //Textstyle
//                       ), //Text
//                       const SizedBox(
//                         height: 5,
//                       ),

//                       RatingBar(
//                           initialRating: 0,
//                           direction: Axis.horizontal,
//                           allowHalfRating: true,
//                           itemCount: 4,
//                           ratingWidget: RatingWidget(
//                               full: const Icon(Icons.star, color: primaryColor),
//                               half: const Icon(
//                                 Icons.star_half,
//                                 color: primaryColor,
//                               ),
//                               empty: const Icon(
//                                 Icons.star_outline,
//                                 color: primaryColor,
//                               )),
//                           onRatingUpdate: (value) {
//                             setState(() {
//                               _ratingValue = value;
//                             });
//                           }),
//                     ]),
//                   )),