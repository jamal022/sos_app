import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sos_app/Presentation/Styles/colors.dart';

import '../../Data/Models/doctor.dart';

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

  // List<Doctor> doctorsList = [];
  // getSearchResult(query) async {
  //   await FirebaseFirestore.instance
  //       .collection("Doctors")
  //       .where("FullName", isEqualTo: query)
  //       .get()
  //       .then((value) {
  //     for (var i = 0; i < value.docs.length; i++) {
  //       Doctor dr = Doctor(
  //         username: value.docs[i].data()['FullName'],
  //         email: value.docs[i].data()['Email'],
  //         phoneNumber: value.docs[i].data()['PhoneNumber'],
  //         password: value.docs[i].data()['Password'],
  //         age: value.docs[i].data()['Age'],
  //         gender: value.docs[i].data()['Gender'],
  //         image: value.docs[i].data()['Image'],
  //         field: value.docs[i].data()['Field'],
  //         addressLat: value.docs[i].data()['AddressLatitude'],
  //         addressLong: value.docs[i].data()['AddressLongitude'],
  //         bio: value.docs[i].data()['Bio'],
  //         experience: value.docs[i].data()['YearsOfExperience'],
  //         price: value.docs[i].data()['TicketPrice'],
  //       );

  //       doctorsList.add(dr);
  //     }
  //   });
  // }

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
                      element.data()['FullName'],
                      style: const TextStyle(fontSize: 20),
                    ),
                    onTap: () {},
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
