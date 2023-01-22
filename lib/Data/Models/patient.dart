import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Presentation/PatientScreens/Profile/patient_edit_screen.dart';

class Patient {
  var username;
  var email;
  var phoneNumber;
  var password;
  var age;
  var gender;
  var image;

  Patient(
      {this.username,
      this.email,
      this.phoneNumber,
      this.password,
      this.age,
      this.gender,
      this.image});

  updatePatientPrefs(name, email, password, age, gender, phone, image) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    prefs.setString("FullName", name);
    prefs.setString("Email", email);
    prefs.setString("Password", password);
    prefs.setString("PhoneNumber", phone);
    prefs.setString("Age", age);
    prefs.setString("Gender", gender);
    prefs.setString("Image", image);
    prefs.setString("Role", "Patient");
  }

  Update_Patient(Patient patient, GlobalKey<FormState>? formkey) async {
    var formdata = formKey.currentState;
    if (formdata!.validate()) {
      formdata.save();
      final PUser = await FirebaseFirestore.instance
          .collection("Patients")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        "FullName": patient.username,
        "Email": patient.email,
        'Password': patient.password,
        "PhoneNumber": patient.phoneNumber,
        "Age": patient.age,
        "Image": patient.image,
      });
    }
    updatePatientPrefs(patient.username, patient.email, patient.password,
        patient.age, patient.gender, patient.phoneNumber, patient.image);
  }
}
