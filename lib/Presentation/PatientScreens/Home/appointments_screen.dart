import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sos_app/Data/Models/ScheduleModel.dart';
import 'package:sos_app/Presentation/Constants/app_assets.dart';
import 'package:sos_app/Presentation/PatientScreens/Home/patient_home_screen.dart';
import '../../../Data/Models/AppointmentModel.dart';
import '../../../Data/Models/patient.dart';
import '../../Screens/App_Layout/bottom_nav_bar.dart';
import '../../Screens/Chats/chats_screen.dart';
import '../../Screens/Notifications/notifications_screen.dart';
import '../../Screens/Settings/settings_screen.dart';
import '../../Styles/colors.dart';
import '../../Styles/fonts.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../Profile/patient_profile_screen.dart';

class AppointmentsScreen extends StatefulWidget {
  AppointmentsScreen({Key? key}) : super(key: key);

  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

List<Appointment> inProgressAppointments = [];
List<Appointment> endedAppointments = [];

Patient pt = Patient();
getPrefs() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  pt.username = prefs.getString("FullName");
  pt.email = prefs.getString("Email");
  pt.phoneNumber = prefs.getString("PhoneNumber");
  pt.password = prefs.getString("Password");
  pt.age = prefs.getString("Age");
  pt.gender = prefs.getString("Gender");
  pt.image = prefs.getString("Image");
}

