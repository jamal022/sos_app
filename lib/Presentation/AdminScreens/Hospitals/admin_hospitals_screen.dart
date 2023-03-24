import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import '../../../Data/Models/HospitalModel.dart';
import '../../Styles/colors.dart';
import 'add_hospital_screen.dart';
import 'admin_hospital_page.dart';

class AdminHospitalsScreen extends StatefulWidget {
  const AdminHospitalsScreen({Key? key}) : super(key: key);

  @override
  State<AdminHospitalsScreen> createState() => _AdminHospitalsScreenState();
}

class _AdminHospitalsScreenState extends State<AdminHospitalsScreen> {
  List<Hospital> hospitalsList = [];
  List<List<Placemark>> placemarks = [];

  _getHospitals() async {
    hospitalsList = await GetHospitals();
    for (var hos in hospitalsList) {
      List<Placemark> pl = await placemarkFromCoordinates(
          double.parse(hos.addressLang.toString()),
          double.parse(hos.addressLong.toString()));

      placemarks.add(pl);
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _getHospitals();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: adminback,
        floatingActionButton: FloatingActionButton(
          backgroundColor: black,
          child: const Icon(Icons.add),
          onPressed: () async {
            var result = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddHospitalScreen()),
            );
            if (result == "refresh") {
              placemarks.clear();
              _getHospitals();
            }
          },
          //Color.fromARGB(249, 220, 212, 200)
        ),
        appBar: AppBar(
          title: const Text(
            "\t\Hospitals",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
          ),
          centerTitle: true,
          toolbarHeight: 60.2,
          elevation: 4,
          backgroundColor: black,
        ),
        body: hospitalsList.length != 0
            ? SingleChildScrollView(
                child: Column(children: [
                  Column(children: <Widget>[
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                              padding: const EdgeInsets.all(15),
                              child: Column(
                                children: [
                                  for (var i = 0; i < hospitalsList.length; i++)
                                    Card(
                                        elevation: 4,
                                        color: const Color.fromARGB(
                                            255, 241, 238, 238),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: ListTile(
                                          leading: Container(
                                            height: 70,
                                            width: 70,
                                            child: Image.network(
                                              hospitalsList[i].image,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                          onTap: () async {
                                            var result = await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      AdminHospitalPageScreen(
                                                        hospital:
                                                            hospitalsList[i],
                                                      )),
                                            );
                                            if (result == "refresh") {
                                              placemarks.clear();
                                              _getHospitals();
                                            }
                                          },
                                          title: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              children: [
                                                Text(
                                                  hospitalsList[i].name,
                                                  style: const TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w500,
                                                  ), //Textstyle
                                                ), //Text
                                                const SizedBox(
                                                  height: 10,
                                                ), //SizedBox
                                                Text(
                                                  "Location:  ${placemarks[i][0].locality}",
                                                  style: const TextStyle(
                                                    fontSize: 17,
                                                    color: Color.fromARGB(
                                                        255, 90, 84, 84),
                                                  ), //Textstyle
                                                ), //Text
                                                const SizedBox(
                                                  height: 5,
                                                ),

                                                Text(
                                                  "Country:  ${placemarks[i][0].country}",
                                                  style: const TextStyle(
                                                    fontSize: 17,
                                                    color: Color.fromARGB(
                                                        255, 90, 84, 84),
                                                  ), //Textstyle
                                                ),
                                              ],
                                            ),
                                          ),
                                        ))
                                ],
                              ))
                        ])
                  ]),
                ]),
              )
            : const Center(
                child: CircularProgressIndicator(),
              ));
  }
}