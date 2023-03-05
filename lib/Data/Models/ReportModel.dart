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
  var reportId;
  var patientId;
  var image;
  var burnDegree;
  var name;
  var age;
  var gender;
  var phoneNumber;
  var diabates;
  var pressure;
  var causeOfBurn;
  var date;

  Report(
      {this.reportId,
      this.image,
      this.burnDegree,
      this.name,
      this.age,
      this.gender,
      this.phoneNumber,
      this.diabates,
      this.pressure,
      this.causeOfBurn,
      this.date,
      this.patientId});

  AddReport(Report report, context) async {
    showLoading(context);
    await FirebaseFirestore.instance.collection("Reports").add({
      "PatientId": FirebaseAuth.instance.currentUser!.uid,
      "PatientName": report.name,
      "Age": report.age,
      "Gender": report.gender,
      "PhoneNumber": report.phoneNumber,
      "Image": report.image,
      "BurnDegree": report.burnDegree,
      "Diabates": report.diabates,
      "BloodPressure": report.pressure,
      "Date": report.date,
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
      .where("Date", isEqualTo: report.date)
      .where("CauseOfBurn", isEqualTo: report.causeOfBurn)
      .get()
      .then((value) {
    reportId = value.docs.first.id;
  });
  return reportId;
}

GetReportById(reportId) async {
  Report report = Report();
  await FirebaseFirestore.instance
      .collection("Reports")
      .doc(reportId)
      .get()
      .then((value) {
    report.image = value.data()!["Image"];
    report.age = value.data()!["Age"];
    report.burnDegree = value.data()!["BurnDegree"];
    report.causeOfBurn = value.data()!["CauseOfBurn"];
    report.date = value.data()!["Date"];
    report.diabates = value.data()!["Diabates"];
    report.gender = value.data()!["Gender"];
    report.name = value.data()!["PatientName"];
    report.patientId = value.data()!["PatientId"];
    report.pressure = value.data()!["BloodPressure"];
    report.phoneNumber = value.data()!["PhoneNumber"];
  });
  return report;
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
          reportId: report.id,
          patientId: report.data()["PatientId"],
          image: report.data()["Image"],
          burnDegree: report.data()["BurnDegree"],
          name: patient.username,
          age: patient.age,
          gender: patient.gender,
          phoneNumber: patient.phoneNumber,
          diabates: report.data()["Diabates"],
          pressure: report.data()["BloodPressure"],
          causeOfBurn: report.data()["CauseOfBurn"],
          date: report.data()["Date"]);
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

DeleteReport(report, context) async {
  await FirebaseFirestore.instance
      .collection("Reports")
      .where("PatientId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .where("BurnDegree", isEqualTo: report.burnDegree)
      .where("Date", isEqualTo: report.date)
      .where("CauseOfBurn", isEqualTo: report.causeOfBurn)
      .get()
      .then((value) async {
    await FirebaseFirestore.instance
        .collection("Reports")
        .doc(value.docs.first.id)
        .delete();
  }).then((value) => Navigator.pop(context));

  return "deleted";
}
