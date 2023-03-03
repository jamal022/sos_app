import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Presentation/DoctorScreens/Home/doctor_home_screen.dart';
import '../../Presentation/DoctorScreens/Profile/doctor_profile_screen.dart';
import '../../Presentation/PatientScreens/Home/patient_home_screen.dart';
import '../../Presentation/PatientScreens/Profile/patient_profile_screen.dart';
import '../../Presentation/Screens/App_Layout/bottom_nav_bar.dart';
import '../../Presentation/Screens/Chats/chats_screen.dart';
import '../../Presentation/Screens/Notifications/notifications_screen.dart';
import '../../Presentation/Screens/Settings/settings_screen.dart';
import '../../Presentation/Widgets/loading_widget.dart';
import '../Models/doctor.dart';
import '../Models/patient.dart';

Patient? patient;
late Doctor doctor;

savePatientPrefs(id, name, email, password, age, gender, phone, image) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("Id", id);
  prefs.setString("FullName", name);
  prefs.setString("Email", email);
  prefs.setString("Password", password);
  prefs.setString("PhoneNumber", phone);
  prefs.setString("Age", age);
  prefs.setString("Gender", gender);
  prefs.setString("Image", image);
  prefs.setString("Role", "Patient");
}

saveDoctorPrefs(
    {id,
    name,
    email,
    password,
    age,
    gender,
    phone,
    image,
    field,
    price,
    experience,
    bio,
    addLat,
    addLong,
    rate,
    verified}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("Id", id);
  prefs.setString("FullName", name);
  prefs.setString("Email", email);
  prefs.setString("Password", password);
  prefs.setString("PhoneNumber", phone);
  prefs.setString("Age", age);
  prefs.setString("Gender", gender);
  prefs.setString("Image", image);
  prefs.setString("Field", field);
  prefs.setString("YearsOfExperience", experience);
  prefs.setString("TicketPrice", price);
  prefs.setString("Bio", bio);
  prefs.setString("AddressLatitude", addLat);
  prefs.setString("AddressLongitude", addLong);
  prefs.setString("Rate", rate);
  prefs.setString("Verified", verified);
  prefs.setString("Role", "Doctor");
}

void route(id, context) async {
  FirebaseFirestore.instance
      .collection('Patients')
      .where("UserId", isEqualTo: id)
      .get()
      .then((value) async {
    if (value.docs.isNotEmpty) {
      patient = Patient(
          id: value.docs[0].id,
          username: value.docs[0].data()['FullName'],
          email: value.docs[0].data()['Email'],
          phoneNumber: value.docs[0].data()['PhoneNumber'],
          password: value.docs[0].data()['Password'],
          age: value.docs[0].data()['Age'],
          gender: value.docs[0].data()['Gender'],
          image: value.docs[0].data()['Image']);

      await savePatientPrefs(
          value.docs[0].id,
          value.docs[0].data()['FullName'],
          value.docs[0].data()['Email'],
          value.docs[0].data()['Password'],
          value.docs[0].data()['Age'],
          value.docs[0].data()['Gender'],
          value.docs[0].data()['PhoneNumber'],
          value.docs[0].data()['Image']);

      List<Widget> patientScreens = [
        const SettingScreen(),
        ChatsScreen(),
        const PatientHomeScreen(),
        NotificationsScreen(),
        PatientProfileScreen(),
      ];
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => BottomNavBar(
                  screens: patientScreens,
                )),
        (Route<dynamic> route) => false,
      );
    } else {
      await FirebaseFirestore.instance
          .collection('Doctors')
          .doc(id)
          .get()
          .then((snapshot) async {
        doctor = Doctor(
            id: id,
            username: snapshot.data()?['FullName'],
            email: snapshot.data()?['Email'],
            phoneNumber: snapshot.data()?['PhoneNumber'],
            password: snapshot.data()?['Password'],
            age: snapshot.data()?['Age'],
            gender: snapshot.data()?['Gender'],
            image: snapshot.data()?['Image'],
            field: snapshot.data()?['Field'],
            experience: snapshot.data()?['YearsOfExperience'],
            price: snapshot.data()?['TicketPrice'],
            addressLat: snapshot.data()?['AddressLatitude'],
            addressLong: snapshot.data()?['AddressLongitude'],
            bio: snapshot.data()?['Bio'],
            rate: snapshot.data()?["Rate"],
            verified: snapshot.data()?["Verified"]);
      });

      await saveDoctorPrefs(
          id: doctor.id,
          name: doctor.username,
          email: doctor.email,
          password: doctor.password,
          age: doctor.age,
          gender: doctor.gender,
          phone: doctor.phoneNumber,
          image: doctor.image,
          field: doctor.field,
          price: doctor.price,
          experience: doctor.experience,
          bio: doctor.bio,
          addLat: doctor.addressLat,
          addLong: doctor.addressLong,
          rate: doctor.rate.toString(),
          verified: doctor.verified.toString());

      List<Widget> doctorScreens = [
        const SettingScreen(),
        ChatsScreen(),
        const DoctorHomeScreen(),
        NotificationsScreen(),
        DoctorProfileScreen(),
      ];
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => BottomNavBar(
                  screens: doctorScreens,
                )),
        (Route<dynamic> route) => false,
      );
    }
  });
}

signIn(email, password, context, formKey) async {
  var formdata = formKey.currentState;
  if (formdata!.validate()) {
    formdata.save();
    try {
      showLoading(context);
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      route(userCredential.user!.uid, context);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Navigator.of(context).pop();
        AwesomeDialog(
          context: context,
          title: "Error",
          body: const Text(
            "No user found for that email",
          ),
        ).show();
      } else if (e.code == 'wrong-password') {
        Navigator.of(context).pop();
        AwesomeDialog(
                context: context,
                title: "Error",
                body: const Text("Wrong password provided for that user"))
            .show();
      }
    }
  } else {
    print("Not Vaild");
  }
}
