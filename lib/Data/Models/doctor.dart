import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sos_app/Data/Models/patient.dart';
import 'NotificationModel.dart';

class Doctor extends Patient {
  var field;
  var experience;
  var price;
  var addressLat;
  var addressLong;
  var bio;
  var id;
  var idImage;
  var rate;
  var verified;

  Doctor(
      {username,
      this.id,
      email,
      phoneNumber,
      password,
      age,
      gender,
      image,
      token,
      this.verified,
      this.rate,
      this.idImage,
      this.field,
      this.experience,
      this.price,
      this.addressLat,
      this.addressLong,
      this.bio})
      : super(
            username: username,
            email: email,
            phoneNumber: phoneNumber,
            password: password,
            age: age,
            gender: gender,
            image: image,
            token: token) {}
}

Update_Doctor(Doctor doctor, password, context) async {
  final user = await FirebaseAuth.instance.currentUser;
  final cred =
      EmailAuthProvider.credential(email: doctor.email, password: password);

  user?.reauthenticateWithCredential(cred).then((value) {
    user.updatePassword(doctor.password).then((value) async {
      await FirebaseFirestore.instance
          .collection("Doctors")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        "FullName": doctor.username,
        'Password': doctor.password,
        "PhoneNumber": doctor.phoneNumber,
        "Age": doctor.age,
        "Field": doctor.field,
        "TicketPrice": doctor.price,
        "YearsOfExperience": doctor.experience,
        "Bio": doctor.bio,
        "Image": doctor.image,
      });
      await updateDoctorsPrefs(doctor);
      Navigator.pop(context);
      Navigator.pop(context, "refresh");
    });
  });
}

DeleteDoctorProfile(image) async {
  await FirebaseStorage.instance.refFromURL(image).delete();
}

updateDoctorsPrefs(Doctor doctor) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("FullName", doctor.username);
  prefs.setString("Password", doctor.password);
  prefs.setString("PhoneNumber", doctor.phoneNumber);
  prefs.setString("Age", doctor.age);
  prefs.setString("Image", doctor.image);
  prefs.setString("Field", doctor.field);
  prefs.setString("TicketPrice", doctor.price);
  prefs.setString("YearsOfExperience", doctor.experience);
  prefs.setString("Bio", doctor.bio);
}

UpdateAddress({doctor, lat, long, context}) async {
  await FirebaseFirestore.instance.collection("Doctors").doc(doctor.id).update(
      {"AddressLatitude": lat, "AddressLongitude": long}).then((value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble("AddressLatitude", lat);
    prefs.setDouble("AddressLongitude", long);
  });

  Navigator.pop(context, "refresh");
}

getDoctors() async {
  List<Doctor> doctors = [];
  await FirebaseFirestore.instance.collection('Doctors').get().then((value) {
    for (var i = 0; i < value.docs.length; i++) {
      Doctor dr = Doctor(
          id: value.docs[i].id,
          username: value.docs[i].data()['FullName'],
          email: value.docs[i].data()['Email'],
          phoneNumber: value.docs[i].data()['PhoneNumber'],
          age: value.docs[i].data()['Age'],
          gender: value.docs[i].data()['Gender'],
          image: value.docs[i].data()['Image'],
          field: value.docs[i].data()['Field'],
          addressLat: value.docs[i].data()['AddressLatitude'],
          addressLong: value.docs[i].data()['AddressLongitude'],
          bio: value.docs[i].data()['Bio'],
          experience: value.docs[i].data()['YearsOfExperience'],
          price: value.docs[i].data()['TicketPrice'],
          verified: value.docs[i].data()["Verified"],
          rate: value.docs[i].data()["Rate"],
          token: value.docs[i].data()["Token"],
          idImage: value.docs[i].data()["IdImage"]);

      doctors.insert(i, dr);
    }
  });
  return doctors;
}

UpdateDoctorToken(doctorId, token) async {
  await FirebaseFirestore.instance
      .collection("Doctors")
      .doc(doctorId)
      .update({"Token": token}).then((value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("Token", token);
  });
  return "updated";
}

getDoctorsForAdmin() async {
  List<Doctor> doctors = [];
  await FirebaseFirestore.instance
      .collection('Doctors')
      .where("Verified", isEqualTo: 0)
      .get()
      .then((value) {
    for (var i = 0; i < value.docs.length; i++) {
      Doctor dr = Doctor(
        id: value.docs[i].id,
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
        verified: value.docs[i].data()["Verified"],
        rate: value.docs[i].data()["Rate"],
        token: value.docs[i].data()["Token"],
        idImage: value.docs[i].data()["IdImage"],
      );

      doctors.insert(i, dr);
    }
  });
  return doctors;
}

UpdateVerifiedToVerify(doctorId, token) async {
  await FirebaseFirestore.instance
      .collection("Doctors")
      .doc(doctorId)
      .update({"Verified": 1}).then((value) async {
    await SendNotifyToUser("Your account is verified", token, doctorId);
  });
  return "updated";
}

UpdateVerifiedToBlock(doctorId, token) async {
  await FirebaseFirestore.instance
      .collection("Doctors")
      .doc(doctorId)
      .update({"Verified": 2}).then((value) async {
    await SendNotifyToUser(
        "Your account is blocked, please update your ID card", token, doctorId);
  });
  return "updated";
}

UpdateDoctorIdCard(doctorId, idImage, context) async {
  await FirebaseFirestore.instance
      .collection("Doctors")
      .doc(doctorId)
      .update({"Verified": 0, "IdImage": idImage}).then((value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("Verified", 0);
    prefs.setString("IdImage", idImage);
  });
  Navigator.pop(context);
  return "updated";
}

UpdateDoctorRate(docId) async {
  var rate = 0.0;
  var avRate = 0.0;
  await FirebaseFirestore.instance
      .collection("Appointments")
      .where("DoctorId", isEqualTo: docId)
      .where("Status", isEqualTo: "Ended")
      .get()
      .then((value) {
    for (var app in value.docs) {
      rate = rate + app.data()["Rate"];
    }
    avRate = rate / value.docs.length;
  });
  await FirebaseFirestore.instance
      .collection("Doctors")
      .doc(docId)
      .update({"Rate": avRate.toString()});
}

GetRecommendedDoctors(lat, long) async {
  List<Doctor> doctors = [];
  await FirebaseFirestore.instance
      .collection("Doctors")
      .get()
      .then((value) async {
    for (var doc in value.docs) {
      var distance = await Geolocator.distanceBetween(lat, long,
          doc.data()["AddressLatitude"], doc.data()['AddressLongitude']);
      if (double.parse(doc.data()["Rate"]) >= 4 &&
          double.parse(doc.data()["Rate"]) <= 5 &&
          int.parse(doc.data()["YearsOfExperience"]) >= 4 &&
          distance <= 3000) {
        doctors.add(Doctor(
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
            idImage: doc.data()["IdImage"]));
      }
      print(distance);
    }
  });
  return doctors;
}

GetVerifiedFromDoctorById(id) async {
  var verified;
  await FirebaseFirestore.instance
      .collection("Doctors")
      .doc(id)
      .get()
      .then((value) {
    verified = value.data()!["Verified"];
  });
  return verified;
}
