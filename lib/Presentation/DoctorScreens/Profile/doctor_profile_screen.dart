import 'dart:io';
import 'dart:math';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:geocoding/geocoding.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sos_app/Presentation/DoctorScreens/Profile/articles_history_screen.dart';
import 'package:sos_app/Presentation/DoctorScreens/Profile/community_history_screen.dart';
import 'package:sos_app/Presentation/DoctorScreens/Profile/update_address_screen.dart';
import 'package:sos_app/Presentation/Widgets/loading_widget.dart';
import '../../../Data/Models/doctor.dart';
import '../../Styles/colors.dart';
import '../../Styles/fonts.dart';
import 'doctor_edit_screen.dart';

class DoctorProfileScreen extends StatefulWidget {
  DoctorProfileScreen({Key? key}) : super(key: key);

  @override
  State<DoctorProfileScreen> createState() => _DoctorProfileScreen();
}

class _DoctorProfileScreen extends State<DoctorProfileScreen> {
  final maxLines = 5;

  var role;
  Doctor doctor = Doctor();

  List<Placemark> placemarks = [];

  _getPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    doctor.id = prefs.getString("Id");
    role = prefs.getString("Role");
    doctor.username = prefs.getString("FullName");
    doctor.email = prefs.getString("Email");
    doctor.password = prefs.getString("Password");
    doctor.phoneNumber = prefs.getString("PhoneNumber");
    doctor.age = prefs.getString("Age");
    doctor.gender = prefs.getString("Gender");
    doctor.image = prefs.getString("Image");
    doctor.field = prefs.getString("Field");
    doctor.experience = prefs.getString("YearsOfExperience");
    doctor.price = prefs.getString("TicketPrice");
    doctor.bio = prefs.getString("Bio");
    doctor.addressLat = prefs.getDouble("AddressLatitude");
    doctor.addressLong = prefs.getDouble("AddressLongitude");
    doctor.rate = prefs.getString("Rate");
    doctor.idImage = prefs.getString("IdImage");
    doctor.verified = await GetVerifiedFromDoctorById(doctor.id);
    _flag = true;
    placemarks =
        await placemarkFromCoordinates(doctor.addressLat, doctor.addressLong);
    setState(() {});
  }

  XFile? cardImage;
  final ImagePicker picker = ImagePicker();
  Reference? ref;
  File? file;
  String? imageurl;
  bool _flag = false;

  _addImage() async {
    if (picker != null) {
      file = File(cardImage!.path);
      var rand = Random().nextInt(100000);
      var imagename = "$rand" + basename(cardImage!.path);
      ref = FirebaseStorage.instance.ref("Profiles").child("$imagename");
      await ref!.putFile(file!);
      imageurl = await ref!.getDownloadURL();
      cardImage = null;
      ref = null;
      file = null;

      return imageurl;
    }
  }

  Future _getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);
    setState(() {
      cardImage = img;
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

  @override
  void initState() {
    super.initState();
    _getPrefs();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: back,
        body: _flag == true
            ? SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(15.0, 40.0, 15.0, 10.0),
                child: doctor.addressLat != null
                    ? Column(children: [
                        Row(
                          children: [
                            Column(
                              children: [
                                CircleAvatar(
                                    backgroundImage: NetworkImage(
                                      doctor.image,
                                    ),
                                    maxRadius: 60,
                                    backgroundColor: primaryColor),
                                const SizedBox(
                                  height: 10,
                                ),
                                RatingBar(
                                  ignoreGestures: true,
                                  initialRating: double.parse(doctor.rate),
                                  itemSize: 25,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  tapOnlyMode: true,
                                  ratingWidget: RatingWidget(
                                      full: const Icon(Icons.star,
                                          color: primaryColor),
                                      half: const Icon(
                                        Icons.star_half,
                                        color: primaryColor,
                                      ),
                                      empty: const Icon(
                                        Icons.star_outline,
                                        color: primaryColor,
                                      )),
                                  onRatingUpdate: ((value) {}),
                                )
                              ],
                            ),
                            Container(
                              height: size.height / 4,
                              margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        '\n  ${doctor.username}\n',
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      doctor.verified == 1
                                          ? IconButton(
                                              icon: const Icon(Icons.verified),
                                              onPressed: () {},
                                              tooltip:
                                                  "Your account is verified",
                                              color: Colors
                                                  .lightBlueAccent.shade700,
                                            )
                                          : IconButton(
                                              icon: const Icon(Icons
                                                  .do_not_disturb_alt_sharp),
                                              onPressed: () {},
                                              tooltip:
                                                  "Your account isn't verified yet",
                                              color: Colors.redAccent.shade700,
                                            )
                                    ],
                                  ),
                                  Text(
                                    doctor.field,
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                  const SizedBox(
                                    height: 14,
                                  ),
                                  MaterialButton(
                                    elevation: 4.0,
                                    color: Colors.white,
                                    shape: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: BorderSide.none,
                                    ),
                                    onPressed: () async {
                                      var result = await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                DoctorEditScreen(
                                                  doctor: doctor,
                                                )),
                                      );
                                      if (result == "refresh") {
                                        _getPrefs();
                                      }
                                    },
                                    child: const Text(
                                      'Edit Profile',
                                      style: TextStyle(
                                        color: black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        doctor.verified == 2
                            ? Column(
                                children: [
                                  Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white60,
                                      ),
                                      width: size.width / 0.7,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            20, 20, 20, 20),
                                        child: Column(
                                          children: [
                                            const Text(
                                              "Update your ID card to verify your account",
                                              style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.black,
                                              ),
                                              textAlign: TextAlign.left,
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              children: [
                                                Stack(children: [
                                                  cardImage == null
                                                      ? Container(
                                                          width: size.width / 3,
                                                          height:
                                                              size.height / 8,
                                                          child: Image.network(
                                                            doctor.idImage,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        )
                                                      : Container(
                                                          width: size.width / 3,
                                                          height:
                                                              size.height / 8,
                                                          child: Image.file(
                                                            File(
                                                              cardImage!.path,
                                                            ),
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                  Positioned(
                                                    bottom: 8,
                                                    right: 10,
                                                    child: InkWell(
                                                      onTap: () {
                                                        showModalBottomSheet(
                                                            context: context,
                                                            builder: ((context) =>
                                                                bottomSheet(
                                                                    context)));
                                                      },
                                                      child: const Icon(
                                                        Icons
                                                            .camera_alt_rounded,
                                                        color: black,
                                                        size: 28,
                                                      ),
                                                    ),
                                                  ),
                                                ]),
                                                SizedBox(
                                                  width: size.width / 5,
                                                ),
                                                MaterialButton(
                                                  elevation: 4.0,
                                                  color: Colors.white,
                                                  shape: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                    borderSide: BorderSide.none,
                                                  ),
                                                  onPressed: () async {
                                                    if (cardImage != null) {
                                                      showLoading(context);
                                                      await DeleteDoctorProfile(
                                                          doctor.idImage);
                                                      var doctorCardImage =
                                                          await _addImage();
                                                      var result =
                                                          await UpdateDoctorIdCard(
                                                              doctor.id,
                                                              doctorCardImage,
                                                              context);
                                                      if (result == "updated") {
                                                        _getPrefs();
                                                      }
                                                    }
                                                  },
                                                  child: const Text(
                                                    'Update',
                                                    style: TextStyle(
                                                      color: black,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )),
                                  const SizedBox(
                                    height: 20,
                                  )
                                ],
                              )
                            : Container(),
                        Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white60,
                            ),
                            width: size.width / 0.7,
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(20, 20, 20, 20),
                              child: Text(
                                doctor.bio,
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            )),
                        const SizedBox(height: 20),
                        Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white60,
                            ),
                            width: size.width / 0.7,
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(20, 20, 20, 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Address: ",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                        height: 50,
                                        width: 200,
                                        child: placemarks.length != 0
                                            ? Text(
                                                "${placemarks[0].street} ,${placemarks[0].administrativeArea}")
                                            : Text(""),
                                      )
                                    ],
                                  ),
                                  IconButton(
                                      onPressed: () async {
                                        var result = await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  UpdateAddressScreen(
                                                    doctor: doctor,
                                                    lat: doctor.addressLat,
                                                    long: doctor.addressLong,
                                                  )),
                                        );
                                        if (result == "refresh") {
                                          _getPrefs();
                                        }
                                      },
                                      icon: const Icon(Icons.edit)),
                                ],
                              ),
                            )),
                        const SizedBox(
                          height: 30,
                        ),
                        Column(
                          children: [
                            SizedBox(
                              height: size.height / 17,
                              width: size.width / 1.3,
                              child: MaterialButton(
                                  elevation: 6.0,
                                  color: Colors.white,
                                  shape: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide.none,
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              CommunityHistoryScreen()),
                                    );
                                  },
                                  child: const Text(
                                    'Q/A  History',
                                    style: TextStyle(
                                      color: black,
                                      fontSize: formButtonFont,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              height: size.height / 17,
                              width: size.width / 1.3,
                              child: MaterialButton(
                                  elevation: 6.0,
                                  color: Colors.white,
                                  shape: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide.none,
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ArticlesHistoryScreen(
                                                doctor: doctor,
                                              )),
                                    );
                                  },
                                  child: const Text(
                                    'Articles  History',
                                    style: TextStyle(
                                      color: black,
                                      fontSize: formButtonFont,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ])
                    : Center())
            : Center(
                child: CircularProgressIndicator(),
              ));
  }
}
