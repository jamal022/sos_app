import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sos_app/Presentation/Widgets/loading_widget.dart';

class Appointment {
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
      {required this.reportId,
      required this.doctorId,
      required this.patientId,
      required this.patientName,
      required this.doctorName,
      required this.status,
      required this.date,
      required this.time,
      required this.price,
      required this.place,
      required this.rate});
}

AddAppointment({required Appointment app, context}) async {
  showLoading(context);
  await FirebaseFirestore.instance.collection("Appointments").add({
    "PatientName": app.patientName,
    "PatientId": app.patientId,
    "DoctorId": app.doctorId,
    "DoctorName": app.doctorName,
    "ReportId": app.reportId,
    "Date": app.date,
    "Status": app.status,
    "Time": app.time,
    "Price": app.price,
    "Place": app.place,
    "Rate": app.rate,
  });
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

DeleteAppointment(Appointment app) async {
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
  });
  return "deleted";
}

UpdateRate(Appointment app, rate) async {
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
  });
  return "changed";
}
