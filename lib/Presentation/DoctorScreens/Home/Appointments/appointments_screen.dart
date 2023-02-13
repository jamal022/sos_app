import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sos_app/Data/Models/ReportModel.dart';
import 'package:sos_app/Data/Models/ScheduleModel.dart';
import 'package:sos_app/Presentation/DoctorScreens/Home/Appointments/report_screen.dart';
import '../../../../Data/Models/AppointmentModel.dart';
import '../../../Styles/colors.dart';
import '../../../Styles/fonts.dart';

class AppointmentsScreen extends StatefulWidget {
  AppointmentsScreen({Key? key}) : super(key: key);

  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

List<Appointment> appointments = [];

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  _getApp() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = prefs.getString("Id");
    appointments = await GetDoctorAppointments(id);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _getApp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(253, 243, 222, 195),
        appBar: AppBar(
          title: const Text(
            "My Appointments",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
          ),
          centerTitle: true,
          toolbarHeight: 60.2,
          elevation: 4,
          backgroundColor: primaryColor,
        ),
        body: appointments.isEmpty
            ? const Center(
                child: Text("There is no appointments"),
              )
            : Column(children: [
                for (var i = 0; i < appointments.length; i++)
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      height: 150,
                      padding: const EdgeInsets.fromLTRB(20.0, 8.0, 0.0, 0.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Row(children: [
                        Column(
                          children: [
                            const Text(
                              'Patient Name',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(appointments[i].patientName,
                                style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 16,
                                    color: Colors.black.withOpacity(0.5))),
                            Container(
                              padding:
                                  const EdgeInsets.fromLTRB(0.0, 35.0, 0.0, 0),
                              child: MaterialButton(
                                  elevation: 5.0,
                                  color: const Color.fromARGB(255, 36, 121, 39),
                                  padding: const EdgeInsets.all(10),
                                  shape: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide.none,
                                  ),
                                  onPressed: () {
                                    showDialog(
                                      useSafeArea: false,
                                      context: context,
                                      barrierColor: splashBack,
                                      builder: (ctx) => AlertDialog(
                                        content: const Text(
                                            "Are you sure, this appointment is ended?",
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
                                                      const EdgeInsets.all(8.0),
                                                  child: OutlinedButton(
                                                    onPressed: () {
                                                      Navigator.pop(ctx);
                                                    },
                                                    child: const Text(
                                                      "Cancel",
                                                      style: TextStyle(
                                                        color: primaryColor,
                                                        fontSize: contentFont,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),

                                              Expanded(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: MaterialButton(
                                                    elevation: 6.0,
                                                    color: Colors.redAccent,
                                                    onPressed: () async {
                                                      await DeleteAppointmentFromSchedule(
                                                          doctorId:
                                                              appointments[i]
                                                                  .doctorId,
                                                          date: appointments[i]
                                                              .date);
                                                      var result =
                                                          await ChangeAppointmentToEnded(
                                                              appointments[i]);
                                                      if (result == "changed") {
                                                        Navigator.pop(ctx);
                                                        _getApp();
                                                      }
                                                    },
                                                    child: const Text(
                                                      'Ended',
                                                      style: TextStyle(
                                                        color: white,
                                                        fontSize: contentFont,
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
                                  child: const Text(
                                    '  Done  ',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            const Text(
                              '      Date',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text('       ${appointments[i].date}',
                                style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 16,
                                    color: Colors.black.withOpacity(0.5))),
                          ],
                        ),
                        Column(
                          children: [
                            const Text(
                              'Time',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text('${appointments[i].time}\n\n',
                                style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 16,
                                    color: Colors.black.withOpacity(0.5))),
                            Container(
                              padding:
                                  const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                              child: MaterialButton(
                                  elevation: 5.0,
                                  color: primaryColor,
                                  padding: const EdgeInsets.all(10),
                                  shape: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide.none,
                                  ),
                                  onPressed: () async {
                                    Report report = await GetReportById(
                                        appointments[i].reportId);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ReportScreen(
                                                report: report,
                                              )),
                                    );
                                  },
                                  child: const Text(
                                    'View Report',
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
              ]));
  }
}
