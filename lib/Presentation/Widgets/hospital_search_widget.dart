import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sos_app/Data/Models/HospitalModel.dart';
import 'package:sos_app/Data/Models/doctor.dart';
import 'package:sos_app/Presentation/PatientScreens/Home/Hospitals/hospital_page_screen.dart';
import 'package:sos_app/Presentation/Styles/colors.dart';
import '../PatientScreens/Home/Doctors/doctor_page_screen.dart';

class HospitalSearchDelegate extends SearchDelegate {
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
      stream: FirebaseFirestore.instance.collection("Hospitals").snapshots(),
      builder: (context, snapshot) {
        List<Hospital> hospitals = [];
        List<String> names = [];
        List<Hospital> results = [];
        if (snapshot.data!.docs.isNotEmpty) {
          for (var hos in snapshot.data!.docs) {
            Hospital hospital = Hospital(
              name: hos.data()["Name"],
              ambulancePhone: hos.data()["AmbulancePhone"],
              telephone1: hos.data()["Telephone1"],
              telephone2: hos.data()["Telephone2"],
              email: hos.data()["Email"],
              image: hos.data()["Image"],
              addressLang: hos.data()["AddressLang"],
              addressLong: hos.data()["AddressLong"],
            );
            hospitals.add(hospital);
            names.add(hospital.name);
          }
          for (var i = 0; i < names.length; i++) {
            if (names[i].toLowerCase().contains(query)) {
              results.add(hospitals[i]);
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
                      element.name,
                      style: const TextStyle(fontSize: 20),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HospitalPageScreen(
                              hospital: Hospital(
                                  addressLang: element.addressLang,
                                  addressLong: element.addressLong,
                                  name: element.name,
                                  ambulancePhone: element.ambulancePhone,
                                  email: element.email,
                                  image: element.image,
                                  telephone1: element.telephone1,
                                  telephone2: element.telephone2),
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
