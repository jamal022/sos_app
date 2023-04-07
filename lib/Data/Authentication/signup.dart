import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:sos_app/Presentation/Screens/SignUp/doctorSignup_screen.dart';
import '../../Presentation/Screens/Login/login_screen.dart';
import '../Models/NotificationModel.dart';
import '../Models/doctor.dart';
import '../Models/patient.dart';

Register(
    {BuildContext? context,
    username,
    email,
    password,
    phone,
    age,
    gender,
    image,
    role}) async {
  try {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      if (role == "patient") {
        Patient patient = Patient(
            username: username,
            email: email,
            phoneNumber: phone,
            password: password,
            age: age,
            gender: gender,
            image: image,
            token: FirebaseMessaging.instance.getToken());
        AddPatient(patient, value.user!.uid, context);
      } else if (role == "doctor") {
        Navigator.of(context!).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (_) => DoctorSignupScreen(
                  name: username,
                  email: email,
                  phone: phone,
                  password: password,
                  age: age,
                  gender: gender,
                  image: image,
                  id: value.user!.uid)),
          (Route<dynamic> route) => false,
        );
      }
    });
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      Navigator.of(context!).pop();
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        headerAnimationLoop: false,
        title: 'Error',
        desc: 'Password is too weak',
      ).show();
    } else if (e.code == 'email-already-in-use') {
      Navigator.of(context!).pop();
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        headerAnimationLoop: false,
        title: 'Error',
        desc: 'Email-already-in-use',
      ).show();
    }
  } catch (e) {
    Navigator.of(context!).pop();
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.rightSlide,
      headerAnimationLoop: false,
      title: 'Error',
      desc: "$e",
    ).show();
  }
}

AddPatient(Patient patient, id, context) async {
  await FirebaseFirestore.instance.collection("Patients").doc(id).set({
    "FullName": patient.username,
    "Email": patient.email,
    "Password": patient.password,
    "PhoneNumber": patient.phoneNumber,
    "Gender": patient.gender,
    "Age": patient.age,
    "Image": patient.image,
    "Token": "0"
  }).then((value) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
      (Route<dynamic> route) => false,
    );
  });
}

AddDoctor(Doctor? doctor, context, id) async {
  await FirebaseFirestore.instance.collection("Doctors").doc(id).set({
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
    "Token": doctor?.token,
  }).then((value) {
    SendNotifyToUser('Your account was pending until the admin verify it',
        doctor?.token, id);
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
      (Route<dynamic> route) => false,
    );
  });
}
