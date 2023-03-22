import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Hospital {
  var hospitalId;
  var name;
  var image;
  var addressLang;
  var addressLong;
  var telephone1;
  var telephone2;
  var email;
  var ambulancePhone;

  Hospital({
    this.hospitalId,
    this.name,
    this.image,
    this.telephone1,
    this.telephone2,
    this.addressLang,
    this.addressLong,
    this.ambulancePhone,
    this.email,
  });
}

GetHospitals() async {
  List<Hospital> hospitals = [];
  await FirebaseFirestore.instance.collection("Hospitals").get().then((value) {
    for (var hos in value.docs) {
      Hospital h = Hospital(
          hospitalId: hos.id,
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

Future<Hospital> GetSpecificHospital(id) async {
  late Hospital hospital;
  await FirebaseFirestore.instance
      .collection("Hospitals")
      .doc(id)
      .get()
      .then((value) {
    hospital = Hospital(
        hospitalId: value.id,
        name: value.data()!["Name"],
        image: value.data()!["Image"],
        email: value.data()!["Email"],
        telephone1: value.data()!["Telephone1"],
        telephone2: value.data()!["Telephone2"],
        ambulancePhone: value.data()!["AmbulancePhone"],
        addressLang: value.data()!["AddressLang"],
        addressLong: value.data()!["AddressLong"]);
  });
  return hospital;
}

UpdateHospital(Hospital hospital, formkey, context) async {
  var formdata = formkey.currentState;
  if (formdata!.validate()) {
    formdata.save();
    await FirebaseFirestore.instance
        .collection("Hospitals")
        .doc(hospital.hospitalId)
        .update({
      "Name": hospital.name,
      "Email": hospital.email,
      "Telephone1": hospital.telephone1,
      "Telephone2": hospital.telephone2,
      "AmbulancePhone": hospital.ambulancePhone,
      "Image": hospital.image
    });

    Navigator.pop(context, "refresh");
  } else {
    print("not valid");
  }
}
