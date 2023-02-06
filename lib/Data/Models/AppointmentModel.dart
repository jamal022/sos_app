import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sos_app/Presentation/Widgets/loading_widget.dart';

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

GetDoctorAppointments(doctorName) async {
  List<Appointment> appointments = [];
  await FirebaseFirestore.instance
      .collection("Appointments")
      .where("DoctorName", isEqualTo: doctorName)
      .where("Status", isEqualTo: "In Progress")
      .get()
      .then((value) {
    for (var app in value.docs) {
      Appointment s = Appointment(
        DoctorName: app.data()["DoctorName"],
        PatientName: app.data()["PatientName"],
        ReportId: app.data()["ReportId"],
        Date: app.data()["Date"],
        Status: app.data()["Status"],
        Time: app.data()["Time"],
      );
      appointments.add(s);
    }
  });
  return appointments;
}

GetEndedAppointments(doctorName) async {
  List<Appointment> appointments = [];
  await FirebaseFirestore.instance
      .collection("Appointments")
      .where("PatientName", isEqualTo: doctorName)
      .where("Status", isEqualTo: "Ended")
      .get()
      .then((value) {
    for (var app in value.docs) {
      Appointment s = Appointment(
        DoctorName: app.data()["DoctorName"],
        PatientName: app.data()["PatientName"],
        ReportId: app.data()["ReportId"],
        Date: app.data()["Date"],
        Status: app.data()["Status"],
        Time: app.data()["Time"],
      );
      appointments.add(s);
    }
  });
  return appointments;
}

GetInProgressAppointments(doctorName) async {
  List<Appointment> appointments = [];
  await FirebaseFirestore.instance
      .collection("Appointments")
      .where("PatientName", isEqualTo: doctorName)
      .where("Status", isEqualTo: "In Progress")
      .get()
      .then((value) {
    for (var app in value.docs) {
      Appointment s = Appointment(
        DoctorName: app.data()["DoctorName"],
        PatientName: app.data()["PatientName"],
        ReportId: app.data()["ReportId"],
        Date: app.data()["Date"],
        Status: app.data()["Status"],
        Time: app.data()["Time"],
      );
      appointments.add(s);
    }
  });
  return appointments;
}

ChangeAppointmentToEnded(Appointment app) async {
  await FirebaseFirestore.instance
      .collection("Appointments")
      .where("DoctorName", isEqualTo: app.DoctorName)
      .where("PatientName", isEqualTo: app.PatientName)
      .where("Date", isEqualTo: app.Date)
      .where("Time", isEqualTo: app.Time)
      .get()
      .then((value) async {
    await FirebaseFirestore.instance
        .collection("Appointments")
        .doc(value.docs.first.id)
        .update({"Status": "Ended"});
  });
  return "changed";
}

DeleteAppointment(Appointment app) async {
  await FirebaseFirestore.instance
      .collection("Appointments")
      .where("DoctorName", isEqualTo: app.DoctorName)
      .where("PatientName", isEqualTo: app.PatientName)
      .where("Date", isEqualTo: app.Date)
      .where("Time", isEqualTo: app.Time)
      .get()
      .then((value) async {
    await FirebaseFirestore.instance
        .collection("Appointments")
        .doc(value.docs.first.id)
        .delete();
  });
  return "deleted";
}
