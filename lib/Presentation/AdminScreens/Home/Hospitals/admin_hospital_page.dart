import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:sos_app/Presentation/AdminScreens/Home/Hospitals/edit_hospital_screen.dart';
import '../../../../Data/Models/HospitalModel.dart';
import '../../../Styles/colors.dart';

class AdminHospitalPageScreen extends StatefulWidget {
  var id;
  AdminHospitalPageScreen({super.key, required this.id});

  @override
  State<AdminHospitalPageScreen> createState() =>
      _AdminHospitalPageScreenState();
}

CameraPosition? kGooglePlex;

List<Placemark> placemarks = [];

late GoogleMapController gmc;

Set<Marker> mymarkers = {};
Hospital hospital = Hospital();

class _AdminHospitalPageScreenState extends State<AdminHospitalPageScreen> {
  _getHospital() async {
    hospital = await GetSpecificHospital(widget.id);
    setState(() {});
  }

  Future _getLatAndLong() async {
    _getHospital();
    kGooglePlex = CameraPosition(
      target: LatLng(double.parse(hospital.addressLang),
          double.parse(hospital.addressLong)),
      zoom: 12.0,
    );

    mymarkers.add(Marker(
      markerId: const MarkerId("initial"),
      position: LatLng(double.parse(hospital.addressLang),
          double.parse(hospital.addressLong)),
    ));
    placemarks = await placemarkFromCoordinates(
        double.parse(hospital.addressLang), double.parse(hospital.addressLong));
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
        backgroundColor: adminback,
        appBar: AppBar(
          title: Text(
            "\t\t${hospital.name}",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          //centerTitle: true,
          toolbarHeight: 60.2,
          elevation: 4,
          backgroundColor: black,
          actions: [
            IconButton(
              onPressed: () async {
                var result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EditHospitalScreen(
                            hospital: hospital,
                          )),
                );
                if (result == "refresh") {
                  _getHospital();
                }
              },
              icon: const Icon(Icons.edit, color: white, size: 30),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.delete, color: white, size: 30),
            ),
          ],
        ),
        body: hospital != null
            ? SingleChildScrollView(
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          image: DecorationImage(
                            image: NetworkImage(hospital.image),
                            fit: BoxFit.fill,
                          )),
                      height: 220,
                    ),
                  ),
                  Container(
                      child: Column(children: <Widget>[
                    Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      margin: const EdgeInsets.fromLTRB(15.0, 10, 15, 10),
                      color: admincard,
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
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            "  ${hospital.telephone1}\n  ${hospital.telephone2}",
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                    Card(
                      elevation: 5,
                      margin: const EdgeInsets.fromLTRB(15.0, 10, 15, 10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      color: admincard,
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
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            "  ${hospital.ambulancePhone}",
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                    Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      margin: const EdgeInsets.fromLTRB(15.0, 10, 15, 10),
                      color: admincard,
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
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            "  ${hospital.email}",
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                    Card(
                      elevation: 5,
                      margin: const EdgeInsets.fromLTRB(15.0, 10, 15, 10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      color: admincard,
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
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
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
                                    "${hospital.name}'s location");
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ])),
                ]),
              )
            : const Center(
                child: CircularProgressIndicator(),
              ));
  }
}
