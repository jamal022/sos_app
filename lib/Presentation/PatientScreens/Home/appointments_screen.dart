import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:sos_app/Presentation/Constants/app_assets.dart';
import '../../Styles/colors.dart';
import '../../Styles/fonts.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class AppointmentsScreen extends StatefulWidget {
  AppointmentsScreen({Key? key}) : super(key: key);

  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

SliverAppBar showSliverAppBar(String screenTitle) {
  return SliverAppBar(
    backgroundColor: primaryColor,
    floating: true,
    pinned: true,
    snap: false,
    title: Text(screenTitle),
    bottom: const TabBar(
      tabs: [
        Tab(
          text: 'In Progress',
        ),
        Tab(
          text: 'Ended',
        )
      ],
    ),
  );
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: DefaultTabController(
      length: 2,
      child: TabBarView(children: [
        CustomScrollView(
          slivers: [
            showSliverAppBar('My Appointments'),
            SliverList(
              delegate: SliverChildListDelegate([
                Container(
                  height: 1500,
                  color: back,
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        height: 140,
                        padding: const EdgeInsets.fromLTRB(20.0, 8.0, 0.0, 0.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Row(children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Doctor Name',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              Text('Ganna Shaker',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 16,
                                      color: Colors.black.withOpacity(0.5))),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    ' \n\n  Price',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  Text('450 EGP',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 16,
                                          color:
                                              Colors.black.withOpacity(0.5))),
                                ],
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    '     Date   ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  Text('    2/2/2023',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 16,
                                          color:
                                              Colors.black.withOpacity(0.5))),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    ' \n\n       Place              ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  Text('    Dokki ,Cairo       ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 16,
                                          color:
                                              Colors.black.withOpacity(0.5))),
                                ],
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Time',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              Text('01:00 PM\n\n',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 16,
                                      color: Colors.black.withOpacity(0.5))),
                              Container(
                                padding: const EdgeInsets.fromLTRB(
                                    0.0, 0.0, 0.0, 5.0),
                                child: MaterialButton(
                                    elevation: 5.0,
                                    color: Colors.red,
                                    padding: const EdgeInsets.all(10),
                                    shape: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25),
                                      borderSide: BorderSide.none,
                                    ),
                                    onPressed: () {},
                                    child: const Text(
                                      '  Cancel  ',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )),
                              ),
                            ],
                          ),
                        ]),
                      ),
                    ),
                  ]),
                ),
              ]),
            ),
          ],
        ),
        CustomScrollView(
          slivers: [
            showSliverAppBar('My Appointments'),
            SliverList(
              delegate: SliverChildListDelegate([
                Container(
                  height: 1500,
                  color: back,
                  child: Column(children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        height: 140,
                        padding: const EdgeInsets.fromLTRB(20.0, 8.0, 0.0, 0.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Row(children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Doctor Name',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              Text('Ganna Shaker',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 16,
                                      color: Colors.black.withOpacity(0.5))),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    ' \n\n  Price',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  Text('450 EGP',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 16,
                                          color:
                                              Colors.black.withOpacity(0.5))),
                                ],
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    '     Date   ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  Text('    2/2/2023',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 16,
                                          color:
                                              Colors.black.withOpacity(0.5))),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    ' \n\n       Place              ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  Text('    Dokki ,Cairo       ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 16,
                                          color:
                                              Colors.black.withOpacity(0.5))),
                                ],
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Time',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              Text('01:00 PM\n\n',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 16,
                                      color: Colors.black.withOpacity(0.5))),
                              Container(
                                padding: const EdgeInsets.fromLTRB(
                                    0.0, 0.0, 0.0, 5.0),
                                child: MaterialButton(
                                    elevation: 5.0,
                                    color: primaryColor,
                                    padding: const EdgeInsets.all(10),
                                    shape: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25),
                                      borderSide: BorderSide.none,
                                    ),
                                    onPressed: () {},
                                    child: const Text(
                                      '   Rate   ',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )),
                              ),
                            ],
                          ),
                        ]),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        height: 140,
                        padding: const EdgeInsets.fromLTRB(20.0, 8.0, 0.0, 0.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Row(children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Doctor Name',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              Text('Ganna Shaker',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 16,
                                      color: Colors.black.withOpacity(0.5))),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    ' \n\n  Price',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  Text('450 EGP',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 16,
                                          color:
                                              Colors.black.withOpacity(0.5))),
                                ],
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    '     Date   ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  Text('    2/2/2023',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 16,
                                          color:
                                              Colors.black.withOpacity(0.5))),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    ' \n\n       Place        ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  Text('    Dokki ,Cairo       ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w800,
                                          fontSize: 16,
                                          color:
                                              Colors.black.withOpacity(0.5))),
                                ],
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Time',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              Text('01:00 PM\n\n',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 16,
                                      color: Colors.black.withOpacity(0.5))),
                              Container(
                                padding: const EdgeInsets.fromLTRB(
                                    0.0, 0.0, 0.0, 5.0),
                                child: Column(
                                  children: [
                                    const Text(
                                      'Rate',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                    RatingBar(
                                        initialRating: 0,
                                        itemSize: 22,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
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
                                          setState(() {});
                                        }),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ]),
                      ),
                    ),
                  ]),
                ),
              ]),
            ),
          ],
        )
      ]),
    ));
  }
}
