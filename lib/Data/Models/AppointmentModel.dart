import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:sos_app/Data/Models/ScheduleModel.dart';
import 'package:sos_app/Presentation/Widgets/loading_widget.dart';

class Appointment {
  var appointmentId;
  var reportId;
  var patientName;
  var doctorId;
  var patientId;
  var doctorName;
  var date;
  var status;
  var time;
  var price;
  var place;
  var rate;
  Appointment(
      {this.appointmentId,
      required this.reportId,
      required this.doctorId,
      required this.patientId,
      this.patientName,
      this.doctorName,
      required this.status,
      required this.date,
      required this.time,
      this.price,
      this.place,
      required this.rate});
}

AddAppointment({required Appointment app, scheduleId, timeId, context}) async {
  showLoading(context);
  await FirebaseFirestore.instance.collection("Appointments").add({
    "PatientId": app.patientId,
    "DoctorId": app.doctorId,
    "ReportId": app.reportId,
    "Date": app.date,
    "Status": app.status,
    "Time": app.time,
    "Rate": app.rate,
  }).then((value) async {
    await UpdateTimeStatus(scheduleId, timeId);
    Navigator.pop(context);
  });
  return "Added";
}

GetDoctorAppointments(doctorId) async {
  List<Appointment> appointments = [];
  await FirebaseFirestore.instance
      .collection("Appointments")
      .where("DoctorId", isEqualTo: doctorId)
      .where("Status", isEqualTo: "In Progress")
      .get()
      .then((value) {
    print("==============${value.docs.length}============");
    for (var app in value.docs) {
      Appointment s = Appointment(
          doctorId: app.data()["DoctorId"],
          patientId: app.data()["PatientId"],
          doctorName: app.data()["DoctorName"],
          patientName: app.data()["PatientName"],
          reportId: app.data()["ReportId"],
          date: app.data()["Date"],
          status: app.data()["Status"],
          time: app.data()["Time"],
          price: app.data()["Price"],
          place: app.data()["Place"],
          rate: app.data()["Rate"]);
      appointments.add(s);
    }
  });
  return appointments;
}

GetEndedAppointments(patientId) async {
  List<Appointment> appointments = [];
  await FirebaseFirestore.instance
      .collection("Appointments")
      .where("PatientId", isEqualTo: patientId)
      .where("Status", isEqualTo: "Ended")
      .get()
      .then((value) {
    for (var app in value.docs) {
      Appointment s = Appointment(
          doctorId: app.data()["DoctorId"],
          patientId: app.data()["PatientId"],
          doctorName: app.data()["DoctorName"],
          patientName: app.data()["PatientName"],
          reportId: app.data()["ReportId"],
          date: app.data()["Date"],
          status: app.data()["Status"],
          time: app.data()["Time"],
          place: app.data()["Place"],
          price: app.data()["Price"],
          rate: app.data()["Rate"]);
      appointments.add(s);
    }
  });
  return appointments;
}

GetInProgressAppointments(patientId) async {
  List<Appointment> appointments = [];
  await FirebaseFirestore.instance
      .collection("Appointments")
      .where("PatientId", isEqualTo: patientId)
      .where("Status", isEqualTo: "In Progress")
      .get()
      .then((value) {
    for (var app in value.docs) {
      Appointment s = Appointment(
          doctorId: app.data()["DoctorId"],
          patientId: app.data()["PatientId"],
          doctorName: app.data()["DoctorName"],
          patientName: app.data()["PatientName"],
          reportId: app.data()["ReportId"],
          date: app.data()["Date"],
          status: app.data()["Status"],
          time: app.data()["Time"],
          place: app.data()["Place"],
          price: app.data()["Price"],
          rate: app.data()["Rate"]);
      appointments.add(s);
    }
  });
  return appointments;
}

ChangeAppointmentToEnded(Appointment app) async {
  await FirebaseFirestore.instance
      .collection("Appointments")
      .where("DoctorId", isEqualTo: app.doctorId)
      .where("PatientId", isEqualTo: app.patientId)
      .where("Date", isEqualTo: app.date)
      .where("Time", isEqualTo: app.time)
      .get()
      .then((value) async {
    await FirebaseFirestore.instance
        .collection("Appointments")
        .doc(value.docs.first.id)
        .update({"Status": "Ended"});
  });
  return "changed";
}

DeleteAppointment(Appointment app, context) async {
  await FirebaseFirestore.instance
      .collection("Appointments")
      .where("DoctorId", isEqualTo: app.doctorId)
      .where("PatientId", isEqualTo: app.patientId)
      .where("Date", isEqualTo: app.date)
      .where("Time", isEqualTo: app.time)
      .get()
      .then((value) async {
    await FirebaseFirestore.instance
        .collection("Appointments")
        .doc(value.docs.first.id)
        .delete();
  }).then((value) => Navigator.pop(context));
  return "deleted";
}

UpdateRate(Appointment app, rate, context) async {
  await FirebaseFirestore.instance
      .collection("Appointments")
      .where("DoctorId", isEqualTo: app.doctorId)
      .where("PatientId", isEqualTo: app.patientId)
      .where("Date", isEqualTo: app.date)
      .where("Time", isEqualTo: app.time)
      .get()
      .then((value) async {
    await FirebaseFirestore.instance
        .collection("Appointments")
        .doc(value.docs.first.id)
        .update({"Rate": rate});
  }).then((value) => Navigator.pop(context));
  return "changed";
}
