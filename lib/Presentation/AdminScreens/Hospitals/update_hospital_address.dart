import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sos_app/Data/Models/HospitalModel.dart';
import 'package:sos_app/Presentation/Styles/colors.dart';
import 'package:sos_app/Presentation/Styles/fonts.dart';

class UpdateHospitalAddressScreen extends StatefulWidget {
  final lat;
  final long;
  final hospitalId;
  UpdateHospitalAddressScreen(
      {super.key,
      required this.hospitalId,
      required this.lat,
      required this.long});

  @override
  State<UpdateHospitalAddressScreen> createState() =>
      _UpdateHospitalAddressScreenState();
}

class _UpdateHospitalAddressScreenState
    extends State<UpdateHospitalAddressScreen> {
  CameraPosition? kGooglePlex;
  var latitude;
  var longitude;
  List<Placemark> placemarks = [];
  late GoogleMapController gmc;
  Set<Marker> mymarkers = {};

  Future _getLatAndLong() async {
    latitude = double.parse(widget.lat.toString());
    longitude = double.parse(widget.long.toString());
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
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: adminback,
      appBar: AppBar(
        title: const Text(
          "Update Address",
          style:
              TextStyle(fontWeight: FontWeight.bold, fontSize: formTitleFont),
        ),
        centerTitle: true,
        toolbarHeight: 60.2,
        elevation: 5.00,
        backgroundColor: black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Center(
              child: Container(
                height: size.height / 2,
                width: size.width / 1.3,
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
            ),
            const SizedBox(
              height: 20,
            ),
            MaterialButton(
                elevation: 5.0,
                color: black,
                padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide.none,
                ),
                onPressed: () async {
                  await UpdateHospitalAddress(
                      widget.hospitalId, latitude, longitude, context);
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
