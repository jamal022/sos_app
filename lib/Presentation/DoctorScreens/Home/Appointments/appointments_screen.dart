import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sos_app/Data/Models/ReportModel.dart';
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
bool _flag = false;

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  _getApp() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var id = prefs.getString("Id");
    var name = prefs.getString("FullName");
    appointments = await GetDoctorAppointments(id, name);
    _flag = true;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _getApp();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: back,
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
        body: SingleChildScrollView(
            child: _flag == true
                ? appointments.length != 0
                    ? Column(children: [
                        for (var i = 0; i < appointments.length; i++)
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
                                        'Patient Name',
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
                                        Text("${appointments[i].patientName}",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w800,
                                                fontSize: 16,
                                                color: Colors.black
                                                    .withOpacity(0.5))),
                                        SizedBox(
                                          width: size.width / 10,
                                        ),
                                        Text('${appointments[i].date}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w800,
                                                fontSize: 16,
                                                color: Colors.black
                                                    .withOpacity(0.5))),
                                        SizedBox(
                                          width: size.width / 15,
                                        ),
                                        Text('${appointments[i].time}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.w800,
                                                fontSize: 16,
                                                color: Colors.black
                                                    .withOpacity(0.5))),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(8, 10, 8, 10),
                                    child: Row(
                                      children: [
                                        IconButton(
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
                                                                  .green
                                                                  .shade800,
                                                              onPressed:
                                                                  () async {
                                                                var result = await ChangeAppointmentToEnded(
                                                                    appId: appointments[
                                                                            i]
                                                                        .appointmentId,
                                                                    date: appointments[
                                                                            i]
                                                                        .date,
                                                                    patientId:
                                                                        appointments[i]
                                                                            .patientId);
                                                                if (result ==
                                                                    "changed") {
                                                                  Navigator.pop(
                                                                      ctx);
                                                                  _getApp();
                                                                }
                                                              },
                                                              child: const Text(
                                                                'Ended',
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
                                            icon: const Icon(
                                              Icons.done_outlined,
                                              size: 40,
                                              color: Colors.green,
                                            )),
                                        SizedBox(
                                          width: size.width / 25,
                                        ),
                                        IconButton(
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
                                                                var result = await DeleteAppointment(
                                                                    appId: appointments[
                                                                            i]
                                                                        .appointmentId,
                                                                    date: appointments[
                                                                            i]
                                                                        .date,
                                                                    doctorName:
                                                                        appointments[i]
                                                                            .doctorName,
                                                                    patientId:
                                                                        appointments[i]
                                                                            .patientId,
                                                                    doctorId:
                                                                        appointments[i]
                                                                            .doctorId,
                                                                    role:
                                                                        "Doctor");
                                                                if (result ==
                                                                    "deleted") {
                                                                  Navigator.pop(
                                                                      ctx);
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
                                            icon: const Icon(
                                              Icons.cancel_outlined,
                                              size: 40,
                                              color: Colors.red,
                                            )),
                                        SizedBox(
                                          width: size.width / 8,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 10, 0, 0),
                                          child: MaterialButton(
                                              elevation: 5.0,
                                              color: primaryColor,
                                              padding: const EdgeInsets.all(10),
                                              shape: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                borderSide: BorderSide.none,
                                              ),
                                              onPressed: () async {
                                                Report report =
                                                    await GetSpecificReport(
                                                        appointments[i]
                                                            .reportId);
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ReportScreen(
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
                                  ),
                                ]),
                              ),
                            ),
                          ),
                      ])
                    : Container(
                        height: size.height,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              const Padding(
                                  padding: EdgeInsets.fromLTRB(25, 2, 25, 5)),
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
                        ),
                      )
                : const Center(
                    child: CircularProgressIndicator(),
                  )));
  }
}
