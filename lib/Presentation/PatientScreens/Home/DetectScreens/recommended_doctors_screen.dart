import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sos_app/Presentation/Views/recommended_doctor_card.dart';
import '../../../../Data/Models/doctor.dart';
import '../../../Styles/colors.dart';
import '../Doctors/doctor_page_screen.dart';
import 'package:custom_marker/marker_icon.dart';

class RecommendedDoctorsScreen extends StatefulWidget {
  RecommendedDoctorsScreen({Key? key}) : super(key: key);

  @override
  State<RecommendedDoctorsScreen> createState() =>
      _RecommendedDoctorsScreenState();
}

CameraPosition? kGooglePlex;
List<Doctor> _doctors = [];
var lat;
var long;
List<Placemark> placemarks = [];

late GoogleMapController gmc;

Set<Marker> mymarkers = {};

class _RecommendedDoctorsScreenState extends State<RecommendedDoctorsScreen> {
  _getDoctors() async {
    _getPosition();
    _doctors = await GetRecommendedDoctors(lat, long);
    _setMarkers();
    setState(() {});
  }

  _setMarkers() async {
    for (var doctor in _doctors) {
      mymarkers.add(Marker(
          markerId: MarkerId("${doctor.id}"),
          position: LatLng(doctor.addressLat, doctor.addressLong),
          infoWindow: InfoWindow(
              title: doctor.username,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DoctorPageScreen(
                            doctor: doctor,
                          )),
                );
              }),
          icon: await MarkerIcon.downloadResizePictureCircle(doctor.image,
              size: 100, borderColor: black, borderSize: 15, addBorder: true)));
    }
  }

  Future _getPosition() async {
    bool services;
    LocationPermission permission;

    services = await Geolocator.isLocationServiceEnabled();
    if (services == false) {
      services = await Geolocator.openLocationSettings();
    }
    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      _getLatAndLong();
    }
  }

  Future _getLatAndLong() async {
    Position currentLocation =
        await Geolocator.getCurrentPosition().then((value) => value);

    lat = currentLocation.latitude;
    long = currentLocation.longitude;
    kGooglePlex = CameraPosition(
      target: LatLng(lat, long),
      zoom: 12.0,
    );

    mymarkers.add(Marker(
      markerId: MarkerId("initial"),
      position: LatLng(lat, long),
    ));
    placemarks = await placemarkFromCoordinates(lat, long);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _getDoctors();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: back,
        appBar: AppBar(
          title: const Text(
            "Recommeded Doctors",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          centerTitle: true,
          toolbarHeight: 60.2,
          elevation: 4,
          backgroundColor: primaryColor,
          leading: IconButton(
              onPressed: () {
                placemarks.clear();
                mymarkers.clear();
                kGooglePlex = null;
                _doctors.clear();
                setState(() {});
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_sharp)),
        ),
        body: SingleChildScrollView(
          child: kGooglePlex == null
              ? Container(
                  height: size.height,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : Column(children: [
                  Container(
                    height: 310,
                    child: GoogleMap(
                      mapType: MapType.normal,
                      initialCameraPosition: kGooglePlex!,
                      onMapCreated: (GoogleMapController controller) {
                        gmc = controller;
                      },
                      markers: mymarkers,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Column(children: <Widget>[
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.all(11),
                              child: _doctors.length != 0
                                  ? Column(
                                      children: [
                                        for (var doctor in _doctors)
                                          RecommendedDoctorCard(doctor: doctor)
                                      ],
                                    )
                                  : Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          const Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  25, 2, 25, 5)),
                                          const Icon(
                                            Icons.warning_amber_rounded,
                                            size: 100,
                                            color: primaryColor,
                                          ),
                                          SizedBox(
                                            height: size.height / 40,
                                          ),
                                          const Text(
                                            'There is no Doctors',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: primaryColor),
                                          ),
                                        ],
                                      ),
                                    ))
                        ])
                  ]),
                ]),
        ));
  }
}
