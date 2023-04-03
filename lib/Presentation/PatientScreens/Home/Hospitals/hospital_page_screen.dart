import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_launcher/maps_launcher.dart';
import '../../../../Data/Models/HospitalModel.dart';
import '../../../Styles/colors.dart';

class HospitalPageScreen extends StatefulWidget {
  Hospital hospital;
  HospitalPageScreen({super.key, required this.hospital});

  @override
  State<HospitalPageScreen> createState() => _HospitalPageScreenState();
}

CameraPosition? kGooglePlex;

List<Placemark> placemarks = [];

late GoogleMapController gmc;

Set<Marker> mymarkers = {};

class _HospitalPageScreenState extends State<HospitalPageScreen> {
  Future _getLatAndLong() async {
    kGooglePlex = CameraPosition(
      target: LatLng(double.parse(widget.hospital.addressLang.toString()),
          double.parse(widget.hospital.addressLong.toString())),
      zoom: 12.0,
    );

    mymarkers.add(Marker(
      markerId: MarkerId("initial"),
      position: LatLng(double.parse(widget.hospital.addressLang.toString()),
          double.parse(widget.hospital.addressLong.toString())),
    ));
    placemarks = await placemarkFromCoordinates(
        double.parse(widget.hospital.addressLang.toString()),
        double.parse(widget.hospital.addressLong.toString()));
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _getLatAndLong();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(253, 243, 222, 195),
        appBar: AppBar(
          title: Text(
            "\t\t${widget.hospital.name}",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
          ),
          centerTitle: true,
          toolbarHeight: 60.2,
          elevation: 4,
          backgroundColor: primaryColor,
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    image: DecorationImage(
                      image: NetworkImage(widget.hospital.image),
                      fit: BoxFit.fill,
                    )),
                height: 220,
              ),
            ),
            Container(
                child: Column(children: <Widget>[
              Card(
                elevation: 5,
                margin: const EdgeInsets.fromLTRB(15.0, 10, 15, 10),
                color: white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: const Icon(
                      Icons.phone_android_outlined,
                      size: 45,
                      color: black,
                    ),
                    title: const Text(
                      "Give us a Call",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      "  ${widget.hospital.telephone1}\n  ${widget.hospital.telephone2}",
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),
              Card(
                elevation: 5,
                margin: const EdgeInsets.fromLTRB(15.0, 10, 15, 10),
                color: white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: const Icon(
                      Icons.phone,
                      size: 45,
                      color: black,
                    ),
                    title: const Text(
                      "Give us an Ambulance Call",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      "  ${widget.hospital.ambulancePhone}",
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),
              Card(
                elevation: 5,
                margin: const EdgeInsets.fromLTRB(15.0, 10, 15, 10),
                color: white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: const Icon(
                      Icons.mail_outlined,
                      size: 45,
                      color: black,
                    ),
                    title: const Text(
                      "Send us a message",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      "  ${widget.hospital.email}",
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),
              Card(
                elevation: 5,
                margin: const EdgeInsets.fromLTRB(15.0, 10, 15, 10),
                color: white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: const Icon(
                      Icons.location_on_outlined,
                      size: 45,
                      color: black,
                    ),
                    title: const Text(
                      "Visit our Location",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Container(
                      height: 150,
                      width: 60,
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
                              "${widget.hospital.name}'s location");
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ])),
          ]),
        ));
  }
}
