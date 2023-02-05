import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sos_app/Data/Models/patient.dart';
import 'package:sos_app/Presentation/PatientScreens/Home/DetectScreens/report_screen.dart';
import 'package:printing/printing.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:sos_app/Presentation/Widgets/loading_widget.dart';

import '../../Presentation/Widgets/printable_report.dart';

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
    showLoading(context);
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

GetReportId(Report report) async {
  var reportId;
  await FirebaseFirestore.instance
      .collection("Reports")
      .where("PatientId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .where("BurnDegree", isEqualTo: report.burnDegree)
      .where("Date", isEqualTo: report.Date)
      .where("CauseOfBurn", isEqualTo: report.causeOfBurn)
      .get()
      .then((value) {
    reportId = value.docs.first.id;
  });
  return reportId;
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

Future<void> printReport(Report report) async {
  var image = await networkImage(
    report.image,
  );
  final doc = pw.Document();
  doc.addPage(pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return buildPrintableData(report, image);
      }));
  await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => doc.save());
}
