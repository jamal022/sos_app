import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sos_app/Data/Models/doctor.dart';
import 'package:sos_app/Presentation/Styles/colors.dart';
import 'package:sos_app/Presentation/Views/doctor_card_widget.dart';

import '../PatientScreens/Home/Doctors/doctor_page_screen.dart';

class CustomSearchDelegate extends SearchDelegate {
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
      stream: FirebaseFirestore.instance
          .collection("Doctors")
          .where("FullName", isEqualTo: query)
          .snapshots(),
      builder: (context, snapshot) {
        var results;
        if (snapshot.data!.docs.isNotEmpty) {
          results = snapshot.data!.docs;
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
                      element.data()["FullName"],
                      style: const TextStyle(fontSize: 20),
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DoctorPageScreen(
                              doctor: Doctor(
                                  id: element.id,
                                  username: element.data()['FullName'],
                                  email: element.data()['Email'],
                                  phoneNumber: element.data()['PhoneNumber'],
                                  password: element.data()['Password'],
                                  age: element.data()['Age'],
                                  gender: element.data()['Gender'],
                                  image: element.data()['Image'],
                                  addressLat: element.data()['AddressLat'],
                                  addressLong: element.data()['AddressLong'],
                                  bio: element.data()['Bio'],
                                  experience:
                                      element.data()['YearsOfExperience'],
                                  field: element.data()['Field'],
                                  price: element.data()['TicketPrice']),
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
