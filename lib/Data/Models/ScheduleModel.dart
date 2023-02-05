import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sos_app/Data/Models/doctor.dart';
import 'package:sos_app/Presentation/Screens/App_Layout/bottom_nav_bar.dart';
import 'package:sos_app/Presentation/Widgets/loading_widget.dart';

import '../../Presentation/DoctorScreens/Home/doctor_home_screen.dart';
import '../../Presentation/DoctorScreens/Profile/doctor_profile_screen.dart';
import '../../Presentation/Screens/Chats/chats_screen.dart';
import '../../Presentation/Screens/Notifications/notifications_screen.dart';
import '../../Presentation/Screens/Settings/settings_screen.dart';

class Schedule {
  var doctorId;
  var doctorName;
  var day;
  var month;
  var year;
  var fromTime;
  var fromPeriod;
  var toTime;
  var toPeriod;
  var maxNbAppoitments;
  var nbAppoinments;

  Schedule({
    required this.doctorId,
    required this.doctorName,
    required this.day,
    required this.month,
    required this.year,
    required this.fromTime,
    required this.fromPeriod,
    required this.toPeriod,
    required this.toTime,
    required this.maxNbAppoitments,
    required this.nbAppoinments,
  });
}

AddSchedule(Schedule schedule, context) async {
  var exist = false;
  List<Schedule> scs = await GetSchedules(schedule.doctorName);
  for (var item in scs) {
    if (schedule.day == item.day &&
        schedule.month == item.month &&
        schedule.year == item.year) {
      exist = true;
      break;
    }
  }
  if (exist == true) {
    AwesomeDialog(
      context: context,
      title: "Error",
      body: const Text(
        "This Schedule is already exist",
      ),
    ).show();
  } else {
    showLoading(context);
    await FirebaseFirestore.instance.collection("Schedules").add({
      "DoctorId": schedule.doctorId,
      "DoctorName": schedule.doctorName,
      "Day": schedule.day,
      "Month": schedule.month,
      "Year": schedule.year,
      "FromTime": schedule.fromTime,
      "FromPeriod": schedule.fromPeriod,
      "ToTime": schedule.toTime,
      "ToPeriod": schedule.toPeriod,
      "MaxNbOfAppointments": schedule.maxNbAppoitments,
      "NbOfAppoitments": schedule.nbAppoinments,
    }).then((value) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      Doctor doc = Doctor(
        username: prefs.getString("FullName"),
        email: prefs.getString("Email"),
        password: prefs.getString("Password"),
        phoneNumber: prefs.getString("PhoneNumber"),
        age: prefs.getString("Age"),
        gender: prefs.getString("Gender"),
        image: prefs.getString("Image"),
        field: prefs.getString("Field"),
        experience: prefs.getString("YearsOfExperience"),
        price: prefs.getString("TicketPrice"),
        bio: prefs.getString("Bio"),
        addressLat: prefs.getString("AddressLatitude"),
        addressLong: prefs.getString("AddressLongitude"),
      );

      List<Widget> doctorScreens = [
        const SettingScreen(),
        ChatsScreen(),
        const DoctorHomeScreen(),
        NotificationsScreen(),
        DoctorProfileScreen(doctor: doc),
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
}

GetSchedules(doctorName) async {
  List<Schedule> schedules = [];
  await FirebaseFirestore.instance
      .collection("Schedules")
      .where("DoctorName", isEqualTo: doctorName)
      .get()
      .then((value) {
    for (var schedule in value.docs) {
      Schedule s = Schedule(
        doctorId: schedule.data()["DoctorId"],
        doctorName: schedule.data()["DoctorName"],
        day: schedule.data()["Day"],
        month: schedule.data()["Month"],
        year: schedule.data()["Year"],
        fromTime: schedule.data()["FromTime"],
        fromPeriod: schedule.data()["FromPeriod"],
        toTime: schedule.data()["ToTime"],
        toPeriod: schedule.data()["ToPeriod"],
        maxNbAppoitments: schedule.data()["MaxNbOfAppointments"],
        nbAppoinments: schedule.data()["NbOfAppoitments"],
      );
      schedules.add(s);
    }
  });
  return schedules;
}

DeleteSchedule(Schedule sc) async {
  await FirebaseFirestore.instance
      .collection("Schedules")
      .where("DoctorId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .where("Day", isEqualTo: sc.day)
      .where("Month", isEqualTo: sc.month)
      .where("Year", isEqualTo: sc.year)
      .get()
      .then((value) async {
    await FirebaseFirestore.instance
        .collection("Schedules")
        .doc(value.docs.first.id)
        .delete();
  });
  return "deleted";
}

AddAppointmentToSchedule({doctorName, day, month, year}) async {
  var number;
  await FirebaseFirestore.instance
      .collection("Schedules")
      .where("DoctorName", isEqualTo: doctorName)
      .where("Day", isEqualTo: day)
      .where("Month", isEqualTo: month)
      .where("Year", isEqualTo: year)
      .get()
      .then((value) async {
    number = value.docs.first.data()["NbOfAppointments"];

    if (number == null) {
      number = 1;
    } else {
      number = number + 1;
    }

    await FirebaseFirestore.instance
        .collection("Schedules")
        .doc(value.docs.first.id)
        .update({
      "NbOfAppointments": number,
    });
  });
}
