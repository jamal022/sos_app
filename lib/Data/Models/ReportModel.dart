import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sos_app/Data/Models/patient.dart';
import 'package:sos_app/Presentation/PatientScreens/Home/DetectScreens/report_screen.dart';

class Report {
  String image;
  String burnDegree;
  String name;
  String age;
  String gender;
  String phoneNumber;
  String diabates;
  String pressure;
  String causeOfBurn;
  String Date;

  Report(
      {required this.image,
      required this.burnDegree,
      required this.name,
      required this.age,
      required this.gender,
      required this.phoneNumber,
      required this.diabates,
      required this.pressure,
      required this.causeOfBurn,
      required this.Date});

  AddReport(Report report, context) async {
    await FirebaseFirestore.instance.collection("Reports").add({
      "PatientId": FirebaseAuth.instance.currentUser!.uid,
      "Image": report.image,
      "BurnDegree": report.burnDegree,
      "Diabates": report.diabates,
      "BloodPressure": report.pressure,
      "Date": report.Date,
      "CauseOfBurn": report.causeOfBurn,
    }).then((value) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => ReportScreen(
                  report: report,
                )),
        (Route<dynamic> route) => false,
      );
    });
  }
}

GetReports(Patient patient, context) async {
  List<Report> reports = [];
  await FirebaseFirestore.instance
      .collection("Reports")
      .where("PatientId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .get()
      .then((value) {
    for (var report in value.docs) {
      Report r = Report(
          image: report.data()["Image"],
          burnDegree: report.data()["BurnDegree"],
          name: patient.username,
          age: patient.age,
          gender: patient.gender,
          phoneNumber: patient.phoneNumber,
          diabates: report.data()["Diabates"],
          pressure: report.data()["BloodPressure"],
          causeOfBurn: report.data()["CauseOfBurn"],
          Date: report.data()["Date"]);
      reports.add(r);
    }
  });
  return reports;
}
