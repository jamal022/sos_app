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
        List<Doctor> results = [];
        if (snapshot.hasData) {
          List<Doctor> doctors = [];
          List<String> names = [];

          for (var doc in snapshot.data!.docs) {
            Doctor doctor = Doctor(
              id: doc.id,
              username: doc.data()['FullName'],
              email: doc.data()['Email'],
              phoneNumber: doc.data()['PhoneNumber'],
              age: doc.data()['Age'],
              gender: doc.data()['Gender'],
              image: doc.data()['Image'],
              field: doc.data()['Field'],
              addressLat: doc.data()['AddressLatitude'],
              addressLong: doc.data()['AddressLongitude'],
              bio: doc.data()['Bio'],
              experience: doc.data()['YearsOfExperience'],
              price: doc.data()['TicketPrice'],
              verified: doc.data()["Verified"],
              rate: doc.data()["Rate"],
              idImage: doc.data()["IdImage"],
            );
            doctors.add(doctor);
            names.add(doctor.username);
          }
          for (var i = 0; i < names.length; i++) {
            if (names[i].toLowerCase().contains(query)) {
              results.add(doctors[i]);
            }
          }
        }

        return results.length != 0
            ? ListView(
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
                                      phoneNumber: element.phoneNumber,
                                      username: element.username,
                                      addressLat: element.addressLat,
                                      addressLong: element.addressLong,
                                      bio: element.bio,
                                      experience: element.experience,
                                      field: element.field,
                                      price: element.price,
                                      rate: element.rate,
                                      verified: element.verified,
                                      idImage: element.idImage),
                                ),
                              ));
                        },
                      ),
                    )
                    .toList())
            : const Center(
                child: Text(
                'This doctor does not exist',
                style: TextStyle(
                  fontSize: 20,
                  color: primaryColor,
                ),
              ));
      },
    );
  }

// querying process at the runtime
  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
