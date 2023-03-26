import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:sos_app/Data/Authentication/signup.dart';
import 'package:sos_app/Presentation/Widgets/loading_widget.dart';
import '../../../Data/Models/doctor.dart';
import '../../Styles/colors.dart';
import '../../Widgets/textFormField_widget.dart';
import '../../Widgets/upoladPhoto_widget.dart';
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
  const DoctorSignupScreen(
      {super.key,
      @required this.name,
      @required this.email,
      @required this.password,
      @required this.age,
      @required this.gender,
      @required this.image,
      @required this.phone});

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
  var idImage;
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
                textFieldTitle('Upload Your ID'),
                const UploadPhotoWidget(text: 'Upload Image'),
                const SizedBox(
                  height: 20,
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
                        showLoading(context);
                        idImage = await addImage();
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
                            addressLat: lat.toString(),
                            addressLong: long.toString(),
                            bio: bioController.text,
                            idImage: idImage,
                            rate: 0,
                            verified: false,
                            token: "0");

                        Register(context: context, doctor: doctor);
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
