import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sos_app/Data/Models/doctor.dart';

import '../../Styles/colors.dart';
import '../../Styles/fonts.dart';

class UpdateAddressScreen extends StatefulWidget {
  final lat;
  final long;
  final doctor;
  UpdateAddressScreen(
      {super.key, required this.doctor, required this.lat, required this.long});

  @override
  State<UpdateAddressScreen> createState() => _UpdateAddressScreenState();
}

class _UpdateAddressScreenState extends State<UpdateAddressScreen> {
  CameraPosition? kGooglePlex;
  var latitude;
  var longitude;
  List<Placemark> placemarks = [];
  late GoogleMapController gmc;
  Set<Marker> mymarkers = {};

  Future _getLatAndLong() async {
    latitude = double.parse(widget.lat);
    longitude = double.parse(widget.long);
    kGooglePlex = CameraPosition(
      target: LatLng(latitude, longitude),
      zoom: 12.0,
    );

    mymarkers.add(Marker(
        markerId: const MarkerId("initial"),
        position: LatLng(latitude, longitude),
        draggable: true,
        onDrag: ((LatLng t) {
          latitude = t.latitude;
          longitude = t.longitude;
        })));
    placemarks = await placemarkFromCoordinates(latitude, longitude);
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
      backgroundColor: back,
      appBar: AppBar(
        title: const Text(
          "Update Address",
          style:
              TextStyle(fontWeight: FontWeight.bold, fontSize: formTitleFont),
        ),
        centerTitle: true,
        toolbarHeight: 60.2,
        elevation: 5.00,
        backgroundColor: primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Container(
              height: 400,
              child: kGooglePlex == null
                  ? Center()
                  : GoogleMap(
                      mapType: MapType.normal,
                      initialCameraPosition: kGooglePlex!,
                      onMapCreated: (GoogleMapController controller) {
                        gmc = controller;
                      },
                      markers: mymarkers,
                    ),
            ),
            const SizedBox(
              height: 20,
            ),
            MaterialButton(
                elevation: 5.0,
                color: primaryColor,
                padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide.none,
                ),
                onPressed: () async {
                  await UpdateAddress(
                      context: context,
                      doctor: widget.doctor,
                      lat: latitude,
                      long: longitude);
                },
                child: const Text(
                  'Update',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: formButtonFont,
                    fontWeight: FontWeight.bold,
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
