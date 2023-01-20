import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../Data/Models/doctor.dart';

class CustomSearchDelegate extends SearchDelegate {
// Demo list to show querying
  List<String> searchTerms = [
    "Apple",
    "Banana",
    "Mango",
    "Pear",
    "Watermelons",
    "Blueberries",
    "Pineapples",
    "Strawberries"
  ];

// first overwrite to
// clear the search text
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }

  late List<Doctor> doctorsList;
  getSearchResult(query) async {
    List<Doctor> doctors = [];
    await FirebaseFirestore.instance
        .collection("Doctors")
        .where("Username", isEqualTo: query)
        .get()
        .then((value) {
      for (var i = 0; i < value.docs.length; i++) {
        Doctor dr = Doctor(
          username: value.docs[i].data()['FullName'],
          email: value.docs[i].data()['Email'],
          phoneNumber: value.docs[i].data()['PhoneNumber'],
          password: value.docs[i].data()['Password'],
          age: value.docs[i].data()['Age'],
          gender: value.docs[i].data()['Gender'],
          image: value.docs[i].data()['Image'],
          field: value.docs[i].data()['Field'],
          addressLat: value.docs[i].data()['AddressLatitude'],
          addressLong: value.docs[i].data()['AddressLongitude'],
          bio: value.docs[i].data()['Bio'],
          experience: value.docs[i].data()['YearsOfExperience'],
          price: value.docs[i].data()['TicketPrice'],
        );

        doctors.add(dr);
      }
    });
    return doctors;
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
    doctorsList = getSearchResult(query);
    return ListView.builder(
      itemCount: doctorsList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(doctorsList[index].username),
          onTap: () {},
        );
      },
    );
  }

// last overwrite to show the
// querying process at the runtime
  @override
  Widget buildSuggestions(BuildContext context) {
    // List<String> matchQuery = [];
    // for (var fruit in searchTerms) {
    //   if (fruit.toLowerCase().contains(query.toLowerCase())) {
    //     matchQuery.add(fruit);
    //   }
    // }
    // return ListView.builder(
    //   itemCount: matchQuery.length,
    //   itemBuilder: (context, index) {
    //     var result = matchQuery[index];
    //     return ListTile(
    //       title: Text(result),
    //     );
    //   },
    // );
    return Container();
  }
}
