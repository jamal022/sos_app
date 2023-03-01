import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sos_app/Data/Models/ArticlesModel.dart';
import 'package:sos_app/Data/Models/ReportModel.dart';
import 'package:sos_app/Data/Models/ScheduleModel.dart';
import 'package:sos_app/Presentation/PatientScreens/Home/Doctors/add_appointment_screen.dart';
import 'package:sos_app/Presentation/PatientScreens/Home/Doctors/doctor_articles_screen.dart';
import '../../../../Data/Models/doctor.dart';
import '../../../../Data/Models/patient.dart';
import '../../../Screens/Chats/chat_page_screen.dart';
import '../../../Styles/colors.dart';

class DoctorPageScreen extends StatefulWidget {
  Doctor doctor;
  DoctorPageScreen({Key? key, required this.doctor}) : super(key: key);

  @override
  State<DoctorPageScreen> createState() => _DoctorPageScreen();
}

CameraPosition? kGooglePlex;

List<Placemark> placemarks = [];

late GoogleMapController gmc;

Set<Marker> mymarkers = {};

Patient patient = Patient();
var articlesNb = 0;

class _DoctorPageScreen extends State<DoctorPageScreen> {
  _getArticlesNb() async {
    articlesNb = await GetArticlesNb(widget.doctor.id);
    setState(() {});
  }

  Future _getLatAndLong() async {
    kGooglePlex = CameraPosition(
      target: LatLng(double.parse(widget.doctor.addressLat),
          double.parse(widget.doctor.addressLong)),
      zoom: 12.0,
    );

    mymarkers.add(Marker(
      markerId: const MarkerId("initial"),
      position: LatLng(double.parse(widget.doctor.addressLat),
          double.parse(widget.doctor.addressLong)),
    ));
    placemarks = await placemarkFromCoordinates(
        double.parse(widget.doctor.addressLat),
        double.parse(widget.doctor.addressLong));
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _getLatAndLong();
    _getArticlesNb();
    () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      patient.id = prefs.getString("Id");
      patient.username = prefs.getString("FullName");
      patient.email = prefs.getString("Email");
      patient.phoneNumber = prefs.getString("PhoneNumber");
      patient.password = prefs.getString("Password");
      patient.age = prefs.getString("Age");
      patient.gender = prefs.getString("Gender");
      patient.image = prefs.getString("Image");
      setState(() {});
    }();
  }

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
                        onPressed: () {
                          Doctor doc = Doctor(
                              username: widget.doctor.username,
                              email: widget.doctor.email,
                              phoneNumber: widget.doctor.phoneNumber,
                              password: widget.doctor.password,
                              age: widget.doctor.age,
                              gender: widget.doctor.gender,
                              image: widget.doctor.image,
                              field: widget.doctor.field,
                              experience: widget.doctor.experience,
                              price: widget.doctor.price,
                              addressLat: widget.doctor.addressLat,
                              addressLong: widget.doctor.addressLong,
                              bio: widget.doctor.bio);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChatPageScreen(
                                    currentuser: patient.id,
                                    peerId: widget.doctor.id,
                                    groupChatId:
                                        "${widget.doctor.username}-${patient.username}",
                                    currentimage: patient.image,
                                    peerimage: widget.doctor.image,
                                    peername: widget.doctor.username,
                                    currentname: patient.username)),
                          );
                        },
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
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DoctotArticlesScreen(
                                      doctor: widget.doctor,
                                    )),
                          );
                        },
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
                        children: [
                          Text(
                            widget.doctor.field,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          Text(
                              '${placemarks[0].locality},${placemarks[0].country}',
                              style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 14,
                                  color: Colors.black.withOpacity(0.5)))
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          height: 60,
                          width: 50,
                          child: GoogleMap(
                            mapType: MapType.normal,
                            initialCameraPosition: kGooglePlex!,
                            onMapCreated: (GoogleMapController controller) {
                              gmc = controller;
                            },
                            markers: mymarkers,
                            onTap: (argument) {
                              MapsLauncher.launchCoordinates(
                                  argument.latitude,
                                  argument.longitude,
                                  "${widget.doctor.username}'s location");
                            },
                          ),
                        ),
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
                        Text('${articlesNb}',
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
                  await Navigator.push(
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
