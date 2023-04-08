import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:group_button/group_button.dart';
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
  List<Placemark> placemarks;
  AddAppointmentScreen(
      {super.key,
      required this.reports,
      required this.doctor,
      required this.schedules,
      required this.placemarks});

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
  Stream? timeSlots;
  bool _timeFlag = false;
  var timeController = GroupButtonController();
  var dateController = GroupButtonController();
  var _time;
  var _scheduleId, _timeId;

  _getTimeSlots(id) {
    timeSlots = GetTimeSlots(id);
    _timeFlag = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: back,
        appBar: AppBar(
          title: const Text(
            "Add Appointment",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
          ),
          centerTitle: true,
          toolbarHeight: 60.2,
          elevation: 4,
          backgroundColor: primaryColor,
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromARGB(255, 254, 238, 217),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 5, 12, 5),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                              backgroundImage: NetworkImage(
                                widget.doctor.image,
                              ),
                              maxRadius: 25,
                              backgroundColor: white),
                          SizedBox(
                            width: size.width / 10,
                          ),
                          Text(
                            '${widget.doctor.username}',
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                        child: Row(
                          children: [
                            const Text(
                              'Field:',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: size.width / 15,
                            ),
                            Text(
                              '${widget.doctor.field}',
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                        child: Row(
                          children: [
                            const Text(
                              'Phone Number:',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: size.width / 15,
                            ),
                            Text(
                              '${widget.doctor.phoneNumber}',
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                        child: Row(
                          children: [
                            const Text(
                              'Ticket Price:',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: size.width / 15,
                            ),
                            Text(
                              '${widget.doctor.price} EGP',
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                        child: Row(
                          children: [
                            const Text(
                              'Address:',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: size.width / 15,
                            ),
                            Text(
                              '${widget.placemarks[0].locality}',
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Divider(
              thickness: 2,
              color: primaryColor,
              endIndent: 25,
              indent: 25,
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Center(
                  child: Text(
                    'Date',
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: widget.schedules.length != 0
                    ? GroupButton(
                        controller: dateController,
                        options: GroupButtonOptions(
                          selectedColor: primaryColor,
                          unselectedColor:
                              const Color.fromARGB(255, 240, 226, 213),
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
                          buttonWidth: 120,
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
                          for (var date in widget.schedules)
                            "${date.day.toString()}/${date.month.toString()}/${date.year.toString()}"
                        ],
                        onSelected: (value, index, isSelected) {
                          setState(() {
                            _date =
                                "${widget.schedules[index].day} / ${widget.schedules[index].month} / ${widget.schedules[index].year}";
                            _scheduleId = widget.schedules[index].scheduleId;
                          });
                          _getTimeSlots(widget.schedules[index].scheduleId);
                        },
                      )
                    : const Text(
                        "There is no date available",
                        style: TextStyle(
                            color: primaryColor,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      )),
            const SizedBox(
              height: 10,
            ),
            const Divider(
              thickness: 2,
              color: primaryColor,
              endIndent: 25,
              indent: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Padding(padding: EdgeInsets.fromLTRB(20, 10, 0, 0)),
                Text(
                  'Time',
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            StreamBuilder(
              stream: timeSlots,
              builder: (context, snapshot) {
                return snapshot.hasData
                    ? Padding(
                        padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                        child: GroupButton(
                          controller: timeController,
                          options: GroupButtonOptions(
                            selectedColor: primaryColor,
                            unselectedColor:
                                const Color.fromARGB(255, 240, 226, 213),
                            borderRadius: BorderRadius.circular(20),
                            selectedTextStyle:
                                const TextStyle(fontSize: 20, color: black),
                            unselectedTextStyle:
                                const TextStyle(fontSize: 20, color: black),
                            spacing: 10,
                            runSpacing: 10,
                            groupingType: GroupingType.wrap,
                            direction: Axis.horizontal,
                            buttonHeight: 50,
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
                            for (var i = 0; i < snapshot.data.docs.length; i++)
                              "${snapshot.data.docs[i].get("Time")}:00",
                          ],
                          onSelected: (value, index, isSelected) async {
                            _time = value;

                            _timeId = snapshot.data.docs[index].reference.id
                                .toString();
                            setState(() {});
                          },
                        ),
                      )
                    : const Center(child: CircularProgressIndicator());
              },
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(
              thickness: 2,
              color: primaryColor,
              endIndent: 25,
              indent: 25,
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
                          backgroundColor:
                              MaterialStateProperty.all<Color>(primaryColor),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ))),
                      onPressed: () async {
                        if (report == null) {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.error,
                            animType: AnimType.rightSlide,
                            headerAnimationLoop: false,
                            title: 'Error',
                            desc: 'You must select report',
                          ).show();
                        } else {
                          var index = timeController.selectedIndex;
                          if (index != null) {
                            Appointment app = Appointment(
                                reportId: report!.reportId,
                                doctorId: widget.doctor.id,
                                patientId:
                                    FirebaseAuth.instance.currentUser!.uid,
                                status: "In Progress",
                                date: _date,
                                time: _time,
                                rate: 0);
                            var result = await AddAppointment(
                                app: app,
                                context: context,
                                scheduleId: _scheduleId,
                                timeId: _timeId);
                            if (result == "Added") {
                              Navigator.pop(context);
                            } else if (result == "Error") {
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.error,
                                animType: AnimType.rightSlide,
                                headerAnimationLoop: false,
                                title: 'Error',
                                desc: 'There is an appointment in that day',
                              ).show();
                            }
                          } else {
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.error,
                              animType: AnimType.rightSlide,
                              headerAnimationLoop: false,
                              title: 'Error',
                              desc: 'You must select time',
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
        ));
  }
}
