import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:group_button/group_button.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:sos_app/Data/Models/AppointmentModel.dart';
import 'package:sos_app/Data/Models/ScheduleModel.dart';
import '../../../../Data/Models/ReportModel.dart';
import '../../../../Data/Models/doctor.dart';
import '../../../Screens/App_Layout/bottom_nav_bar.dart';
import '../../../Screens/Chats/chats_screen.dart';
import '../../../Screens/Notifications/notifications_screen.dart';
import '../../../Screens/Settings/settings_screen.dart';
import '../../../Styles/colors.dart';
import '../../../Styles/fonts.dart';
import '../../Profile/patient_profile_screen.dart';
import '../patient_home_screen.dart';

class AddAppointmentScreen extends StatefulWidget {
  Doctor doctor;
  List<Report> reports;
  List<Schedule> schedules;
  AddAppointmentScreen(
      {super.key,
      required this.reports,
      required this.doctor,
      required this.schedules});

  @override
  State<AddAppointmentScreen> createState() => _AddAppointmentScreenState();
}

class _AddAppointmentScreenState extends State<AddAppointmentScreen> {
  DateTime today = DateTime.now();
  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
  }

  Report? report;
  String? _date;
  List<TimeSlots> timeSlots = [];
  var timeController = GroupButtonController();
  var scheduleId;

  _getTimeSlots(id) async {
    timeSlots = await GetTimeSlots(id);
    setState(() {});
  }

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
                      padding: const EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                      child: CircleAvatar(
                          backgroundImage: NetworkImage(
                            widget.doctor.image,
                          ),
                          maxRadius: 80,
                          backgroundColor: white),
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
                                      double.parse(
                                          widget.doctor.addressLat.toString()),
                                      double.parse(
                                          widget.doctor.addressLong.toString()),
                                      "${widget.doctor.username}'s location");
                                },
                                icon: const Icon(Icons.location_on),
                                iconSize: 40,
                              ),
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
                Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Padding(
                            padding: EdgeInsets.fromLTRB(20, 10, 0, 0)),
                        const Text(
                          'Date:',
                          style: TextStyle(
                              fontSize: 26, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        _date != null
                            ? Text(
                                _date!,
                                style: const TextStyle(
                                  fontSize: 20,
                                ),
                              )
                            : Center()
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Column(children: [
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.0)),
                              color: Color.fromARGB(128, 226, 162, 130),
                            ),
                            alignment: Alignment.topCenter,
                            //Calender Table
                            child: HeatMap(
                                //The selected dates on calender
                                datasets: {
                                  for (var item in widget.schedules)
                                    if (item.day >= DateTime.now().day)
                                      DateTime(item.year, item.month, item.day):
                                          5,
                                },
                                startDate: DateTime.utc(DateTime.now().year,
                                    DateTime.now().month, 1),
                                endDate:
                                    DateTime.utc(DateTime.now().year, 12, 31),
                                size: 40,
                                textColor:
                                    const Color.fromARGB(235, 141, 61, 21),
                                defaultColor: Colors.white,
                                colorMode: ColorMode.opacity,
                                showText: true,
                                scrollable: true,
                                showColorTip: false,
                                colorsets: const {
                                  1: Color.fromRGBO(237, 96, 35, 0.922),
                                  2: Color.fromRGBO(237, 96, 40, 0.922),
                                  3: Color.fromRGBO(237, 96, 45, 0.922),
                                  4: Color.fromRGBO(237, 96, 50, 0.922),
                                  5: Color.fromRGBO(237, 96, 55, 0.922),
                                },
                                //Navigate the date you choose
                                onClick: (value) async {
                                  for (var i = 0;
                                      i < widget.schedules.length;
                                      i++) {
                                    if (widget.schedules[i].day == value.day &&
                                        widget.schedules[i].month ==
                                            value.month &&
                                        widget.schedules[i].year ==
                                            value.year) {
                                      setState(() {
                                        _date =
                                            "${widget.schedules[i].day} / ${widget.schedules[i].month} / ${widget.schedules[i].year}";
                                        scheduleId =
                                            widget.schedules[i].scheduleId;
                                      });
                                      _getTimeSlots(
                                          widget.schedules[i].scheduleId);
                                    }
                                  }
                                })),
                      ),
                      const SizedBox(height: 30),
                    ]),
                  ],
                ),
                Row(
                  children: const [
                    Padding(padding: EdgeInsets.fromLTRB(20, 10, 0, 0)),
                    Text(
                      'Time:',
                      style:
                          TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: timeSlots.length != 0
                        ? GroupButton(
                            controller: timeController,
                            options: GroupButtonOptions(
                              selectedColor: primaryColor,
                              unselectedColor: Colors.amber[100],
                              borderRadius: BorderRadius.circular(20),
                              selectedTextStyle:
                                  const TextStyle(fontSize: 20, color: black),
                              unselectedTextStyle:
                                  const TextStyle(fontSize: 20, color: black),
                              spacing: 10,
                              runSpacing: 10,
                              groupingType: GroupingType.wrap,
                              direction: Axis.horizontal,
                              buttonHeight: 60,
                              buttonWidth: 80,
                              mainGroupAlignment: MainGroupAlignment.start,
                              crossGroupAlignment: CrossGroupAlignment.start,
                              groupRunAlignment: GroupRunAlignment.start,
                              textAlign: TextAlign.center,
                              alignment: Alignment.center,
                              elevation: 2,
                            ),
                            maxSelected: 1,
                            isRadio: true,
                            buttons: [
                              for (var time in timeSlots)
                                "${time.time.toString()}:00"
                            ],
                          )
                        : const Text(
                            "There is no time available",
                            style: TextStyle(
                                color: primaryColor,
                                fontSize: 22,
                                fontWeight: FontWeight.bold),
                          )),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(20.0, 10, 10, 10),
                      child: Text(
                        'Select Report:',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
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
                            report = value!;
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
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  primaryColor),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ))),
                          onPressed: () async {
                            if (report == null) {
                              AwesomeDialog(
                                context: context,
                                title: "Error",
                                body: const Text(
                                  "Please select report",
                                ),
                              ).show();
                            } else {
                              var index = timeController.selectedIndex;
                              if (index != null) {
                                var timeId = timeSlots[index].timeSlotId;
                                var time = "${timeSlots[index].time}:00";
                                Appointment app = Appointment(
                                    reportId: report!.reportId,
                                    doctorId: widget.doctor.id,
                                    patientId:
                                        FirebaseAuth.instance.currentUser!.uid,
                                    status: "In Progress",
                                    date: _date,
                                    time: time,
                                    rate: 0);
                                await AddAppointment(
                                    app: app,
                                    context: context,
                                    scheduleId: scheduleId,
                                    timeId: timeId);
                                Navigator.pop(context);
                              } else {
                                AwesomeDialog(
                                  context: context,
                                  title: "Error",
                                  body: const Text(
                                    "Please select time",
                                  ),
                                ).show();
                              }
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
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  primaryColor),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
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
            )));
  }
}
