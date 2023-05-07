import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:sos_app/Presentation/Styles/colors.dart';

import '../../../Data/Models/doctor.dart';

class AdminDoctorPage extends StatefulWidget {
  Doctor doctor;
  AdminDoctorPage({super.key, required this.doctor});

  @override
  State<AdminDoctorPage> createState() => _AdminDoctorPageState();
}

List<Placemark> placemarks = [];

class _AdminDoctorPageState extends State<AdminDoctorPage> {
  _getAddress() async {
    placemarks = await placemarkFromCoordinates(
        widget.doctor.addressLat, widget.doctor.addressLong);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _getAddress();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: adminback,
      appBar: AppBar(
        title: Text(
          widget.doctor.username,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
        ),
        centerTitle: true,
        toolbarHeight: 60.2,
        elevation: 4,
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
          child: Container(
              padding: const EdgeInsets.fromLTRB(5, 10, 5, 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromARGB(255, 254, 238, 217),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(12, 5, 12, 5),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                    backgroundImage: NetworkImage(
                                      widget.doctor.image,
                                    ),
                                    maxRadius: 50,
                                    backgroundColor: white),
                                SizedBox(
                                  width: size.width / 10,
                                ),
                                Text(
                                  '${widget.doctor.username}',
                                  style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                              child: Row(
                                children: [
                                  const Text(
                                    'Email:',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: size.width / 15,
                                  ),
                                  Text(
                                    '${widget.doctor.email}',
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                              child: Row(
                                children: [
                                  const Text(
                                    'Field:',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: size.width / 15,
                                  ),
                                  Text(
                                    '${widget.doctor.field}',
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                              child: Row(
                                children: [
                                  const Text(
                                    'Age:',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: size.width / 15,
                                  ),
                                  Text(
                                    ' ${widget.doctor.age} ',
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                              child: Row(
                                children: [
                                  const Text(
                                    'Gender:',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: size.width / 15,
                                  ),
                                  Text(
                                    ' ${widget.doctor.gender}',
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                              child: Row(
                                children: [
                                  const Text(
                                    'Phone Number:',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: size.width / 22,
                                  ),
                                  Text(
                                    '${widget.doctor.phoneNumber}',
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                              child: Row(
                                children: [
                                  const Text(
                                    'Ticket Price:',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: size.width / 15,
                                  ),
                                  Text(
                                    '${widget.doctor.price} EGP',
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                              child: Row(
                                children: [
                                  const Text(
                                    'Years of Experience:',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: size.width / 15,
                                  ),
                                  Text(
                                    '${widget.doctor.experience} ',
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Address:',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  placemarks.length != 0
                                      ? Text(
                                          "${placemarks[0].street} ,${placemarks[0].administrativeArea}",
                                          style: const TextStyle(fontSize: 18),
                                        )
                                      : Text(""),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Text(
                                        'Bio:',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    " ${widget.doctor.bio}",
                                    style: const TextStyle(fontSize: 18),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Image.network(
                                widget.doctor.idImage,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ))),
    );
  }
}
