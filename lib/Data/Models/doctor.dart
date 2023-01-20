import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sos_app/Data/Models/patient.dart';

class Doctor extends Patient {
  final field;
  final experience;
  final price;
  final addressLat;
  final addressLong;
  final bio;

  Doctor(
      {required username,
      required email,
      required phoneNumber,
      required password,
      required age,
      required gender,
      required image,
      required this.field,
      required this.experience,
      required this.price,
      required this.addressLat,
      required this.addressLong,
      required this.bio})
      : super(
            username: username,
            email: email,
            phoneNumber: phoneNumber,
            password: password,
            age: age,
            gender: gender,
            image: image) {}
}

getDoctors() async {
  List<Doctor> doctors = [];
  await FirebaseFirestore.instance.collection('Doctors').get().then((value) {
    for (var i = 0; i < value.docs.length; i++) {
      Doctor dr = Doctor(
        username: value.docs[i].data()['FullName'],
        email: value.docs[i].data()['Email'],
        phoneNumber: value.docs[i].data()['PhoneNumber'],
        password: value.docs[i].data()['Password'],
        age: value.docs[i].data()['Age'],
        gender: value.docs[i].data()['Gender'],
        image: value.docs[i].data()['Image'],
        field: value.docs[i].data()['Field'],
        addressLat: value.docs[i].data()['AddressLatitude'],
        addressLong: value.docs[i].data()['AddressLongitude'],
        bio: value.docs[i].data()['Bio'],
        experience: value.docs[i].data()['YearsOfExperience'],
        price: value.docs[i].data()['TicketPrice'],
      );

      doctors.insert(i, dr);
    }
  });
  return doctors;
}
