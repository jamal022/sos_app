import 'package:flutter/material.dart';
import 'package:maps_launcher/maps_launcher.dart';
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
bool _inflag = false;
bool _enflag = false;
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
    title: Text(
      screenTitle,
      style: const TextStyle(fontSize: 28),
    ),
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
    _inflag = true;
    _enflag = true;
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
        backgroundColor: back,
        body: DefaultTabController(
          length: 2,
          child: TabBarView(children: [
            CustomScrollView(
              slivers: [
                showSliverAppBar('My Appointments'),
                SliverList(
                  delegate: SliverChildListDelegate([
                    _inflag == true
                        ? inProgressAppointments.length != 0
                            ? Column(children: [
                                for (var i = 0;
                                    i < inProgressAppointments.length;
                                    i++)
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Card(
                                      elevation: 5,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(children: [
                                          Row(
                                            children: [
                                              const Text(
                                                'Doctor Name',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18),
                                              ),
                                              SizedBox(
                                                width: size.width / 8,
                                              ),
                                              const Text(
                                                'Date',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18),
                                              ),
                                              SizedBox(
                                                width: size.width / 6,
                                              ),
                                              const Text(
                                                'Time',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Row(
                                              children: [
                                                Text(
                                                    "${inProgressAppointments[i].doctorName}",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w800,
                                                        fontSize: 16,
                                                        color: Colors.black
                                                            .withOpacity(0.5))),
                                                SizedBox(
                                                  width: size.width / 5,
                                                ),
                                                Text(
                                                    '${inProgressAppointments[i].date}',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w800,
                                                        fontSize: 16,
                                                        color: Colors.black
                                                            .withOpacity(0.5))),
                                                SizedBox(
                                                  width: size.width / 12,
                                                ),
                                                Text(
                                                    '${inProgressAppointments[i].time}',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w800,
                                                        fontSize: 16,
                                                        color: Colors.black
                                                            .withOpacity(0.5))),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                Column(
                                                  children: [
                                                    const Text(
                                                      'Price',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 18),
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                        "${inProgressAppointments[i].price} EGP",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w800,
                                                            fontSize: 16,
                                                            color: Colors.black
                                                                .withOpacity(
                                                                    0.5))),
                                                  ],
                                                ),
                                                SizedBox(
                                                  width: size.width / 5,
                                                ),
                                                IconButton(
                                                    onPressed: () {
                                                      MapsLauncher.launchCoordinates(
                                                          inProgressAppointments[
                                                                  i]
                                                              .placeLat,
                                                          inProgressAppointments[
                                                                  i]
                                                              .placeLong,
                                                          "Dr ${inProgressAppointments[i].doctorName}'s location");
                                                    },
                                                    icon: const Icon(
                                                      Icons.location_on,
                                                      size: 30,
                                                    )),
                                                SizedBox(
                                                  width: size.width / 8,
                                                ),
                                                IconButton(
                                                    onPressed: () {
                                                      showDialog(
                                                        useSafeArea: false,
                                                        context: context,
                                                        barrierColor:
                                                            splashBack,
                                                        builder: (ctx) =>
                                                            AlertDialog(
                                                          content: const Text(
                                                              "Are you sure, you want to cancel this appointment?",
                                                              style: TextStyle(
                                                                fontSize:
                                                                    contentFont,
                                                              )),
                                                          actions: [
                                                            Row(
                                                              children: [
                                                                //btn cancel
                                                                Expanded(
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child:
                                                                        OutlinedButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.pop(
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
                                                                              FontWeight.bold,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),

                                                                Expanded(
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child:
                                                                        MaterialButton(
                                                                      elevation:
                                                                          6.0,
                                                                      color: Colors
                                                                          .redAccent,
                                                                      onPressed:
                                                                          () async {
                                                                        await UpdateTimeInCancel(
                                                                            inProgressAppointments[i].doctorId,
                                                                            inProgressAppointments[i].date,
                                                                            inProgressAppointments[i].time);
                                                                        var result = await DeleteAppointment(
                                                                            appId:
                                                                                inProgressAppointments[i].appointmentId,
                                                                            date: inProgressAppointments[i].date,
                                                                            doctorId: inProgressAppointments[i].doctorId,
                                                                            doctorName: inProgressAppointments[i].doctorName,
                                                                            patientId: inProgressAppointments[i].patientId,
                                                                            role: "Patient");
                                                                        if (result ==
                                                                            "deleted") {
                                                                          Navigator.pop(
                                                                              context);
                                                                          _getApp();
                                                                        }
                                                                      },
                                                                      child:
                                                                          const Text(
                                                                        'Sure',
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              white,
                                                                          fontSize:
                                                                              contentFont,
                                                                          fontWeight:
                                                                              FontWeight.bold,
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
                                                    icon: const Icon(
                                                      Icons.cancel,
                                                      size: 35,
                                                      color: Colors.red,
                                                    )),
                                              ],
                                            ),
                                          ),
                                        ]),
                                      ),
                                    ),
                                  ),
                              ])
                            : Container(
                                height: size.height,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    const Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(25, 2, 25, 5)),
                                    const Icon(
                                      Icons.warning_amber_rounded,
                                      size: 100,
                                      color: primaryColor,
                                    ),
                                    SizedBox(
                                      height: size.height / 40,
                                    ),
                                    const Text(
                                      'There is no Appointments',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: primaryColor),
                                    ),
                                  ],
                                ),
                              )
                        : Container(
                            height: size.height,
                            child: const Center(
                              child: CircularProgressIndicator(),
                            )),
                  ]),
                ),
              ],
            ),
            CustomScrollView(slivers: [
              showSliverAppBar('My Appointments'),
              SliverList(
                delegate: SliverChildListDelegate([
                  _enflag == true
                      ? endedAppointments.length != 0
                          ? Column(children: [
                              for (var i = 0; i < endedAppointments.length; i++)
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Card(
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(children: [
                                        Row(
                                          children: [
                                            const Text(
                                              'Doctor Name',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18),
                                            ),
                                            SizedBox(
                                              width: size.width / 8,
                                            ),
                                            const Text(
                                              'Date',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18),
                                            ),
                                            SizedBox(
                                              width: size.width / 6,
                                            ),
                                            const Text(
                                              'Time',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Row(
                                            children: [
                                              Text(
                                                  "${endedAppointments[i].doctorName}",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      fontSize: 16,
                                                      color: Colors.black
                                                          .withOpacity(0.5))),
                                              SizedBox(
                                                width: size.width / 5,
                                              ),
                                              Text(
                                                  '${endedAppointments[i].date}',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      fontSize: 16,
                                                      color: Colors.black
                                                          .withOpacity(0.5))),
                                              SizedBox(
                                                width: size.width / 12,
                                              ),
                                              Text(
                                                  '${endedAppointments[i].time}',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      fontSize: 16,
                                                      color: Colors.black
                                                          .withOpacity(0.5))),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Column(
                                                children: [
                                                  const Text(
                                                    'Price',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 18),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                      "${endedAppointments[i].price} EGP",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w800,
                                                          fontSize: 16,
                                                          color: Colors.black
                                                              .withOpacity(
                                                                  0.5))),
                                                ],
                                              ),
                                              SizedBox(
                                                width: size.width / 8,
                                              ),
                                              IconButton(
                                                  onPressed: () {
                                                    MapsLauncher.launchCoordinates(
                                                        endedAppointments[i]
                                                            .placeLat,
                                                        endedAppointments[i]
                                                            .placeLong,
                                                        "Dr ${endedAppointments[i].doctorName}'s location");
                                                  },
                                                  icon: const Icon(
                                                    Icons.location_on,
                                                    size: 30,
                                                  )),
                                              SizedBox(
                                                width: size.width / 10,
                                              ),
                                              Container(
                                                child: endedAppointments[i]
                                                            .rate ==
                                                        0
                                                    ? MaterialButton(
                                                        elevation: 5.0,
                                                        color: primaryColor,
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10),
                                                        shape:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(25),
                                                          borderSide:
                                                              BorderSide.none,
                                                        ),
                                                        onPressed: () {
                                                          showDialog(
                                                            useSafeArea: false,
                                                            context: context,
                                                            barrierColor:
                                                                splashBack,
                                                            builder: (ctx) =>
                                                                AlertDialog(
                                                              content:
                                                                  Container(
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
                                                                          textAlign: TextAlign
                                                                              .center,
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                22,
                                                                          )),
                                                                      const SizedBox(
                                                                        height:
                                                                            15,
                                                                      ),
                                                                      RatingBar(
                                                                          initialRating:
                                                                              0,
                                                                          itemSize:
                                                                              35,
                                                                          direction: Axis
                                                                              .horizontal,
                                                                          allowHalfRating:
                                                                              true,
                                                                          itemCount:
                                                                              5,
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
                                                                          onRatingUpdate: (value) {
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
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(8.0),
                                                                        child:
                                                                            OutlinedButton(
                                                                          onPressed:
                                                                              () {
                                                                            Navigator.pop(ctx);
                                                                          },
                                                                          child:
                                                                              const Text(
                                                                            "Cancel",
                                                                            style:
                                                                                TextStyle(
                                                                              color: primaryColor,
                                                                              fontSize: contentFont,
                                                                              fontWeight: FontWeight.bold,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),

                                                                    Expanded(
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(8.0),
                                                                        child:
                                                                            MaterialButton(
                                                                          elevation:
                                                                              6.0,
                                                                          color:
                                                                              primaryColor,
                                                                          onPressed:
                                                                              () async {
                                                                            var result = await UpdateRate(
                                                                                endedAppointments[i].appointmentId,
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
                                                                              color: white,
                                                                              fontSize: contentFont,
                                                                              fontWeight: FontWeight.bold,
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
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ))
                                                    : Column(
                                                        children: [
                                                          const Text(
                                                            'Rate',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 18),
                                                          ),
                                                          RatingBar(
                                                            ignoreGestures:
                                                                true,
                                                            initialRating:
                                                                endedAppointments[
                                                                        i]
                                                                    .rate,
                                                            itemSize: 20,
                                                            direction:
                                                                Axis.horizontal,
                                                            allowHalfRating:
                                                                true,
                                                            itemCount: 5,
                                                            tapOnlyMode: true,
                                                            ratingWidget:
                                                                RatingWidget(
                                                                    full: const Icon(
                                                                        Icons
                                                                            .star,
                                                                        color:
                                                                            primaryColor),
                                                                    half:
                                                                        const Icon(
                                                                      Icons
                                                                          .star_half,
                                                                      color:
                                                                          primaryColor,
                                                                    ),
                                                                    empty:
                                                                        const Icon(
                                                                      Icons
                                                                          .star_outline,
                                                                      color:
                                                                          primaryColor,
                                                                    )),
                                                            onRatingUpdate:
                                                                ((value) {}),
                                                          )
                                                        ],
                                                      ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ]),
                                    ),
                                  ),
                                ),
                            ])
                          : Container(
                              height: size.height,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  const Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(25, 2, 25, 5)),
                                  const Icon(
                                    Icons.warning_amber_rounded,
                                    size: 100,
                                    color: primaryColor,
                                  ),
                                  SizedBox(
                                    height: size.height / 40,
                                  ),
                                  const Text(
                                    'There is no Appointments',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: primaryColor),
                                  ),
                                ],
                              ),
                            )
                      : Container(
                          height: size.height,
                          child: const Center(
                            child: CircularProgressIndicator(),
                          )),
                ]),
              ),
            ])
          ]),
        ));
  }
}
