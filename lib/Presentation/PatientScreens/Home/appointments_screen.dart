import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sos_app/Data/Models/ScheduleModel.dart';
import '../../../Data/Models/AppointmentModel.dart';
import '../../../Data/Models/patient.dart';
import '../../Styles/colors.dart';
import '../../Styles/fonts.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class AppointmentsScreen extends StatefulWidget {
  AppointmentsScreen({Key? key}) : super(key: key);

  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

List<Appointment> inProgressAppointments = [];
List<Appointment> endedAppointments = [];
var _ratingValue;
Patient pt = Patient();
getPrefs() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  pt.id = prefs.getString("Id");
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
  _getApp() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = prefs.getString("Id");
    inProgressAppointments = await GetInProgressAppointments(id);
    endedAppointments = await GetEndedAppointments(id);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _getApp();
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
                                      Text(inProgressAppointments[i].doctorName,
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
                                          Text(
                                              "${inProgressAppointments[i].price} EGP",
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
                                              '  ${inProgressAppointments[i].date}',
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
                                          Text(
                                              '${inProgressAppointments[i].place}    ',
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
                                          '${inProgressAppointments[i].time}\n\n',
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
                                                                        .date,
                                                                    doctorId:
                                                                        inProgressAppointments[i]
                                                                            .doctorId);
                                                                var result =
                                                                    await DeleteAppointment(
                                                                        inProgressAppointments[
                                                                            i],
                                                                        context);
                                                                if (result ==
                                                                    "deleted") {
                                                                  _getApp();
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
                                      Text(endedAppointments[i].doctorName,
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
                                          Text(
                                              '${endedAppointments[i].price} EGP',
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
                                          Text('${endedAppointments[i].date}',
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
                                          Text(
                                              '${endedAppointments[i].place}    ',
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
                                      Text('${endedAppointments[i].time}\n\n',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w800,
                                              fontSize: 16,
                                              color: Colors.black
                                                  .withOpacity(0.5))),
                                      Container(
                                        padding: const EdgeInsets.fromLTRB(
                                            0.0, 0.0, 0.0, 5.0),
                                        child: endedAppointments[i].rate == 0
                                            ? MaterialButton(
                                                elevation: 5.0,
                                                color: primaryColor,
                                                padding:
                                                    const EdgeInsets.all(10),
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
                                                    builder: (ctx) =>
                                                        AlertDialog(
                                                      content: Container(
                                                        height: 100,
                                                        child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              const Text(
                                                                  "Rate The Doctor",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        22,
                                                                  )),
                                                              const SizedBox(
                                                                height: 15,
                                                              ),
                                                              RatingBar(
                                                                  initialRating:
                                                                      0,
                                                                  itemSize: 35,
                                                                  direction: Axis
                                                                      .horizontal,
                                                                  allowHalfRating:
                                                                      true,
                                                                  itemCount: 5,
                                                                  ratingWidget:
                                                                      RatingWidget(
                                                                          full: const Icon(Icons.star,
                                                                              color:
                                                                                  primaryColor),
                                                                          half:
                                                                              const Icon(
                                                                            Icons.star_half,
                                                                            color:
                                                                                primaryColor,
                                                                          ),
                                                                          empty:
                                                                              const Icon(
                                                                            Icons.star_outline,
                                                                            color:
                                                                                primaryColor,
                                                                          )),
                                                                  onRatingUpdate:
                                                                      (value) {
                                                                    _ratingValue =
                                                                        value;
                                                                  }),
                                                            ]),
                                                      ),
                                                      actions: [
                                                        Row(
                                                          children: [
                                                            //btn cancel
                                                            Expanded(
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child:
                                                                    OutlinedButton(
                                                                  onPressed:
                                                                      () {
                                                                    Navigator
                                                                        .pop(
                                                                            ctx);
                                                                  },
                                                                  child:
                                                                      const Text(
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
                                                                            .all(
                                                                        8.0),
                                                                child:
                                                                    MaterialButton(
                                                                  elevation:
                                                                      6.0,
                                                                  color:
                                                                      primaryColor,
                                                                  onPressed:
                                                                      () async {
                                                                    var result = await UpdateRate(
                                                                        endedAppointments[
                                                                            i],
                                                                        _ratingValue,
                                                                        context);
                                                                    if (result ==
                                                                        "changed") {
                                                                      _getApp();
                                                                    }
                                                                  },
                                                                  child:
                                                                      const Text(
                                                                    'Rate',
                                                                    style:
                                                                        TextStyle(
                                                                      color:
                                                                          white,
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
                                                  '   Rate   ',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ))
                                            : Column(
                                                children: [
                                                  const Text(
                                                    'Rate',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 18),
                                                  ),
                                                  RatingBar(
                                                    ignoreGestures: true,
                                                    initialRating:
                                                        endedAppointments[i]
                                                            .rate,
                                                    itemSize: 22,
                                                    direction: Axis.horizontal,
                                                    allowHalfRating: true,
                                                    itemCount: 5,
                                                    tapOnlyMode: true,
                                                    ratingWidget: RatingWidget(
                                                        full: const Icon(
                                                            Icons.star,
                                                            color:
                                                                primaryColor),
                                                        half: const Icon(
                                                          Icons.star_half,
                                                          color: primaryColor,
                                                        ),
                                                        empty: const Icon(
                                                          Icons.star_outline,
                                                          color: primaryColor,
                                                        )),
                                                    onRatingUpdate:
                                                        ((value) {}),
                                                  )
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
