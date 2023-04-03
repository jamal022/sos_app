import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:sos_app/Presentation/PatientScreens/Home/Hospitals/hospital_page_screen.dart';
import '../../Data/Models/HospitalModel.dart';

class HospitalCard extends StatefulWidget {
  Hospital hospital;
  Placemark placemarks;
  HospitalCard({super.key, required this.hospital, required this.placemarks});

  @override
  State<HospitalCard> createState() => _HospitalCard();
}

class _HospitalCard extends State<HospitalCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListTile(
            leading: Container(
              height: 140,
              width: 80,
              child: Image.network(
                widget.hospital.image,
                fit: BoxFit.fill,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => HospitalPageScreen(
                          hospital: widget.hospital,
                        )),
              );
            },
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(children: [
                Text(
                  widget.hospital.name,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ), //Textstyle
                ), //Text
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "${widget.placemarks.locality}",
                  style: const TextStyle(
                    fontSize: 17,
                    color: Color.fromARGB(255, 90, 84, 84),
                  ),
                ) //Textstyle
              ]),
            ),
          ),
        ));
  }
}
