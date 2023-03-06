import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
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
      .then((value) async {
    for (var app in value.docs) {
      var patientName;
      await FirebaseFirestore.instance
          .collection("Patients")
          .doc(app.data()["PatientId"])
          .get()
          .then((value) => patientName = value.data()!["FullName"]);
      Appointment s = Appointment(
          appointmentId: app.id,
          doctorId: app.data()["DoctorId"],
          patientId: app.data()["PatientId"],
          patientName: patientName,
          reportId: app.data()["ReportId"],
          date: app.data()["Date"],
          status: app.data()["Status"],
          time: app.data()["Time"],
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
      .then((value) async {
    for (var app in value.docs) {
      var doctorName, price, lat, long;
      await FirebaseFirestore.instance
          .collection("Doctors")
          .doc(app.data()["DoctorId"])
          .get()
          .then((value) {
        doctorName = value.data()!["FullName"];
        price = value.data()!["TicketPrice"];
        lat = value.data()!["AddressLatitude"];
        long = value.data()!["AddressLongitude"];
      });
      List<Placemark> placemarks = [];
      placemarks = await placemarkFromCoordinates(
          double.parse(lat.toString()), double.parse(long.toString()));
      var place = placemarks[0].locality;
      Appointment s = Appointment(
          appointmentId: app.id,
          doctorId: app.data()["DoctorId"],
          patientId: app.data()["PatientId"],
          doctorName: doctorName,
          reportId: app.data()["ReportId"],
          date: app.data()["Date"],
          status: app.data()["Status"],
          time: app.data()["Time"],
          place: place,
          price: price,
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
      .then((value) async {
    for (var app in value.docs) {
      var doctorName, price, lat, long;
      await FirebaseFirestore.instance
          .collection("Doctors")
          .doc(app.data()["DoctorId"])
          .get()
          .then((value) {
        doctorName = value.data()!["FullName"];
        price = value.data()!["TicketPrice"];
        lat = value.data()!["AddressLatitude"];
        long = value.data()!["AddressLongitude"];
      });
      List<Placemark> placemarks = [];
      placemarks = await placemarkFromCoordinates(
          double.parse(lat.toString()), double.parse(long.toString()));
      var place = placemarks[0].locality;
      Appointment s = Appointment(
          appointmentId: app.id,
          doctorId: app.data()["DoctorId"],
          patientId: app.data()["PatientId"],
          doctorName: doctorName,
          reportId: app.data()["ReportId"],
          date: app.data()["Date"],
          status: app.data()["Status"],
          time: app.data()["Time"],
          place: place,
          price: price,
          rate: app.data()["Rate"]);
      appointments.add(s);
    }
  });
  return appointments;
}

ChangeAppointmentToEnded(appId) async {
  await FirebaseFirestore.instance
      .collection("Appointments")
      .doc(appId)
      .get()
      .then((value) async {
    await FirebaseFirestore.instance
        .collection("Appointments")
        .doc(value.id)
        .update({"Status": "Ended"});
  });
  return "changed";
}

DeleteAppointment(appId) async {
  await FirebaseFirestore.instance
      .collection("Appointments")
      .doc(appId)
      .delete();
  return "deleted";
}

UpdateRate(appId, rate, context) async {
  await FirebaseFirestore.instance
      .collection("Appointments")
      .doc(appId)
      .get()
      .then((value) async {
    await FirebaseFirestore.instance
        .collection("Appointments")
        .doc(value.id)
        .update({"Rate": rate});
  }).then((value) => Navigator.pop(context));
  return "changed";
}
