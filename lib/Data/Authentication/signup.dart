import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../Presentation/Screens/Login/login_screen.dart';
import '../../Presentation/Widgets/loading_widget.dart';
import '../Models/doctor.dart';
import '../Models/patient.dart';

Register({Patient? patient, Doctor? doctor, BuildContext? context}) async {
  late UserCredential _user;

  showLoading(context);

  try {
    if (patient != null) {
      _user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: patient.email, password: patient.password);
    } else if (doctor != null) {
      _user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: doctor.email, password: doctor.password);
    }
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      Navigator.of(context!).pop();
      AwesomeDialog(
              context: context,
              title: "Error",
              body: const Text("Password is too weak"))
          .show();
    } else if (e.code == 'email-already-in-use') {
      Navigator.of(context!).pop();
      AwesomeDialog(
              context: context,
              title: "Error",
              body: const Text("email-already-in-use"))
          .show();
    }
  } catch (e) {
    Navigator.of(context!).pop();
    AwesomeDialog(
      context: context,
      title: "Error",
      body: Text("$e"),
    ).show();
  }
  if (patient != null) {
    AddPatient(patient, _user.user!.uid, context);
  } else if (doctor != null) {
    AddDoctor(doctor, _user.user!.uid, context);
  }
}

AddPatient(Patient? patient, id, context) async {
  showLoading(context);
  await FirebaseFirestore.instance
      .collection("Patients")
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .set({
    "UserId": id,
    "FullName": patient?.username,
    "Email": patient?.email,
    "Password": patient?.password,
    "PhoneNumber": patient?.phoneNumber,
    "Gender": patient?.gender,
    "Age": patient?.age,
    "Image": patient?.image,
  }).then((value) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
      (Route<dynamic> route) => false,
    );
  });
}

AddDoctor(Doctor? doctor, id, context) async {
  await FirebaseFirestore.instance
      .collection("Doctors")
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .set({
    "UserId": id,
    "FullName": doctor?.username,
    "Email": doctor?.email,
    "Password": doctor?.password,
    "PhoneNumber": doctor?.phoneNumber,
    "Gender": doctor?.gender,
    "Age": doctor?.age,
    "Image": doctor?.image,
    "Field": doctor?.field,
    "YearsOfExperience": doctor?.experience,
    "TicketPrice": doctor?.price,
    "AddressLatitude": doctor?.addressLat,
    "AddressLongitude": doctor?.addressLong,
    "Bio": doctor?.bio,
    "Verified": doctor?.verified,
    "IdImage": doctor?.idImage,
    "Rate": doctor?.rate,
  }).then((value) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
      (Route<dynamic> route) => false,
    );
  });
}
