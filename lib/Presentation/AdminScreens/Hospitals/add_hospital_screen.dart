import 'dart:math';
import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sos_app/Presentation/Styles/colors.dart';
import 'package:sos_app/Presentation/Styles/fonts.dart';
import '../../../Data/Models/HospitalModel.dart';
import '../../Widgets/admin_textFormField_widget.dart';

class AddHospitalScreen extends StatefulWidget {
  AddHospitalScreen({Key? key}) : super(key: key);

  @override
  State<AddHospitalScreen> createState() => _AddHospitalScreen();
}

XFile? image;
final ImagePicker picker = ImagePicker();
Reference? ref;
File? file;
String? imageurl;
var hospitalImage;

_addImage() async {
  if (picker != null) {
    file = File(image!.path);
    var rand = Random().nextInt(100000);
    var imagename = "$rand" + basename(image!.path);
    ref = FirebaseStorage.instance.ref("images").child("$imagename");
    await ref!.putFile(file!);
    imageurl = await ref!.getDownloadURL();
    image = null;
    ref = null;
    file = null;

    return imageurl;
  }
}

var nameController = TextEditingController();
var emailController = TextEditingController();
var tele1Controller = TextEditingController();
var tele2Controller = TextEditingController();
var ambulanceController = TextEditingController();

GlobalKey<FormState> formKey = GlobalKey<FormState>();

CameraPosition? kGooglePlex;
var latitude;
var longitude;
List<Placemark> placemarks = [];
late GoogleMapController gmc;
Set<Marker> mymarkers = {};

class _AddHospitalScreen extends State<AddHospitalScreen> {
  Future _getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);
    setState(() {
      image = img;
    });
  }

  Widget bottomSheet(context) {
    return Container(
      height: 150,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          const Text(
            "Choose Hospital Image",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20,
          ),
          Column(
            children: [
              TextButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                  _getImage(ImageSource.camera);
                },
                icon: const Icon(
                  Icons.camera,
                  color: black,
                  size: 25,
                ),
                label: const Text(
                  "Camera",
                  style: TextStyle(color: black, fontSize: 22),
                ),
              ),
              TextButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                  _getImage(ImageSource.gallery);
                },
                icon: const Icon(
                  Icons.image,
                  color: black,
                  size: 25,
                ),
                label: const Text(
                  "Gallery",
                  style: TextStyle(color: black, fontSize: 22),
                ),
              ),
            ],
          )
        ],
      ),
    );
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
    latitude = currentLocation.latitude;
    longitude = currentLocation.longitude;
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
    _getPosition();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: adminback,
      appBar: AppBar(
        title: const Text(
          "Add Hospital",
          style:
              TextStyle(fontWeight: FontWeight.bold, fontSize: formTitleFont),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () {
            image = null;
            nameController.clear();
            emailController.clear();
            tele1Controller.clear();
            tele2Controller.clear();
            ambulanceController.clear();
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        toolbarHeight: 60.2,
        elevation: 5.00,
        backgroundColor: black,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              const SizedBox(height: 20),
              AdminTextFormField(
                hintText: 'Hospital Name',
                icon: Icons.person_rounded,
                type: TextInputType.name,
                textController: nameController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'You must fill the name';
                  }
                  if (value.length > 20) {
                    return 'Must be less than 20 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              AdminTextFormField(
                hintText: 'Hospital Email',
                icon: Icons.email,
                type: TextInputType.emailAddress,
                textController: emailController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'You must fill the email ';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 10),
              AdminTextFormField(
                hintText: 'Telephone 1',
                icon: Icons.phone,
                type: TextInputType.phone,
                textController: tele1Controller,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'You must fill the telephone 1';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 10),
              AdminTextFormField(
                hintText: 'Telephone 2',
                icon: Icons.phone,
                type: TextInputType.phone,
                textController: tele2Controller,
                validator: (value) {},
              ),
              const SizedBox(height: 10),
              AdminTextFormField(
                hintText: 'Ambulance Phone',
                icon: Icons.emergency,
                type: TextInputType.phone,
                textController: ambulanceController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'You must fill the ambulance phone';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.fromLTRB(40, 0, 10, 0),
                child: Row(
                  children: [
                    MaterialButton(
                        elevation: 5.0,
                        color: black,
                        padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                        shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        onPressed: () {
                          showModalBottomSheet(
                              context: context,
                              builder: ((context) => bottomSheet(context)));
                        },
                        child: const Text(
                          'Upload Image',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        )),
                    image != null
                        ? Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.file(
                                //to show image, you type like this.
                                File(image!.path),
                                fit: BoxFit.cover,
                                width: 100,
                                height: 100,
                              ),
                            ),
                          )
                        : const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              "No Image",
                              style: TextStyle(fontSize: 20),
                            ),
                          )
                  ],
                ),
              ),
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
                height: 30,
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
                    var formdata = formKey.currentState;
                    if (formdata!.validate()) {
                      formdata.save();
                      if (image != null) {
                        hospitalImage = await _addImage();
                        Hospital hos = Hospital(
                            name: nameController.text,
                            email: emailController.text,
                            telephone1: tele1Controller.text,
                            telephone2: tele2Controller.text,
                            ambulancePhone: ambulanceController.text,
                            image: hospitalImage,
                            addressLang: latitude,
                            addressLong: longitude);
                        var result = await AddHospital(hos, context);
                        nameController.clear();
                        emailController.clear();
                        tele1Controller.clear();
                        tele2Controller.clear();
                        ambulanceController.clear();
                        if (result == "Added") {
                          Navigator.pop(context, "refresh");
                        }
                      } else {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.error,
                          animType: AnimType.rightSlide,
                          headerAnimationLoop: false,
                          title: 'Error',
                          desc: 'You must select an image',
                        ).show();
                      }
                    }
                  },
                  child: const Text(
                    'Add',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: formButtonFont,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
              const SizedBox(
                height: 40,
              )
            ],
          ),
        ),
      ),
    );
  }
}
