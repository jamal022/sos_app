import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sos_app/Data/Models/AppointmentModel.dart';
import 'package:sos_app/Presentation/PatientScreens/Profile/patient_profile_screen.dart';
import '../../../../Data/Models/ReportModel.dart';
import '../../../../Data/Models/ScheduleModel.dart';
import '../../../../Data/Models/doctor.dart';
import '../../../../Data/Models/patient.dart';
import '../../../Screens/App_Layout/bottom_nav_bar.dart';
import '../../../Screens/Chats/chats_screen.dart';
import '../../../Screens/Notifications/notifications_screen.dart';
import '../../../Screens/Settings/settings_screen.dart';
import '../../../Styles/colors.dart';
import '../../../Styles/fonts.dart';
import '../patient_home_screen.dart';

class AddAppointmentScreen extends StatefulWidget {
  Doctor doctor;
  List<Schedule> schedules;
  List<Report> reports;
  AddAppointmentScreen(
      {super.key,
      required this.doctor,
      required this.schedules,
      required this.reports});

  @override
  State<AddAppointmentScreen> createState() => _AddAppointmentScreenState();
}

var _fromTime, _fromPeriod, _toTime, _toPeriod, _day, _month, _year;
late Schedule schedule;
var report;

class _AddAppointmentScreenState extends State<AddAppointmentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Appointment",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
        ),
        centerTitle: true,
        toolbarHeight: 60.2,
        elevation: 4,
        backgroundColor: primaryColor,
      ),
      body: Container(
        color: back,
        child: SingleChildScrollView(
            child: Column(children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                child: CircleAvatar(
                    backgroundImage: NetworkImage(
                      widget.doctor.image,
                    ),
                    maxRadius: 80,
                    backgroundColor: primaryColor),
              ),
              Container(
                width: 200,
                height: 200,
                margin: const EdgeInsets.fromLTRB(20, 15, 0, 0),
                child: Column(
                  children: [
                    Text(
                      '\n${widget.doctor.username}\n',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        Text(' Location : ',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black.withOpacity(0.5))),
                        IconButton(
                          onPressed: () {
                            MapsLauncher.launchCoordinates(
                                double.parse(widget.doctor.addressLat),
                                double.parse(widget.doctor.addressLong),
                                "${widget.doctor.username}'s location");
                          },
                          icon: const Icon(Icons.location_on),
                          iconSize: 40,
                        )
                      ],
                    ),
                    Text('\nTicket Price : ${widget.doctor.price} EGP',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black.withOpacity(0.5))),
                  ],
                ),
              )
            ],
          ),
          const Divider(
            thickness: 2,
            color: primaryColor,
            endIndent: 25,
            indent: 25,
          ),
          Column(children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 0, 10),
              child: Row(
                children: const [
                  Icon(Icons.sd_card_alert_rounded),
                  Text(
                    "Entry is on a first-come, first-served basis.",
                    style: TextStyle(
                      color: black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: const [
                Padding(padding: EdgeInsets.fromLTRB(20, 20, 0, 0)),
                Text(
                  'Date:',
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Column(children: <Widget>[
              GridView.extent(
                shrinkWrap: true,
                primary: false,
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                maxCrossAxisExtent: 150.0,
                children: <Widget>[
                  for (var i = 0; i < widget.schedules.length; i++)
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            secondaryColor,
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ))),
                      onPressed: () {
                        if (int.parse(widget.schedules[i].nbAppointments
                                .toString()) ==
                            (int.parse(widget.schedules[i].maxNbAppointments
                                .toString()))) {
                          setState(() {
                            _day = null;
                            _month = null;
                            _year = null;
                            _fromPeriod = null;
                            _fromTime = null;
                            _toPeriod = null;
                            _toTime = null;
                          });
                          AwesomeDialog(
                            context: context,
                            title: "Error",
                            body: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "This day is full of appointments",
                              ),
                            ),
                          ).show();
                        } else {
                          setState(() {
                            schedule = widget.schedules[i];
                            _fromTime = widget.schedules[i].fromTime;
                            _fromPeriod = widget.schedules[i].fromPeriod;
                            _toTime = widget.schedules[i].toTime;
                            _toPeriod = widget.schedules[i].toPeriod;
                            _day = widget.schedules[i].day;
                            _month = widget.schedules[i].month;
                            _year = widget.schedules[i].year;
                          });
                        }
                      },
                      child: Text(
                        '${widget.schedules[i].day}/${widget.schedules[i].month}/${widget.schedules[i].year}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              )
            ]),
            const SizedBox(
              height: 20,
            ),
            Column(
              children: [
                Text(
                  _day != null ? "${_day} / ${_month} / ${_year}" : " ",
                  style: const TextStyle(color: Colors.black, fontSize: 24),
                ),
                Container(
                    alignment: Alignment.topRight,
                    padding: const EdgeInsets.fromLTRB(20.0, 10.0, 0.0, 10.0),
                    child: Row(children: <Widget>[
                      const Text(
                        "From:",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 26,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        _fromTime != null
                            ? "  ${_fromTime}:00 ${_fromPeriod}"
                            : " ",
                        style:
                            const TextStyle(color: Colors.black, fontSize: 24),
                      ),
                      const SizedBox(width: 20),
                      const Text(
                        "To:",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 26,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        _toTime != null ? "  ${_toTime}:00 ${_toPeriod}" : " ",
                        style:
                            const TextStyle(color: Colors.black, fontSize: 24),
                      ),
                    ])),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(20.0, 10, 10, 10),
                  child: Text(
                    'Select Report:',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                for (var i = 0; i < widget.reports.length; i++)
                  RadioListTile(
                    activeColor: primaryColor,
                    title: Text(
                      "${widget.reports[i].burnDegree} (${widget.reports[i].date})",
                      style: const TextStyle(
                          color: Colors.black, fontSize: formSubtitleFont),
                    ),
                    value: widget.reports[i],
                    groupValue: report,
                    onChanged: (value) {
                      setState(() {
                        report = value;
                      });
                    },
                  ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
                margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: Row(children: <Widget>[
                  ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(primaryColor),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ))),
                      onPressed: () async {
                        if (_day == null) {
                          AwesomeDialog(
                            context: context,
                            title: "Error",
                            body: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "This day is full of appointments",
                              ),
                            ),
                          ).show();
                        } else {
                          var reportId = await GetReportId(report);
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();

                          var patientName = prefs.getString("FullName");
                          var patientId = prefs.getString("Id");

                          List<Placemark> myPlacemark =
                              await placemarkFromCoordinates(
                                  double.parse(widget.doctor.addressLat),
                                  double.parse(widget.doctor.addressLong));
                          Appointment appointment = Appointment(
                              patientId: patientId,
                              doctorId: widget.doctor.id,
                              reportId: reportId,
                              patientName: patientName,
                              doctorName: widget.doctor.username,
                              status: "In Progress",
                              date: "${_day}/${_month}/${_year}",
                              time: "${_fromTime}:00 ${_fromPeriod}",
                              price: widget.doctor.price,
                              place: myPlacemark[0].locality,
                              rate: 0);
                          await AddAppointmentToSchedule(
                              day: _day,
                              month: _month,
                              year: _year,
                              doctorId: widget.doctor.id);

                          var result = await AddAppointment(
                              app: appointment, context: context);

                          Navigator.pop(context);
                        }
                      },
                      child: const Text('Confirm',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                          ))),
                  const Spacer(),
                  ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(primaryColor),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ))),
                      onPressed: () {
                        List<Widget> patientScreens = [
                          const SettingScreen(),
                          ChatsScreen(),
                          const PatientHomeScreen(),
                          NotificationsScreen(),
                          PatientProfileScreen(),
                        ];

                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BottomNavBar(
                                    screens: patientScreens,
                                  )),
                          (Route<dynamic> route) => false,
                        );
                      },
                      child: const Text(
                        'Back to Home',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                ])),
            const SizedBox(
              height: 15,
            ),
          ]),
        ])),
      ),
    );
  }
}
