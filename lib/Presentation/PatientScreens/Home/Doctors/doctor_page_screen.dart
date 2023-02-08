import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sos_app/Data/Models/ReportModel.dart';
import 'package:sos_app/Data/Models/ScheduleModel.dart';
import 'package:sos_app/Presentation/PatientScreens/Home/Doctors/add_appointment_screen.dart';
import '../../../../Data/Models/doctor.dart';
import '../../../../Data/Models/patient.dart';
import '../../../Styles/colors.dart';

class DoctorPageScreen extends StatefulWidget {
  Doctor doctor;
  DoctorPageScreen({Key? key, required this.doctor}) : super(key: key);

  @override
  State<DoctorPageScreen> createState() => _DoctorPageScreen();
}

class _DoctorPageScreen extends State<DoctorPageScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    //height: size. height /4
    return Scaffold(
        backgroundColor: const Color.fromARGB(253, 243, 222, 195),
        appBar: AppBar(
          title: Text(
            widget.doctor.username,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
          ),
          centerTitle: true,
          toolbarHeight: 60.2,
          elevation: 4,
          backgroundColor: primaryColor,
        ),
        body: Container(
            child: Center(
                child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                maxRadius: 80,
                backgroundImage: NetworkImage(
                  widget.doctor.image,
                ),
              ),
            ),
            Container(
                height: 80,
                child: Row(
                  children: [
                    Expanded(
                        child: Container(
                      padding: const EdgeInsets.all(16.0),
                      child: FloatingActionButton.extended(
                        shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        onPressed: () {},
                        icon: const Icon(
                          Icons.message_outlined,
                          size: 25,
                          color: Colors.black,
                        ),
                        backgroundColor: primaryColor,
                        label: const Text(
                          'Message',
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 18,
                              color: Colors.white),
                        ),
                      ),
                    )),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                        child: Container(
                      padding: const EdgeInsets.all(16.0),
                      child: FloatingActionButton.extended(
                        shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        onPressed: () {},
                        icon: const Icon(
                          Icons.newspaper_outlined,
                          size: 25,
                          color: Colors.black,
                        ),
                        backgroundColor: primaryColor,
                        label: const Text('Articles',
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 18,
                                color: Colors.white)),
                      ),
                    ))
                  ],
                )),
            Container(
                height: size.height / 11,
                width: size.width / 1.2,
                margin: const EdgeInsets.symmetric(horizontal: 35),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(children: <Widget>[
                  Row(children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.doctor.field,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          Text('Address',
                              style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 16,
                                  color: Colors.black.withOpacity(0.5)))
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.location_on_rounded,
                                size: 30,
                                color: Colors.black,
                              ))
                        ],
                      ),
                    ),
                  ]),
                ])),
            const SizedBox(
              height: 15,
            ),
            Container(
              height: size.height / 6,
              width: size.width / 1.2,
              margin: const EdgeInsets.symmetric(horizontal: 35),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  widget.doctor.bio,
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.5), fontSize: 20),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Container(
                height: size.height / 11,
                width: size.width / 1.2,
                margin: const EdgeInsets.symmetric(horizontal: 35),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Experience',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        Text(widget.doctor.experience,
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 16,
                                color: Colors.black.withOpacity(0.5)))
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    color: Colors.grey.withOpacity(0.4),
                    width: 1,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Price',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        Text('\$${widget.doctor.price}',
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 16,
                                color: Colors.black.withOpacity(0.5)))
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    color: Colors.grey.withOpacity(0.4),
                    width: 1,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Articles',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        Text('6',
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 16,
                                color: Colors.black.withOpacity(0.5)))
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    color: Colors.grey.withOpacity(0.4),
                    width: 1,
                  ),
                ])),
            const SizedBox(height: 15),
            Container(
              child: MaterialButton(
                elevation: 5.0,
                color: primaryColor,
                padding: const EdgeInsets.all(15),
                shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                onPressed: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  Patient patient = Patient(
                      id: prefs.getString("Id"),
                      username: prefs.getString("FullName"),
                      email: prefs.getString("Email"),
                      age: prefs.getString("Age"),
                      gender: prefs.getString("Gender"),
                      image: prefs.getString("Image"),
                      password: prefs.getString("Password"),
                      phoneNumber: prefs.getString("PhoneNumber"));

                  List<Schedule> schedules =
                      await GetSchedulesForPatient(widget.doctor.id);
                  List<Report> reports = await GetReports(patient, context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddAppointmentScreen(
                            schedules: schedules,
                            doctor: widget.doctor,
                            reports: reports),
                      ));
                },
                child: const Text(
                  'Make an Appointment',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        ))));
  }
}
