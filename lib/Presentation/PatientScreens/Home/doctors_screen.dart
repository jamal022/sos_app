import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sos_app/Data/Models/doctor.dart';
import 'package:sos_app/Presentation/Views/doctor_card_widget.dart';
import 'package:sos_app/Presentation/Widgets/textFormField_widget.dart';
import '../../Styles/colors.dart';
import '../../Widgets/search_widget.dart';

class DoctorsScreen extends StatefulWidget {
  DoctorsScreen({Key? key}) : super(key: key);

  @override
  State<DoctorsScreen> createState() => _DoctorsScreen();
}

late List<Doctor> doctorsList;

getdocslist() async {
  doctorsList = await getDoctors();
}

@override
class _DoctorsScreen extends State<DoctorsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdocslist();
  }

  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color.fromARGB(253, 243, 222, 195),
      appBar: AppBar(
        title: const Text(
          "Doctors",
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
      body: doctorsList.isEmpty
          ? const Center(
              child: Text("There is no doctors"),
            )
          : Container(
              child: GridView.extent(
                primary: false,
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
                crossAxisSpacing: 20,
                maxCrossAxisExtent: 250.0,
                children: <Widget>[
                  for (var i = 0; i < doctorsList.length; i++)
                    DoctorCardWidget(
                      field: doctorsList[i].field,
                      image: doctorsList[i].image,
                      name: doctorsList[i].username,
                    ),
                ],
              ),
            ),
    );
  }
}
