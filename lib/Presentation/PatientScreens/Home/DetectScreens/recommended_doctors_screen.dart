import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sos_app/Presentation/Views/recommended_doctor_card.dart';
import '../../../../Data/Models/doctor.dart';
import '../../../Styles/colors.dart';
import '../Doctors/doctor_page_screen.dart';
import 'package:custom_marker/marker_icon.dart';

class RecommendedDoctorsScreen extends StatefulWidget {
  List<Doctor> doctors;
  RecommendedDoctorsScreen({Key? key, required this.doctors}) : super(key: key);

  @override
  State<RecommendedDoctorsScreen> createState() =>
      _RecommendedDoctorsScreenState();
}

CameraPosition? kGooglePlex;

var lat;
var long;
List<Placemark> placemarks = [];

late GoogleMapController gmc;

Set<Marker> mymarkers = {};

class _RecommendedDoctorsScreenState extends State<RecommendedDoctorsScreen> {
  _setMarkers() async {
    for (var doctor in widget.doctors) {
      mymarkers.add(Marker(
          markerId: MarkerId("${doctor.id}"),
          position: LatLng(double.parse(doctor.addressLat),
              double.parse(doctor.addressLong)),
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
    _getLatAndLong();
    _setMarkers();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: const Color.fromARGB(253, 243, 222, 195),
        appBar: AppBar(
          title: const Text(
            "\t\tRecommeded Doctors",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
          ),
          centerTitle: true,
          toolbarHeight: 60.2,
          elevation: 4,
          backgroundColor: primaryColor,
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            Container(
              height: 310,
              child: kGooglePlex == null
                  ? CircularProgressIndicator()
                  : GoogleMap(
                      mapType: MapType.normal,
                      initialCameraPosition: kGooglePlex!,
                      onMapCreated: (GoogleMapController controller) {
                        gmc = controller;
                      },
                      markers: mymarkers,
                    ),
            ),
            Container(
              height: 313,
              color: const Color.fromARGB(253, 243, 222, 195),
              //width: MediaQuery.of(context).size.width * 0.65,

              child: Column(children: <Widget>[
                Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.all(11),
                          child: Column(
                            children: [
                              for (var doctor in widget.doctors)
                                RecommendedDoctorCard(doctor: doctor)
                            ],
                          ))
                    ])
              ]),
            )
          ]),
        ));
  }
}
