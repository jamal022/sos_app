import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sos_app/Data/Models/ReportModel.dart';
import 'package:sos_app/Data/Models/ScheduleModel.dart';
import 'package:sos_app/Data/Models/patient.dart';
import 'package:sos_app/Presentation/PatientScreens/Home/DetectScreens/report_screen.dart';
import 'package:printing/printing.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:sos_app/Presentation/PatientScreens/Home/appointments_screen.dart';
import 'package:sos_app/Presentation/Screens/App_Layout/bottom_nav_bar.dart';
import 'package:sos_app/Presentation/Widgets/loading_widget.dart';

import '../../Presentation/Widgets/printable_report.dart';

class Appointment {
  var ReportId;
  var PatientName;
  var DoctorName;
  var Date;
  var Status;
  var Time;

  Appointment(
      {required this.ReportId,
      required this.PatientName,
      required this.DoctorName,
      required this.Status,
      required this.Date,
      required this.Time});
}

AddAppointment({required Appointment app, context}) async {
  showLoading(context);
  await FirebaseFirestore.instance.collection("Appointments").add({
    "PatientName": app.PatientName,
    "DoctorName": app.DoctorName,
    "ReportId": app.ReportId,
    "Date": app.Date,
    "Status": app.Status,
    "Time": app.Time
  });
}
// GetReports(Patient patient, context) async {
//   List<Report> reports = [];
//   await FirebaseFirestore.instance
//       .collection("Reports")
//       .where("PatientId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
//       .get()
//       .then((value) {
//     for (var report in value.docs) {
//       Report r = Report(
//           image: report.data()["Image"],
//           burnDegree: report.data()["BurnDegree"],
//           name: patient.username,
//           age: patient.age,
//           gender: patient.gender,
//           phoneNumber: patient.phoneNumber,
//           diabates: report.data()["Diabates"],
//           pressure: report.data()["BloodPressure"],
//           causeOfBurn: report.data()["CauseOfBurn"],
//           Date: report.data()["Date"]);
//       reports.add(r);
//     }
//   });
//   return reports;
// }

// Future<void> printReport(Report report) async {
//   var image = await networkImage(
//     report.image,
//   );
//   final doc = pw.Document();
//   doc.addPage(pw.Page(
//       pageFormat: PdfPageFormat.a4,
//       build: (pw.Context context) {
//         return buildPrintableData(report, image);
//       }));
//   await Printing.layoutPdf(
//       onLayout: (PdfPageFormat format) async => doc.save());
// }
