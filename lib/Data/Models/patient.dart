import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
}

updatePatientPrefs(Patient patient) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  prefs.setString("FullName", patient.username);
  prefs.setString("Password", patient.password);
  prefs.setString("PhoneNumber", patient.phoneNumber);
  prefs.setString("Age", patient.age);
  prefs.setString("Image", patient.image);
}

Update_Patient(Patient patient, password, context) async {
  final user = await FirebaseAuth.instance.currentUser;
  final cred =
      EmailAuthProvider.credential(email: patient.email, password: password);

  user?.reauthenticateWithCredential(cred).then((value) {
    user.updatePassword(patient.password).then((value) async {
      await FirebaseFirestore.instance
          .collection("Patients")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        "FullName": patient.username,
        'Password': patient.password,
        "PhoneNumber": patient.phoneNumber,
        "Age": patient.age,
        "Image": patient.image,
      });

      await updatePatientPrefs(patient);

      Navigator.pop(context);
      Navigator.pop(context, "refresh");
    });
  });
}

DeletePatientProfile(image) async {
  await FirebaseStorage.instance.refFromURL(image).delete();
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
