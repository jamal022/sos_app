import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:geocoding/geocoding.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sos_app/Presentation/DoctorScreens/Profile/articles_history_screen.dart';
import 'package:sos_app/Presentation/DoctorScreens/Profile/community_history_screen.dart';
import 'package:sos_app/Presentation/DoctorScreens/Profile/update_address_screen.dart';
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

  var role,
      name,
      email,
      password,
      phone,
      image,
      age,
      gender,
      bio,
      field,
      price,
      experience,
      addLat,
      addLong,
      id,
      rate,
      verified;
  Doctor doctor = Doctor();

  List<Placemark> placemarks = [];

  _getPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    id = prefs.getString("Id");
    role = prefs.getString("Role");
    name = prefs.getString("FullName");
    email = prefs.getString("Email");
    password = prefs.getString("Password");
    phone = prefs.getString("PhoneNumber");
    age = prefs.getString("Age");
    gender = prefs.getString("Gender");
    image = prefs.getString("Image");
    field = prefs.getString("Field");
    experience = prefs.getString("YearsOfExperience");
    price = prefs.getString("TicketPrice");
    bio = prefs.getString("Bio");
    addLat = prefs.getString("AddressLatitude");
    addLong = prefs.getString("AddressLongitude");
    rate = prefs.getString("Rate");
    verified = prefs.getString("Verified");

    setState(() {
      doctor = Doctor(
          id: id,
          username: name,
          email: email,
          phoneNumber: phone,
          password: password,
          age: age,
          gender: gender,
          image: image,
          field: field,
          experience: experience,
          price: price,
          addressLat: addLat,
          addressLong: addLong,
          bio: bio,
          rate: rate,
          verified: verified);
    });
    placemarks = await placemarkFromCoordinates(
        double.parse(doctor.addressLat), double.parse(doctor.addressLong));
    setState(() {});
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
      body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(10.0, 40.0, 10.0, 0.0),
          child: doctor.addressLat != null
              ? Column(children: [
                  Row(
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                            child: CircleAvatar(
                                backgroundImage: NetworkImage(
                                  doctor.image,
                                ),
                                maxRadius: 70,
                                backgroundColor: primaryColor),
                          ),
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
                                full:
                                    const Icon(Icons.star, color: primaryColor),
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
                        width: 200,
                        height: 200,
                        margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  '\n       ${doctor.username}\n',
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                doctor.verified == "true"
                                    ? IconButton(
                                        icon: const Icon(Icons.verified),
                                        onPressed: () {},
                                        tooltip: "Your account is verified",
                                        color: Colors.lightBlueAccent.shade700,
                                      )
                                    : IconButton(
                                        icon: const Icon(
                                            Icons.do_not_disturb_alt_sharp),
                                        onPressed: () {},
                                        tooltip:
                                            "Your account isn't approved yet",
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
                                      builder: (context) => DoctorEditScreen(
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
                  Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white60,
                      ),
                      width: size.width / 0.7,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                        child: Text(
                          doctor.bio,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
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
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                    builder: (context) => ArticlesHistoryScreen(
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
              : Center()),
    );
  }
}
