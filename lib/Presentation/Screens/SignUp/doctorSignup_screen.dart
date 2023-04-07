import 'dart:io';
import 'dart:math';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sos_app/Data/Authentication/signup.dart';
import 'package:sos_app/Presentation/Widgets/loading_widget.dart';
import '../../../Data/Models/doctor.dart';
import '../../Styles/colors.dart';
import '../../Widgets/textFormField_widget.dart';
import '../Login/login_screen.dart';
import 'package:geolocator/geolocator.dart';

class DoctorSignupScreen extends StatefulWidget {
  final name;
  final email;
  final password;
  final phone;
  final age;
  final gender;
  final image;
  final id;
  const DoctorSignupScreen(
      {super.key,
      @required this.name,
      @required this.email,
      @required this.password,
      @required this.age,
      @required this.gender,
      @required this.image,
      @required this.phone,
      @required this.id});

  @override
  State<DoctorSignupScreen> createState() => _DoctorSignupScreenState();
}

class _DoctorSignupScreenState extends State<DoctorSignupScreen> {
  var fieldController = TextEditingController();
  var experienceController = TextEditingController();
  var ticketController = TextEditingController();
  var addressController = TextEditingController();
  var bioController = TextEditingController();
  late Doctor doctor;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  XFile? _image;
  final ImagePicker _picker = ImagePicker();
  Reference? _ref;
  File? _file;
  String? _imageurl;
  var _idImage;

  _addImage() async {
    if (_picker != null) {
      _file = File(_image!.path);
      var _rand = Random().nextInt(100000);
      var _imagename = "$_rand" + basename(_image!.path);
      _ref = FirebaseStorage.instance.ref("Profiles").child("$_imagename");
      await _ref!.putFile(_file!);
      _imageurl = await _ref!.getDownloadURL();
      _image = null;
      _ref = null;
      _file = null;

      return _imageurl;
    }
  }

  Future _getImage(ImageSource media) async {
    var _img = await _picker.pickImage(source: media);
    setState(() {
      _image = _img;
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
            "Choose Profile Photo",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: primaryColor),
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
                  color: primaryColor,
                  size: 25,
                ),
                label: const Text(
                  "Camera",
                  style: TextStyle(color: primaryColor, fontSize: 22),
                ),
              ),
              TextButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                  _getImage(ImageSource.gallery);
                },
                icon: const Icon(
                  Icons.image,
                  color: primaryColor,
                  size: 25,
                ),
                label: const Text(
                  "Gallery",
                  style: TextStyle(color: primaryColor, fontSize: 22),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  var lat;
  var long;
  List<Placemark> placemarks = [];

  Future getPosition() async {
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
      getLatAndLong();
    }
  }

  Future getLatAndLong() async {
    Position currentLocation =
        await Geolocator.getCurrentPosition().then((value) => value);
    lat = currentLocation.latitude;
    long = currentLocation.longitude;
    placemarks = await placemarkFromCoordinates(lat, long);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: primaryColor,
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10.0),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
            color: containerColor,
          ),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  "Please fill these information",
                  style: TextStyle(
                    color: Color.fromARGB(255, 168, 109, 19),
                    fontSize: 22,
                  ),
                ),
                const SizedBox(height: 20),
                textFieldTitle('Field'),
                TextFormFieldWidget(
                  hintText: 'Field',
                  icon: Icons.person_rounded,
                  type: TextInputType.name,
                  textController: fieldController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'You must fill the field';
                    }
                    if (value.length > 15) {
                      return 'Must be less than 15 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                textFieldTitle('Years of Experience'),
                TextFormFieldWidget(
                  hintText: "years of experience",
                  icon: Icons.format_list_numbered_rounded,
                  type: TextInputType.number,
                  textController: experienceController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'You must fill the years of experience';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                textFieldTitle('Ticket Price'),
                TextFormFieldWidget(
                  hintText: "Ticket Price",
                  icon: Icons.monetization_on,
                  type: TextInputType.number,
                  textController: ticketController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'You must fill the ticket price';
                    }
                    return null;
                  },
                ),
                textFieldTitle('Upload Your ID'),
                Padding(
                  padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
                  child: Row(
                    children: [
                      MaterialButton(
                          elevation: 5.0,
                          color: primaryColor,
                          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                          shape: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
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
                      _image != null
                          ? Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.file(
                                  //to show image, you type like this.
                                  File(_image!.path),
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
                const SizedBox(height: 10),
                textFieldTitle('Address'),
                Column(
                  children: [
                    lat == null
                        ? MaterialButton(
                            color: primaryColor,
                            onPressed: () {
                              getPosition();
                            },
                            child: const Text('Get the current location'),
                          )
                        : Text(
                            "  ${placemarks[0].street}, ${placemarks[0].administrativeArea}"),
                  ],
                ),
                const SizedBox(height: 10),
                textFieldTitle('Bio'),
                TextFormFieldWidget(
                  hintText: "Write a brief about your experience.....",
                  icon: Icons.post_add,
                  type: TextInputType.multiline,
                  textController: bioController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'You must fill the bio';
                    }
                    if (value.length > 200) {
                      return 'Must be less than 22 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10.0,
                ),
                const SizedBox(
                  height: 10,
                ),
                MaterialButton(
                    elevation: 5.0,
                    color: const Color.fromARGB(238, 237, 96, 35),
                    padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                    shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide.none,
                    ),
                    onPressed: () async {
                      var formdata = formKey.currentState;
                      if (formdata!.validate()) {
                        formdata.save();
                        if (_image != null) {
                          if (lat != null) {
                            showLoading(context);
                            _idImage = await _addImage();
                            doctor = Doctor(
                                username: widget.name,
                                email: widget.email,
                                phoneNumber: widget.phone,
                                password: widget.password,
                                age: widget.age,
                                gender: widget.gender,
                                image: widget.image,
                                field: fieldController.text,
                                experience: experienceController.text,
                                price: ticketController.text,
                                addressLat: lat,
                                addressLong: long,
                                bio: bioController.text,
                                idImage: _idImage,
                                rate: "0",
                                verified: 0,
                                token: await FirebaseMessaging.instance
                                    .getToken());

                            AddDoctor(doctor, context, widget.id);
                          } else {
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.error,
                              animType: AnimType.rightSlide,
                              headerAnimationLoop: false,
                              title: 'Error',
                              desc: 'You must add your location',
                            ).show();
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
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text("Enter valid values to continue"),
                              behavior: SnackBarBehavior.floating),
                        );
                      }
                    },
                    child: const Text(
                      'Register',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
