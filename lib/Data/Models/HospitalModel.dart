import 'package:cloud_firestore/cloud_firestore.dart';

class Hospital {
  var name;
  var image;
  var addressLang;
  var addressLong;
  var telephone1;
  var telephone2;
  var email;
  var ambulancePhone;

  Hospital({
    required this.name,
    required this.image,
    required this.telephone1,
    required this.telephone2,
    required this.addressLang,
    required this.addressLong,
    required this.ambulancePhone,
    required this.email,
  });
}

GetHospitals() async {
  List<Hospital> hospitals = [];
  await FirebaseFirestore.instance.collection("Hospitals").get().then((value) {
    for (var hos in value.docs) {
      Hospital h = Hospital(
          name: hos.data()["Name"],
          image: hos.data()["Image"],
          email: hos.data()["Email"],
          telephone1: hos.data()["Telephone1"],
          telephone2: hos.data()["Telephone2"],
          ambulancePhone: hos.data()["AmbulancePhone"],
          addressLang: hos.data()["AddressLang"],
          addressLong: hos.data()["AddressLong"]);
      hospitals.add(h);
    }
  });
  return hospitals;
}
