import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sos_app/Data/Models/doctor.dart';
import 'package:sos_app/Presentation/Styles/colors.dart';
import '../PatientScreens/Home/Doctors/doctor_page_screen.dart';

class DoctorSearchDelegate extends SearchDelegate {
// clear the search text
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

// second overwrite to pop out of search menu
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

// third overwrite to show query result
  @override
  Widget buildResults(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("Doctors").snapshots(),
      builder: (context, snapshot) {
        List<Doctor> doctors = [];
        List<String> names = [];
        List<Doctor> results = [];
        if (snapshot.data!.docs.isNotEmpty) {
          for (var doc in snapshot.data!.docs) {
            Doctor doctor = Doctor(
                username: doc.data()["FullName"],
                email: doc.data()["Email"],
                phoneNumber: doc.data()["PhoneNumber"],
                password: doc.data()["Password"],
                age: doc.data()["Age"],
                gender: doc.data()["Gender"],
                image: doc.data()["Image"],
                addressLat: doc.data()["AddressLatitude"],
                addressLong: doc.data()["AddressLongitude"],
                bio: doc.data()["Bio"],
                experience: doc.data()["YearsOfExperience"],
                field: doc.data()["Field"],
                id: doc.id,
                price: doc.data()["TicketPrice"]);
            doctors.add(doctor);
            names.add(doctor.username);
          }
          for (var i = 0; i < names.length; i++) {
            if (names[i].toLowerCase().contains(query)) {
              results.add(doctors[i]);
            }
          }
        } else {
          return const Center(
              child: Text(
            'This doctor does not exist',
            style: TextStyle(
              fontSize: 20,
              color: primaryColor,
            ),
          ));
        }
        return ListView(
            children: results
                .map<Widget>(
                  (element) => ListTile(
                    title: Text(
                      element.username,
                      style: const TextStyle(fontSize: 20),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DoctorPageScreen(
                              doctor: Doctor(
                                  id: element.id,
                                  age: element.age,
                                  email: element.email,
                                  gender: element.gender,
                                  image: element.image,
                                  password: element.password,
                                  phoneNumber: element.phoneNumber,
                                  username: element.username,
                                  addressLat: element.addressLat,
                                  addressLong: element.addressLong,
                                  bio: element.bio,
                                  experience: element.experience,
                                  field: element.field,
                                  price: element.price),
                            ),
                          ));
                    },
                  ),
                )
                .toList());
      },
    );
  }

// querying process at the runtime
  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
