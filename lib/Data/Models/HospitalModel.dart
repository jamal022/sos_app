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

UpdateHospitalAddress(id, lat, long, context) async {
  await FirebaseFirestore.instance
      .collection("Hospitals")
      .doc(id)
      .update({"AddressLang": lat, "AddressLong": long});

  Navigator.pop(context, "refresh");
}

AddHospital(Hospital hospital, context) async {
  await FirebaseFirestore.instance.collection("Hospitals").add({
    "Name": hospital.name,
    "Email": hospital.email,
    "Telephone1": hospital.telephone1,
    "Telephone2": hospital.telephone2,
    "AmbulancePhone": hospital.ambulancePhone,
    "Image": hospital.image,
    "AddressLang": hospital.addressLang,
    "AddressLong": hospital.addressLong
  });
  Navigator.pop(context);
  return "Added";
}

DeleteHospital(id, context) async {
  await FirebaseFirestore.instance.collection("Hospitals").doc(id).delete();
  Navigator.pop(context);
  return "deleted";
}
