import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../Styles/colors.dart';

class HospitalPageScreen extends StatefulWidget {
  const HospitalPageScreen({super.key});

  @override
  State<HospitalPageScreen> createState() => _HospitalPageScreenState();
}

class _HospitalPageScreenState extends State<HospitalPageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(253, 243, 222, 195),
        appBar: AppBar(
          title: const Text(
            "\t\tHospital Name",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
          ),
          centerTitle: true,
          toolbarHeight: 60.2,
          elevation: 4,
          backgroundColor: primaryColor,
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    image: const DecorationImage(
                      image: AssetImage("assets/images/R.jpg"),
                      fit: BoxFit.fill,
                    )),
                height: 220,
              ),
            ),
            Container(
                child: Column(children: <Widget>[
              Card(
                elevation: 5,
                margin: EdgeInsets.fromLTRB(15.0, 10, 15, 10),
                color: white,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.phone_android_outlined,
                      size: 45,
                      color: black,
                    ),
                    title: Text(
                      "Give us a Call",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      "  +0222103815\n  +0233109276",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),
              Card(
                elevation: 5,
                margin: EdgeInsets.fromLTRB(15.0, 10, 15, 10),
                color: white,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.phone,
                      size: 45,
                      color: black,
                    ),
                    title: Text(
                      "Give us an Ambulance Call",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      "  16648",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),
              Card(
                elevation: 5,
                margin: EdgeInsets.fromLTRB(15.0, 10, 15, 10),
                color: white,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.mail_outlined,
                      size: 45,
                      color: black,
                    ),
                    title: Text(
                      "Send us a message",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      "  sosApp@gmail.com",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),
              Card(
                elevation: 5,
                margin: EdgeInsets.fromLTRB(15.0, 10, 15, 10),
                color: white,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: Icon(
                      Icons.location_on_outlined,
                      size: 45,
                      color: black,
                    ),
                    title: Text(
                      "Visit our Location",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Image.asset("assets/images/R.jpg"),
                  ),
                ),
              ),
            ])),
          ]),
        ));
  }
}
