import 'package:flutter/material.dart';
import 'package:sos_app/Presentation/PatientScreens/Home/Hospitals/hospital_page_screen.dart';

class HospitalCard extends StatefulWidget {
  HospitalCard({super.key});

  @override
  State<HospitalCard> createState() => _HospitalCard();
}

class _HospitalCard extends State<HospitalCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          leading: Container(
            height: 70,
            width: 70,
            child: Image.asset(
              "assets/images/R.jpg",
              fit: BoxFit.fill,
            ),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HospitalPageScreen()),
            );
          },
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  "Hospital Name",
                  style: const TextStyle(
                    fontSize: 22,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ), //Textstyle
                ), //Text
                const SizedBox(
                  height: 10,
                ), //SizedBox
                Text(
                  "Location : Giza",
                  style: const TextStyle(
                    fontSize: 17,
                    color: Color.fromARGB(255, 90, 84, 84),
                  ), //Textstyle
                ), //Text
                const SizedBox(
                  height: 5,
                ),

                Text(
                  "City : Giza",
                  style: const TextStyle(
                    fontSize: 17,
                    color: Color.fromARGB(255, 90, 84, 84),
                  ), //Textstyle
                ),
              ],
            ),
          ),
        ));
  }
}
