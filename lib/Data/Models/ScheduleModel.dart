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
  var maxNbAppointments;
  var nbAppointments;

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
    required this.maxNbAppointments,
    required this.nbAppointments,
  });
}

AddSchedule(Schedule schedule, context) async {
  var exist = false;
  List<Schedule> scs = await GetSchedulesForDoctor(schedule.doctorId);
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
      "MaxNbOfAppointments": schedule.maxNbAppointments,
      "NbOfAppointments": schedule.nbAppointments,
    }).then((value) => Navigator.pop(context));
    return "Added";
  }
}

GetSchedulesForDoctor(doctorId) async {
  List<Schedule> schedules = [];
  await FirebaseFirestore.instance
      .collection("Schedules")
      .where("DoctorId", isEqualTo: doctorId)
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
        maxNbAppointments: schedule.data()["MaxNbOfAppointments"],
        nbAppointments: schedule.data()["NbOfApponitments"] == null
            ? "0"
            : schedule.data()["NbOfAppointments"],
      );
      schedules.add(s);
    }
  });
  return schedules;
}

GetSchedulesForPatient(doctorId) async {
  List<Schedule> schedules = [];
  var today = DateTime.now().day;
  var month = DateTime.now().month;
  var year = DateTime.now().year;
  await FirebaseFirestore.instance
      .collection("Schedules")
      .where("DoctorId", isEqualTo: doctorId)
      .get()
      .then((value) {
    for (var schedule in value.docs) {
      if (schedule.data()["Day"] >= today &&
          schedule.data()["Month"] >= month &&
          schedule.data()["Year"] >= year) {
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
          maxNbAppointments: schedule.data()["MaxNbOfAppointments"],
          nbAppointments: schedule.data()["NbOfAppointments"] == null
              ? 0
              : schedule.data()["NbOfAppointments"],
        );
        schedules.add(s);
      }
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

AddAppointmentToSchedule({doctorId, day, month, year}) async {
  var number;
  await FirebaseFirestore.instance
      .collection("Schedules")
      .where("DoctorId", isEqualTo: doctorId)
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

DeleteAppointmentFromSchedule({doctorId, date}) async {
  var number;
  var array = date.split('/');
  var day = int.parse(array[0]);
  var month = int.parse(array[1]);
  var year = int.parse(array[2]);
  await FirebaseFirestore.instance
      .collection("Schedules")
      .where("DoctorId", isEqualTo: doctorId)
      .where("Day", isEqualTo: day)
      .where("Month", isEqualTo: month)
      .where("Year", isEqualTo: year)
      .get()
      .then((value) async {
    number = value.docs.first.data()["NbOfAppointments"];
    print("==================${number}========");
    number = number - 1;
    await FirebaseFirestore.instance
        .collection("Schedules")
        .doc(value.docs.first.id)
        .update({
      "NbOfAppointments": number,
    });
  });
}
