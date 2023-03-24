import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:sos_app/Presentation/AdminScreens/Hospitals/add_hospital_screen.dart';
import 'package:sos_app/Presentation/AdminScreens/Hospitals/edit_hospital_screen.dart';
import 'package:sos_app/Presentation/AdminScreens/Hospitals/update_hospital_address.dart';
import '../../../Data/Models/HospitalModel.dart';
import '../../Styles/colors.dart';
import '../../Styles/fonts.dart';

class AdminHospitalPageScreen extends StatefulWidget {
  Hospital hospital;
  AdminHospitalPageScreen({super.key, required this.hospital});

  @override
  State<AdminHospitalPageScreen> createState() =>
      _AdminHospitalPageScreenState();
}

CameraPosition? kGooglePlex;

List<Placemark> placemarks = [];

late GoogleMapController gmc;

Set<Marker> mymarkers = {};

class _AdminHospitalPageScreenState extends State<AdminHospitalPageScreen> {
  Future _getLatAndLong() async {
    kGooglePlex = CameraPosition(
      target: LatLng(double.parse(widget.hospital.addressLang.toString()),
          double.parse(widget.hospital.addressLong.toString())),
      zoom: 12.0,
    );

    mymarkers.add(Marker(
      markerId: const MarkerId("initial"),
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
        backgroundColor: adminback,
        appBar: AppBar(
          title: Text(
            "\t\t${widget.hospital.name}",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          centerTitle: true,
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
                            hospital: widget.hospital,
                          )),
                );
                if (result == "refresh") {
                  Navigator.pop(context, "refresh");
                }
              },
              icon: const Icon(Icons.edit, color: white, size: 30),
            ),
            IconButton(
              onPressed: () {
                showDialog(
                  useSafeArea: false,
                  context: context,
                  barrierColor: splashBack,
                  builder: (ctx) => AlertDialog(
                    content: const Text(
                        "Are you sure, you want to delete this hospital?",
                        style: TextStyle(
                          fontSize: contentFont,
                        )),
                    actions: [
                      Row(
                        children: [
                          //btn cancel
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: OutlinedButton(
                                onPressed: () {
                                  Navigator.pop(ctx);
                                },
                                child: const Text(
                                  "Cancel",
                                  style: TextStyle(
                                    color: black,
                                    fontSize: contentFont,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: MaterialButton(
                                elevation: 6.0,
                                color: Colors.redAccent,
                                onPressed: () async {
                                  var res = await DeleteHospital(
                                      widget.hospital.hospitalId, context);
                                  if (res == "deleted") {
                                    Navigator.pop(context, "refresh");
                                  }
                                },
                                child: const Text(
                                  'Sure',
                                  style: TextStyle(
                                    color: white,
                                    fontSize: contentFont,
                                    fontWeight: FontWeight.bold,
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
              icon: const Icon(Icons.delete, color: white, size: 30),
            ),
          ],
        ),
        body: widget.hospital != null
            ? SingleChildScrollView(
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
                            "  ${widget.hospital.telephone1}\n  ${widget.hospital.telephone2}",
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
                            "  ${widget.hospital.ambulancePhone}",
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
                            "  ${widget.hospital.email}",
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
                          title: Row(
                            children: [
                              const Text(
                                "Visit our Location",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              IconButton(
                                onPressed: () async {
                                  var result = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            UpdateHospitalAddressScreen(
                                              hospitalId:
                                                  widget.hospital.hospitalId,
                                              lat: widget.hospital.addressLang,
                                              long: widget.hospital.addressLong,
                                            )),
                                  );
                                  if (result == "refresh") {
                                    Navigator.pop(context, "refresh");
                                  }
                                },
                                icon: const Icon(Icons.edit_location_alt,
                                    color: black, size: 28),
                              ),
                            ],
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
              )
            : const Center(
                child: CircularProgressIndicator(),
              ));
  }
}
