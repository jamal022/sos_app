import 'dart:ui';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:sos_app/Presentation/Constants/app_assets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../Styles/colors.dart';

class RecommendedDoctorsScreen extends StatefulWidget {
  RecommendedDoctorsScreen({Key? key}) : super(key: key);

  @override
  State<RecommendedDoctorsScreen> createState() =>
      _RecommendedDoctorsScreenState();
}

class _RecommendedDoctorsScreenState extends State<RecommendedDoctorsScreen> {
  int currentIndex = 0;
  double? _ratingValue;

  var _bottomNavigationKey;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: const Color.fromARGB(253, 243, 222, 195),
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.keyboard_return_sharp),
            tooltip: 'Return Back Icon',
            onPressed: () {},
          ),
          title: const Text(
            "\t\tRecommeded Doctors",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
          ),
          centerTitle: true,
          toolbarHeight: 60.2,
          elevation: 4,
          backgroundColor: primaryColor,
        ),
        body: Column(children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage("assets/images/R.jpeg"),
              fit: BoxFit.fill,
            )),
            height: 310,
          ),
          Container(
            height: 313,
            color: Color.fromARGB(253, 243, 222, 195),
            //width: MediaQuery.of(context).size.width * 0.65,

            child: Column(children: <Widget>[
              Column(mainAxisAlignment: MainAxisAlignment.center, children: <
                  Widget>[
                Padding(
                    padding: EdgeInsets.all(11),
                    child: Column(
                      children: [
                        Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: ListTile(
                              leading: Image.asset(
                                'assets/images/dr.jpeg',
                              ),
                              onTap: () {},
                              title: Column(
                                children: [
                                  Text(
                                    'Doctor name',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ), //Textstyle
                                  ), //Text
                                  const SizedBox(
                                    height: 5,
                                  ), //SizedBox
                                  const Text(
                                    'Field',
                                    style: TextStyle(
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
                                      itemCount: 5,
                                      itemSize: 30,
                                      ratingWidget: RatingWidget(
                                          full: const Icon(Icons.star,
                                              color: primaryColor),
                                          half: const Icon(
                                            Icons.star_half,
                                            color: primaryColor,
                                          ),
                                          empty: const Icon(
                                            Icons.star_outline,
                                            color: primaryColor,
                                          )),
                                      onRatingUpdate: (value) {
                                        setState(() {
                                          _ratingValue = value;
                                        });
                                      }),
                                ],
                              ),
                            )),
                        Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: ListTile(
                              leading: Image.asset(
                                'assets/images/dr.jpeg',
                              ),
                              onTap: () {},
                              title: Column(
                                children: [
                                  Text(
                                    'Doctor name',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ), //Textstyle
                                  ), //Text
                                  const SizedBox(
                                    height: 5,
                                  ), //SizedBox
                                  const Text(
                                    'Field',
                                    style: TextStyle(
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
                                      itemCount: 5,
                                      itemSize: 30,
                                      ratingWidget: RatingWidget(
                                          full: const Icon(Icons.star,
                                              color: primaryColor),
                                          half: const Icon(
                                            Icons.star_half,
                                            color: primaryColor,
                                          ),
                                          empty: const Icon(
                                            Icons.star_outline,
                                            color: primaryColor,
                                          )),
                                      onRatingUpdate: (value) {
                                        setState(() {
                                          _ratingValue = value;
                                        });
                                      }),
                                ],
                              ),
                            )),
                        Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: ListTile(
                              leading: Image.asset(
                                'assets/images/R.jpeg',
                              ),
                              onTap: () {},
                              title: Column(
                                children: [
                                  Text(
                                    'Doctor name',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ), //Textstyle
                                  ), //Text
                                  const SizedBox(
                                    height: 5,
                                  ), //SizedBox
                                  const Text(
                                    'Field',
                                    style: TextStyle(
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
                                      itemCount: 5,
                                      itemSize: 30,
                                      ratingWidget: RatingWidget(
                                          full: const Icon(Icons.star,
                                              color: primaryColor),
                                          half: const Icon(
                                            Icons.star_half,
                                            color: primaryColor,
                                          ),
                                          empty: const Icon(
                                            Icons.star_outline,
                                            color: primaryColor,
                                          )),
                                      onRatingUpdate: (value) {
                                        setState(() {
                                          _ratingValue = value;
                                        });
                                      }),
                                ],
                              ),
                            )),
                      ],
                    ))
              ])
            ]),
          )
        ]));
  }
}
