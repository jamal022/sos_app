import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sos_app/Data/Models/AppointmentModel.dart';
import 'package:sos_app/Presentation/Widgets/loading_widget.dart';

class Schedule {
  var scheduleId;
  var doctorId;
  var day;
  var month;
  var year;
  var fromTime;
  var toTime;

  Schedule({
    this.scheduleId,
    required this.doctorId,
    required this.day,
    required this.month,
    required this.year,
    required this.fromTime,
    required this.toTime,
  });
}

class TimeSlots {
  var timeSlotId;
  var time;
  var status;
  TimeSlots({this.timeSlotId, required this.time, required this.status});
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
      dialogType: DialogType.error,
      animType: AnimType.rightSlide,
      headerAnimationLoop: false,
      title: 'Error',
      desc: 'This Schedule is already exist',
    ).show();
  } else {
    showLoading(context);
    await FirebaseFirestore.instance.collection("Schedules").add({
      "DoctorId": schedule.doctorId,
      "Day": schedule.day,
      "Month": schedule.month,
      "Year": schedule.year,
      "FromTime": schedule.fromTime,
      "ToTime": schedule.toTime,
    }).then((value) async {
      DocumentReference sch = await FirebaseFirestore.instance
          .collection("Schedules")
          .doc(value.id);

      List<int> timeSlots = [];
      var counter;
      if (schedule.toTime > schedule.fromTime) {
        counter = schedule.toTime - schedule.fromTime;
        timeSlots.add(schedule.fromTime);
        var time = schedule.fromTime;
        for (int i = 1; i <= counter - 1; i++) {
          time++;
          timeSlots.add(time);
        }
      } else if (schedule.fromTime > schedule.toTime) {
        var first;
        first = 24 - schedule.fromTime;
        timeSlots.add(schedule.fromTime);
        var time = schedule.fromTime;
        for (int i = 1; i <= first; i++) {
          time++;
          timeSlots.add(time);
        }
        counter = schedule.toTime - 1;
        for (int i = 1; i <= counter; i++) {
          timeSlots.add(i);
        }
      }
      for (var i = 0; i < timeSlots.length; i++) {
        await sch.collection("TimeSlots").add({
          "Time": timeSlots[i],
          "Status": 0,
        });
      }
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
        scheduleId: schedule.id,
        doctorId: schedule.data()["DoctorId"],
        day: schedule.data()["Day"],
        month: schedule.data()["Month"],
        year: schedule.data()["Year"],
        fromTime: schedule.data()["FromTime"],
        toTime: schedule.data()["ToTime"],
      );
      schedules.add(s);
    }
  });
  return schedules;
}

GetSchedulesForPatient(doctorId) async {
  List<Schedule> schedules = [];
  var month = DateTime.now().month;
  var year = DateTime.now().year;
  await FirebaseFirestore.instance
      .collection("Schedules")
      .where("DoctorId", isEqualTo: doctorId)
      .get()
      .then((value) {
    for (var schedule in value.docs) {
      if (schedule.data()["Month"] >= month &&
          schedule.data()["Year"] >= year) {
        Schedule s = Schedule(
          scheduleId: schedule.id,
          doctorId: schedule.data()["DoctorId"],
          day: schedule.data()["Day"],
          month: schedule.data()["Month"],
          year: schedule.data()["Year"],
          fromTime: schedule.data()["FromTime"],
          toTime: schedule.data()["ToTime"],
        );
        schedules.add(s);
      }
    }
  });
  return schedules;
}

Stream<QuerySnapshot> GetTimeSlots(id) {
  DocumentReference schedule =
      FirebaseFirestore.instance.collection("Schedules").doc(id);
  return schedule
      .collection("TimeSlots")
      .where("Status", isEqualTo: 0)
      .snapshots();
}

UpdateTimeStatus(scheduleId, timeId) async {
  DocumentReference schedule =
      await FirebaseFirestore.instance.collection("Schedules").doc(scheduleId);
  await schedule.collection("TimeSlots").doc(timeId).update({"Status": 1});
}

UpdateTimeInCancel(doctorId, date, time) async {
  var array = date.split('/');
  var day = int.parse(array[0]);
  var month = int.parse(array[1]);
  var year = int.parse(array[2]);
  var array2 = time.split(':');
  var timesolt = int.parse(array2[0]);
  var scheduleId;
  await FirebaseFirestore.instance
      .collection("Schedules")
      .where("DoctorId", isEqualTo: doctorId)
      .where("Day", isEqualTo: day)
      .where("Month", isEqualTo: month)
      .where("Year", isEqualTo: year)
      .get()
      .then((value) async {
    scheduleId = value.docs.first.id;
    DocumentReference schedule = await FirebaseFirestore.instance
        .collection("Schedules")
        .doc(scheduleId);
    await schedule
        .collection("TimeSlots")
        .where("Time", isEqualTo: timesolt)
        .get()
        .then((value) async {
      await schedule
          .collection("TimeSlots")
          .doc(value.docs.first.id)
          .update({"Status": 0});
    });
  });
}

DeleteSchedule(id, doctorId, doctorName, context) async {
  showLoading(context);
  DocumentReference sch =
      await FirebaseFirestore.instance.collection("Schedules").doc(id);
  await sch.collection("TimeSlots").get().then((value) async {
    for (var time in value.docs) {
      await sch.collection("TimeSlots").doc(time.id).delete();
    }
  }).then((value) async {
    await FirebaseFirestore.instance
        .collection("Schedules")
        .doc(id)
        .get()
        .then((value) async {
      var date =
          "${value.data()!["Day"]} / ${value.data()!["Month"]} / ${value.data()!["Year"]}";
      await FirebaseFirestore.instance
          .collection("Appointments")
          .where("Date", isEqualTo: date)
          .get()
          .then((value) async {
        for (var i = 0; i < value.docs.length; i++) {
          DeleteAppointment(
              appId: value.docs[i].id,
              date: date,
              doctorId: doctorId,
              doctorName: doctorName,
              patientId: value.docs[i].data()["PatientId"],
              role: "Doctor");
        }
      });
    });

    sch.delete();
  });
  Navigator.pop(context);

  return "deleted";
}
