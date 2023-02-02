import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sos_app/Data/Models/DoctorAppointmentsModel.dart';
import 'package:sos_app/Presentation/Constants/app_assets.dart';
import 'package:sos_app/Presentation/DoctorScreens/Home/Schedule/Schedule_screen.dart';
import 'package:sos_app/Presentation/Screens/App_Layout/bottom_nav_bar.dart';
import 'package:sos_app/Presentation/Widgets/loading_widget.dart';

class Schedule {
  var doctorId;
  var day;
  var month;
  var year;
  var fromTime;
  var fromPeriod;
  var toTime;
  var toPeriod;

  Schedule({
    required this.doctorId,
    required this.day,
    required this.month,
    required this.year,
    required this.fromTime,
    required this.fromPeriod,
    required this.toPeriod,
    required this.toTime,
  });
}

AddSchedule(Schedule schedule, context) async {
  var exist = false;
  List<Schedule> scs = await GetSchedules();
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
      "Day": schedule.day,
      "Month": schedule.month,
      "Year": schedule.year,
      "FromTime": schedule.fromTime,
      "FromPeriod": schedule.fromPeriod,
      "ToTime": schedule.toTime,
      "ToPeriod": schedule.toPeriod,
    }).then((value) {
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

GetSchedules() async {
  List<Schedule> schedules = [];
  await FirebaseFirestore.instance
      .collection("Schedules")
      .where("DoctorId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .get()
      .then((value) {
    for (var schedule in value.docs) {
      Schedule s = Schedule(
        doctorId: schedule.data()["DoctorId"],
        day: schedule.data()["Day"],
        month: schedule.data()["Month"],
        year: schedule.data()["Year"],
        fromTime: schedule.data()["FromTime"],
        fromPeriod: schedule.data()["FromPeriod"],
        toTime: schedule.data()["ToTime"],
        toPeriod: schedule.data()["ToPeriod"],
      );
      schedules.add(s);
    }
  });
  return schedules;
}