SliverAppBar showSliverAppBar(String screenTitle) {
  return SliverAppBar(
    backgroundColor: primaryColor,
    floating: true,
    pinned: true,
    snap: false,
    title: Text(screenTitle),
    centerTitle: true,
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
  void initState() {
    () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var name = prefs.getString("FullName");
      inProgressAppointments = await GetInProgressAppointments(name);
      endedAppointments = await GetEndedAppointments(name);
      setState(() {});
    }();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
                  height: size.height,
                  color: back,
                  child: inProgressAppointments.isEmpty
                      ? const Center(
                          child: Text("There is no appointments"),
                        )
                      : Column(children: [
                          for (var i = 0;
                              i < inProgressAppointments.length;
                              i++)
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                height: 150,
                                padding: const EdgeInsets.fromLTRB(
                                    20.0, 8.0, 0.0, 0.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: Row(children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Doctor Name',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(inProgressAppointments[i].DoctorName,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w800,
                                              fontSize: 16,
                                              color: Colors.black
                                                  .withOpacity(0.5))),
                                      Column(
                                        children: [
                                          const Text(
                                            ' \n\n  Price',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text('450 EGP',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w800,
                                                  fontSize: 16,
                                                  color: Colors.black
                                                      .withOpacity(0.5))),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Column(
                                        children: [
                                          const Text(
                                            '   Date  ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                              '  ${inProgressAppointments[i].Date}',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w800,
                                                  fontSize: 16,
                                                  color: Colors.black
                                                      .withOpacity(0.5))),
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            ' \n\nPlace',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text('Dokki ,Cairo    ',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w800,
                                                  fontSize: 16,
                                                  color: Colors.black
                                                      .withOpacity(0.5))),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Time',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                          '${inProgressAppointments[i].Time}\n\n',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w800,
                                              fontSize: 16,
                                              color: Colors.black
                                                  .withOpacity(0.5))),
                                      Container(
                                        padding: const EdgeInsets.fromLTRB(
                                            0.0, 0.0, 0.0, 5.0),
                                        child: MaterialButton(
                                            elevation: 5.0,
                                            color: Colors.red,
                                            padding: const EdgeInsets.all(10),
                                            shape: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                              borderSide: BorderSide.none,
                                            ),
                                            onPressed: () {
                                              showDialog(
                                                useSafeArea: false,
                                                context: context,
                                                barrierColor: splashBack,
                                                builder: (ctx) => AlertDialog(
                                                  content: const Text(
                                                      "Are you sure, you want to cancel this appointment?",
                                                      style: TextStyle(
                                                        fontSize: contentFont,
                                                      )),
                                                  actions: [
                                                    Row(
                                                      children: [
                                                        //btn cancel
                                                        Expanded(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child:
                                                                OutlinedButton(
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    ctx);
                                                              },
                                                              child: const Text(
                                                                "Cancel",
                                                                style:
                                                                    TextStyle(
                                                                  color:
                                                                      primaryColor,
                                                                  fontSize:
                                                                      contentFont,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),

                                                        Expanded(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child:
                                                                MaterialButton(
                                                              elevation: 6.0,
                                                              color: Colors
                                                                  .redAccent,
                                                              onPressed:
                                                                  () async {
                                                                await DeleteAppointmentFromSchedule(
                                                                    date: inProgressAppointments[
                                                                            i]
                                                                        .Date,
                                                                    doctorName:
                                                                        inProgressAppointments[i]
                                                                            .DoctorName);
                                                                var result =
                                                                    await DeleteAppointment(
                                                                        inProgressAppointments[
                                                                            i]);
                                                                if (result ==
                                                                    "deleted") {
                                                                  await getPrefs();
                                                                  List<Widget>
                                                                      patientScreens =
                                                                      [
                                                                    const SettingScreen(),
                                                                    ChatsScreen(),
                                                                    const PatientHomeScreen(),
                                                                    NotificationsScreen(),
                                                                    PatientProfileScreen(
                                                                        patient:
                                                                            pt),
                                                                  ];
                                                                  Navigator
                                                                      .pushAndRemoveUntil(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (context) =>
                                                                            BottomNavBar(
                                                                              screens: patientScreens,
                                                                            )),
                                                                    (Route<dynamic>
                                                                            route) =>
                                                                        false,
                                                                  );
                                                                }
                                                              },
                                                              child: const Text(
                                                                'Sure',
                                                                style:
                                                                    TextStyle(
                                                                  color: white,
                                                                  fontSize:
                                                                      contentFont,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
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
                  height: size.height,
                  color: back,
                  child: endedAppointments.isEmpty
                      ? const Center(
                          child: Text("There is no appointments"),
                        )
                      : Column(children: [
                          for (var i = 0; i < endedAppointments.length; i++)
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Container(
                                height: 150,
                                padding: const EdgeInsets.fromLTRB(
                                    20.0, 8.0, 0.0, 0.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: Row(children: [
                                  Column(
                                    children: [
                                      const Text(
                                        'Doctor Name',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(endedAppointments[i].DoctorName,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w800,
                                              fontSize: 16,
                                              color: Colors.black
                                                  .withOpacity(0.5))),
                                      Column(
                                        children: [
                                          const Text(
                                            ' \n\n Price',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text('450 EGP',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w800,
                                                  fontSize: 16,
                                                  color: Colors.black
                                                      .withOpacity(0.5))),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Column(
                                        children: [
                                          const Text(
                                            'Date',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text('${endedAppointments[i].Date}',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w800,
                                                  fontSize: 16,
                                                  color: Colors.black
                                                      .withOpacity(0.5))),
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            ' \n\nPlace',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text('Dokki ,Cairo    ',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w800,
                                                  fontSize: 16,
                                                  color: Colors.black
                                                      .withOpacity(0.5))),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Time',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text('${endedAppointments[i].Time}\n\n',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w800,
                                              fontSize: 16,
                                              color: Colors.black
                                                  .withOpacity(0.5))),
                                      Container(
                                        padding: const EdgeInsets.fromLTRB(
                                            0.0, 0.0, 0.0, 5.0),
                                        child: MaterialButton(
                                            elevation: 5.0,
                                            color: primaryColor,
                                            padding: const EdgeInsets.all(10),
                                            shape: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(25),
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


// Padding(
                          //   padding: const EdgeInsets.all(10.0),
                          //   child: Container(
                          //     height: 140,
                          //     padding: const EdgeInsets.fromLTRB(
                          //         20.0, 8.0, 0.0, 0.0),
                          //     decoration: BoxDecoration(
                          //       color: Colors.white,
                          //       borderRadius: BorderRadius.circular(25),
                          //     ),
                          //     child: Row(children: [
                          //       Column(
                          //         mainAxisAlignment: MainAxisAlignment.start,
                          //         children: [
                          //           Text(
                          //             'Doctor Name',
                          //             style: TextStyle(
                          //                 fontWeight: FontWeight.bold,
                          //                 fontSize: 18),
                          //           ),
                          //           Text('Ganna Shaker',
                          //               style: TextStyle(
                          //                   fontWeight: FontWeight.w800,
                          //                   fontSize: 16,
                          //                   color:
                          //                       Colors.black.withOpacity(0.5))),
                          //           Column(
                          //             mainAxisAlignment:
                          //                 MainAxisAlignment.start,
                          //             crossAxisAlignment:
                          //                 CrossAxisAlignment.start,
                          //             children: [
                          //               Text(
                          //                 ' \n\n  Price',
                          //                 style: TextStyle(
                          //                     fontWeight: FontWeight.bold,
                          //                     fontSize: 18),
                          //               ),
                          //               Text('450 EGP',
                          //                   style: TextStyle(
                          //                       fontWeight: FontWeight.w800,
                          //                       fontSize: 16,
                          //                       color: Colors.black
                          //                           .withOpacity(0.5))),
                          //             ],
                          //           ),
                          //         ],
                          //       ),
                          //       Column(
                          //         mainAxisAlignment: MainAxisAlignment.start,
                          //         crossAxisAlignment: CrossAxisAlignment.center,
                          //         children: [
                          //           Column(
                          //             children: [
                          //               Text(
                          //                 '     Date   ',
                          //                 style: TextStyle(
                          //                     fontWeight: FontWeight.bold,
                          //                     fontSize: 18),
                          //               ),
                          //               Text('    2/2/2023',
                          //                   style: TextStyle(
                          //                       fontWeight: FontWeight.w800,
                          //                       fontSize: 16,
                          //                       color: Colors.black
                          //                           .withOpacity(0.5))),
                          //             ],
                          //           ),
                          //           Column(
                          //             mainAxisAlignment:
                          //                 MainAxisAlignment.start,
                          //             crossAxisAlignment:
                          //                 CrossAxisAlignment.start,
                          //             children: [
                          //               Text(
                          //                 ' \n\n       Place        ',
                          //                 style: TextStyle(
                          //                     fontWeight: FontWeight.bold,
                          //                     fontSize: 18),
                          //               ),
                          //               Text('    Dokki ,Cairo       ',
                          //                   style: TextStyle(
                          //                       fontWeight: FontWeight.w800,
                          //                       fontSize: 16,
                          //                       color: Colors.black
                          //                           .withOpacity(0.5))),
                          //             ],
                          //           ),
                          //         ],
                          //       ),
                          //       Column(
                          //         mainAxisAlignment: MainAxisAlignment.start,
                          //         children: [
                          //           Text(
                          //             'Time',
                          //             style: TextStyle(
                          //                 fontWeight: FontWeight.bold,
                          //                 fontSize: 18),
                          //           ),
                          //           Text('01:00 PM\n\n',
                          //               style: TextStyle(
                          //                   fontWeight: FontWeight.w800,
                          //                   fontSize: 16,
                          //                   color:
                          //                       Colors.black.withOpacity(0.5))),
                          //           Container(
                          //             padding: const EdgeInsets.fromLTRB(
                          //                 0.0, 0.0, 0.0, 5.0),
                          //             child: Column(
                          //               children: [
                          //                 const Text(
                          //                   'Rate',
                          //                   style: TextStyle(
                          //                       fontWeight: FontWeight.bold,
                          //                       fontSize: 18),
                          //                 ),
                          //                 RatingBar(
                          //                     initialRating: 0,
                          //                     itemSize: 22,
                          //                     direction: Axis.horizontal,
                          //                     allowHalfRating: true,
                          //                     itemCount: 5,
                          //                     ratingWidget: RatingWidget(
                          //                         full: const Icon(Icons.star,
                          //                             color: primaryColor),
                          //                         half: const Icon(
                          //                           Icons.star_half,
                          //                           color: primaryColor,
                          //                         ),
                          //                         empty: const Icon(
                          //                           Icons.star_outline,
                          //                           color: primaryColor,
                          //                         )),
                          //                     onRatingUpdate: (value) {
                          //                       setState(() {});
                          //                     }),
                          //               ],
                          //             ),
                          //           ),
                          //         ],
                          //       ),
                          //     ]),
                          //   ),
                          // ),