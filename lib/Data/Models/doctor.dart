import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sos_app/Data/Authentication/login.dart';
import 'package:sos_app/Data/Models/patient.dart';
import 'package:sos_app/Presentation/Constants/app_assets.dart';

import '../../Presentation/DoctorScreens/Home/doctor_home_screen.dart';
import '../../Presentation/DoctorScreens/Profile/doctor_profile_screen.dart';
import '../../Presentation/PatientScreens/Profile/patient_edit_screen.dart';
import '../../Presentation/Screens/App_Layout/bottom_nav_bar.dart';
import '../../Presentation/Screens/Chats/chats_screen.dart';
import '../../Presentation/Screens/Notifications/notifications_screen.dart';
import '../../Presentation/Screens/Settings/settings_screen.dart';

class Doctor extends Patient {
  var field;
  var experience;
  var price;
  var addressLat;
  var addressLong;
  var bio;

  Doctor(
      {required username,
      required email,
      required phoneNumber,
      required password,
      required age,
      required gender,
      required image,
      required this.field,
      required this.experience,
      required this.price,
      required this.addressLat,
      required this.addressLong,
      required this.bio})
      : super(
            username: username,
            email: email,
            phoneNumber: phoneNumber,
            password: password,
            age: age,
            gender: gender,
            image: image) {}

  updateDoctorsPrefs(name, email, password, age, gender, phone, image, field,
      price, experience, bio, lan, lon) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    prefs.setString("FullName", name);
    prefs.setString("Email", email);
    prefs.setString("Password", password);
    prefs.setString("PhoneNumber", phone);
    prefs.setString("Age", age);
    prefs.setString("Gender", gender);
    prefs.setString("Image", image);
    prefs.setString("Field", field);
    prefs.setString("TicketPrice", price);
    prefs.setString("YearsOfExperience", experience);
    prefs.setString("Bio", bio);
    prefs.setString("AddressLatitude", lan);
    prefs.setString("AddressLongitude", lon);
    prefs.setString("Role", "Doctor");
  }

  Update_Doctor(Doctor doctor, formkey, context) async {
    var formdata = formKey.currentState;
    if (formdata!.validate()) {
      formdata.save();
      await FirebaseFirestore.instance
          .collection("Doctors")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        "FullName": doctor.username,
        "Email": doctor.email,
        'Password': doctor.password,
        "PhoneNumber": doctor.phoneNumber,
        "Age": doctor.age,
        "Field": doctor.field,
        "TicketPrice": doctor.price,
        "YearsOfExperience": doctor.experience,
        "Bio": doctor.bio
      });
      await updateDoctorsPrefs(
          doctor.username,
          doctor.email,
          doctor.password,
          doctor.age,
          doctor.gender,
          doctor.phoneNumber,
          doctor.image,
          doctor.field,
          doctor.price,
          doctor.experience,
          doctor.bio,
          doctor.addressLat,
          doctor.addressLong);

      List<Widget> doctorScreens = [
        const SettingScreen(),
        ChatsScreen(),
        const DoctorHomeScreen(),
        NotificationsScreen(),
        DoctorProfileScreen(
          doctor: doctor,
        ),
      ];
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => BottomNavBar(
                  screens: doctorScreens,
                )),
        (Route<dynamic> route) => false,
      );
    } else {
      print("not valid");
    }
  }
}

getDoctors() async {
  List<Doctor> doctors = [];
  await FirebaseFirestore.instance.collection('Doctors').get().then((value) {
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

      doctors.insert(i, dr);
    }
  });
  return doctors;
}
