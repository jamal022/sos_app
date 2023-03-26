import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Presentation/PatientScreens/Home/patient_home_screen.dart';
import '../../Presentation/PatientScreens/Profile/patient_edit_screen.dart';
import '../../Presentation/PatientScreens/Profile/patient_profile_screen.dart';
import '../../Presentation/Screens/App_Layout/bottom_nav_bar.dart';
import '../../Presentation/Screens/Chats/chats_screen.dart';
import '../../Presentation/Screens/Notifications/notifications_screen.dart';
import '../../Presentation/Screens/Settings/settings_screen.dart';

class Patient {
  var username;
  var email;
  var phoneNumber;
  var password;
  var age;
  var gender;
  var image;
  var id;
  var token;

  Patient(
      {this.username,
      this.id,
      this.email,
      this.phoneNumber,
      this.password,
      this.age,
      this.gender,
      this.image,
      this.token});

  updatePatientPrefs(
      id, name, email, password, age, gender, phone, image, token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    prefs.setString("Id", id);
    prefs.setString("FullName", name);
    prefs.setString("Email", email);
    prefs.setString("Password", password);
    prefs.setString("PhoneNumber", phone);
    prefs.setString("Age", age);
    prefs.setString("Gender", gender);
    prefs.setString("Image", image);
    prefs.setString("Token", token);
    prefs.setString("Role", "Patient");
  }

  Update_Patient(Patient patient, formkey, context) async {
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

      await updatePatientPrefs(
          patient.id,
          patient.username,
          patient.email,
          patient.password,
          patient.age,
          patient.gender,
          patient.phoneNumber,
          patient.image,
          patient.token);

      Navigator.pop(context, "refresh");
    } else {
      print("not valid");
    }
  }
}

UpdatePatientToken(patientId, token) async {
  await FirebaseFirestore.instance
      .collection("Patients")
      .doc(patientId)
      .update({"Token": token}).then((value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("Token", token);
  });
  return "updated";
}
