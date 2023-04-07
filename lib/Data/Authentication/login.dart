import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sos_app/Presentation/AdminScreens/admin_home_screen.dart';
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

savePatientPrefs(Patient pat) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("Id", pat.id);
  prefs.setString("FullName", pat.username);
  prefs.setString("Email", pat.email);
  prefs.setString("Password", pat.password);
  prefs.setString("PhoneNumber", pat.phoneNumber);
  prefs.setString("Age", pat.age);
  prefs.setString("Gender", pat.gender);
  prefs.setString("Image", pat.image);
  prefs.setString("Token", pat.token);
  prefs.setString("Role", "Patient");
}

saveDoctorPrefs(Doctor doc) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("Id", doc.id);
  prefs.setString("FullName", doc.username);
  prefs.setString("Email", doc.email);
  prefs.setString("Password", doc.password);
  prefs.setString("PhoneNumber", doc.phoneNumber);
  prefs.setString("Age", doc.age);
  prefs.setString("Gender", doc.gender);
  prefs.setString("Image", doc.image);
  prefs.setString("Field", doc.field);
  prefs.setString("YearsOfExperience", doc.experience);
  prefs.setString("TicketPrice", doc.price);
  prefs.setString("Bio", doc.bio);
  prefs.setDouble("AddressLatitude", doc.addressLat);
  prefs.setDouble("AddressLongitude", doc.addressLong);
  prefs.setString("Rate", doc.rate);
  prefs.setInt("Verified", doc.verified);
  prefs.setString("Token", doc.token);
  prefs.setString("Role", "Doctor");
  prefs.setString("IdImage", doc.idImage);
}

void route(id, context) async {
  if (id == "Tl8TuHlLYpVf9lWdPcJmu79h6sj2") {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("Role", "admin");
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const AdminHomeScreen()),
      (Route<dynamic> route) => false,
    );
  } else {
    FirebaseFirestore.instance
        .collection('Patients')
        .doc(id)
        .get()
        .then((value) async {
      if (value.exists) {
        Patient patient = Patient(
          id: value.id,
          username: value.data()!['FullName'],
          email: value.data()!['Email'],
          phoneNumber: value.data()!['PhoneNumber'],
          password: value.data()!['Password'],
          age: value.data()!['Age'],
          gender: value.data()!['Gender'],
          image: value.data()!['Image'],
          token: value.data()!['Token'],
        );

        await savePatientPrefs(patient);

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
            .then((value) async {
          Doctor doctor = Doctor(
              id: value.id,
              username: value.data()?['FullName'],
              email: value.data()?['Email'],
              phoneNumber: value.data()?['PhoneNumber'],
              password: value.data()?['Password'],
              age: value.data()?['Age'],
              gender: value.data()?['Gender'],
              image: value.data()?['Image'],
              field: value.data()?['Field'],
              experience: value.data()?['YearsOfExperience'],
              price: value.data()?['TicketPrice'],
              addressLat: value.data()?['AddressLatitude'],
              addressLong: value.data()?['AddressLongitude'],
              bio: value.data()?['Bio'],
              rate: value.data()?["Rate"],
              verified: value.data()?["Verified"],
              token: value.data()?["Token"],
              idImage: value.data()?["IdImage"]);
          await saveDoctorPrefs(doctor);
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
        });
      }
    });
  }
}

signIn(email, password, context, formKey) async {
  var formdata = formKey.currentState;
  if (formdata!.validate()) {
    formdata.save();
    try {
      showLoading(context);
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) => route(value.user!.uid, context));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Navigator.of(context).pop();
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.rightSlide,
          headerAnimationLoop: false,
          title: 'Error',
          desc: 'No user found for that email',
        ).show();
      } else if (e.code == 'wrong-password') {
        Navigator.of(context).pop();
        AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.rightSlide,
          headerAnimationLoop: false,
          title: 'Error',
          desc: 'Wrong password provided for that user',
        ).show();
      }
    }
  } else {
    print("Not Vaild");
  }
}
