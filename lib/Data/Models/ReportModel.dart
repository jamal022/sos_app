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
  var confidence;
  var firstAid;

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
      this.patientId,
      this.confidence,
      this.firstAid});
}

AddReport(Report report, context) async {
  showLoading(context);
  await FirebaseFirestore.instance.collection("Reports").add({
    "PatientId": report.patientId,
    "Image": report.image,
    "BurnDegree": report.burnDegree,
    "Diabates": report.diabates,
    "BloodPressure": report.pressure,
    "Date": report.date,
    "CauseOfBurn": report.causeOfBurn,
    "Confidence": report.confidence,
    "FirstAid": report.firstAid
  }).then((value) async {
    report.reportId = value.id;
    await FirebaseFirestore.instance
        .collection("Patients")
        .doc(report.patientId)
        .get()
        .then((value) {
      report.name = value.data()!["FullName"];
      report.gender = value.data()!["Gender"];
      report.age = value.data()!["Age"];
      report.phoneNumber = value.data()!["PhoneNumber"];
    });
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

GetSpecificReport(reportId) async {
  Report report = Report();
  await FirebaseFirestore.instance
      .collection("Reports")
      .doc(reportId)
      .get()
      .then((value) async {
    await FirebaseFirestore.instance
        .collection("Patients")
        .doc(value.data()!["PatientId"])
        .get()
        .then((value) {
      report.name = value.data()!["FullName"];
      report.age = value.data()!["Age"];
      report.gender = value.data()!["Gender"];
      report.phoneNumber = value.data()!["PhoneNumber"];
    });
    report.reportId = value.id;
    report.image = value.data()!["Image"];
    report.confidence = value.data()!["Confidence"];
    report.firstAid = value.data()!["FirstAid"];
    report.burnDegree = value.data()!["BurnDegree"];
    report.causeOfBurn = value.data()!["CauseOfBurn"];
    report.date = value.data()!["Date"];
    report.diabates = value.data()!["Diabates"];
    report.patientId = value.data()!["PatientId"];
    report.pressure = value.data()!["BloodPressure"];
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
          confidence: report.data()["Confidence"],
          firstAid: report.data()["FirstAid"],
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

DeleteReport(reportId, context) async {
  await FirebaseFirestore.instance
      .collection("Reports")
      .doc(reportId)
      .delete()
      .then((value) => Navigator.pop(context));

  return "deleted";
}
