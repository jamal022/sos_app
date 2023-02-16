import 'package:flutter/material.dart';
import 'package:sos_app/Presentation/Views/hospital_card_widget.dart';
import '../../../../Data/Models/HospitalModel.dart';
import '../../../Styles/colors.dart';
import '../../../Widgets/search_widget.dart';

class HospitalsScreen extends StatefulWidget {
  HospitalsScreen({Key? key}) : super(key: key);

  @override
  State<HospitalsScreen> createState() => _HospitalsScreenState();
}

List<Hospital> hospitalsList = [];

getHospitals() async {
  hospitalsList = await getHospitals();
}

class _HospitalsScreenState extends State<HospitalsScreen> {
  @override
  void initState() {
    super.initState();
    () async {
      await getHospitals();
      setState(() {});
    }();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: const Color.fromARGB(253, 243, 222, 195),
        appBar: AppBar(
          title: const Text(
            "\t\Hospitals",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
          ),
          centerTitle: true,
          toolbarHeight: 60.2,
          elevation: 4,
          backgroundColor: primaryColor,
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: IconButton(
                onPressed: () {
                  // method to show the search bar
                  showSearch(
                      context: context,
                      // delegate to customize the search bar
                      delegate: CustomSearchDelegate());
                },
                icon: const Icon(Icons.search),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            Container(
              color: const Color.fromARGB(253, 243, 222, 195),
              //width: MediaQuery.of(context).size.width * 0.65,

              child: Column(children: <Widget>[
                Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            children: [
                              for (var hos in hospitalsList)
                                HospitalCard(hospital: hos)
                            ],
                          ))
                    ])
              ]),
            )
          ]),
        ));
  }
}
