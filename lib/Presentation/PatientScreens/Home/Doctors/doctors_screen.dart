import 'package:flutter/material.dart';
import 'package:sos_app/Data/Models/doctor.dart';
import 'package:sos_app/Presentation/Views/doctor_card_widget.dart';
import '../../../Styles/colors.dart';
import '../../../Widgets/doctor_search_widget.dart';

class DoctorsScreen extends StatefulWidget {
  DoctorsScreen({Key? key}) : super(key: key);

  @override
  State<DoctorsScreen> createState() => _DoctorsScreen();
}

List<Doctor> doctorsList = [];

getdocslist() async {
  doctorsList = await getDoctors();
}

@override
class _DoctorsScreen extends State<DoctorsScreen> {
  @override
  void initState() {
    super.initState();
    () async {
      await getdocslist();
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
                    delegate: DoctorSearchDelegate());
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
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 8.0 / 10.0,
                  crossAxisCount: 2,
                ),
                itemBuilder: (_, index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DoctorCardWidget(
                    doctor: doctorsList[index],
                  ),
                ),
                itemCount: doctorsList.length,
              ),
            ),
    );
  }
}
