import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sos_app/Presentation/PatientScreens/Home/DetectScreens/report_screen.dart';
import 'package:sos_app/Presentation/Screens/Login/login_screen.dart';
import 'package:sos_app/Presentation/Styles/colors.dart';
import 'package:sos_app/Presentation/Widgets/textFormField_widget.dart';
import 'package:sos_app/Presentation/Widgets/uploadBurnPhoto_widget.dart';
import 'package:date_format/date_format.dart';
import '../../../../Data/Models/ReportModel.dart';
import '../../../../Data/Models/patient.dart';
import '../../../Styles/fonts.dart';

class ReportFormScreen extends StatefulWidget {
  const ReportFormScreen({Key? key}) : super(key: key);

  @override
  State<ReportFormScreen> createState() => _ReportFormScreenState();
}

class _ReportFormScreenState extends State<ReportFormScreen> {
  //bool isChecked = false;
  bool isDiabetes = false;
  bool isnDiabetes = false;
  TextEditingController causeController = TextEditingController();
  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return lightwhite;
    }
    return primaryColor;
  }

  bool isPresure = false;
  bool isLowPresure = false;
  bool isnPresure = false;
  Color getPresure(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return lightwhite;
    }
    return primaryColor;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: back,
        appBar: AppBar(
          backgroundColor: primaryColor,
          elevation: 0,
          centerTitle: true,
          toolbarHeight: 64.5,
          title: const Text('Report Form',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
            child: Column(children: <Widget>[
          const SizedBox(height: 50),
          textFieldTitle('The Cause Of Burn'),
          TextFormFieldWidget(
              type: TextInputType.name, textController: causeController),
          const SizedBox(height: 20),
          textFieldTitle('Diabetes'),
          const SizedBox(height: 10),
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.fromLTRB(35.0, 0.0, 0.0, 10.0),
            child: Row(
              children: [
                Theme(
                  data: ThemeData(unselectedWidgetColor: Colors.white),
                  child: Checkbox(
                    value: isDiabetes,
                    checkColor: Colors.white,
                    activeColor: primaryColor,
                    onChanged: (value) {
                      setState(
                        () {
                          isDiabetes = value!;
                          isnDiabetes = false;
                        },
                      );
                    },
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(right: formSubtitleFont),
                  child: Text(
                    "Yes",
                    style: TextStyle(
                        color: Colors.black, fontSize: formSubtitleFont),
                  ),
                ),
                Theme(
                  data: ThemeData(unselectedWidgetColor: Colors.white),
                  child: Checkbox(
                    value: isnDiabetes,
                    checkColor: Colors.white,
                    activeColor: primaryColor,
                    onChanged: (value) {
                      setState(
                        () {
                          isnDiabetes = value!;
                          isDiabetes = false;
                        },
                      );
                    },
                  ),
                ),
                const Text(
                  "No",
                  style: TextStyle(
                      color: Colors.black, fontSize: formSubtitleFont),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          textFieldTitle('Blood Presure'),
          const SizedBox(height: 10),
          Container(
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.fromLTRB(35.0, 0.0, 0.0, 10.0),
            child: Column(
              children: [
                Row(children: [
                  Theme(
                    data: ThemeData(unselectedWidgetColor: Colors.white),
                    child: Checkbox(
                      value: isPresure,
                      checkColor: Colors.white,
                      activeColor: primaryColor,
                      onChanged: (value) {
                        setState(
                          () {
                            isPresure = value!;
                            isnPresure = false;
                            isLowPresure = false;
                          },
                        );
                      },
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: formSubtitleFont),
                    child: Text(
                      "Hypertension",
                      style: TextStyle(
                          color: Colors.black, fontSize: formSubtitleFont),
                    ),
                  )
                ]),
                Row(children: [
                  Theme(
                    data: ThemeData(unselectedWidgetColor: Colors.white),
                    child: Checkbox(
                      value: isLowPresure,
                      checkColor: Colors.white,
                      activeColor: primaryColor,
                      onChanged: (value) {
                        setState(
                          () {
                            isLowPresure = value!;
                            isPresure = false;

                            isnPresure = false;
                          },
                        );
                      },
                    ),
                  ),
                  const Text(
                    "Hypotension",
                    style: TextStyle(
                        color: Colors.black, fontSize: formSubtitleFont),
                  ),
                ]),
                Row(
                  children: [
                    Theme(
                      data: ThemeData(unselectedWidgetColor: Colors.white),
                      child: Checkbox(
                        value: isnPresure,
                        checkColor: Colors.white,
                        activeColor: primaryColor,
                        onChanged: (value) {
                          setState(
                            () {
                              isnPresure = value!;
                              isPresure = false;
                              isLowPresure = false;
                            },
                          );
                        },
                      ),
                    ),
                    const Text(
                      "No",
                      style: TextStyle(
                          color: Colors.black, fontSize: formSubtitleFont),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                MaterialButton(
                    elevation: 5.0,
                    color: const Color.fromARGB(238, 237, 96, 35),
                    padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                    shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide.none,
                    ),
                    onPressed: () async {
                      final f = new DateFormat('yyyy-MM-dd hh:mm');
                      Patient patient = Patient();
                      String burnImage = await addBurnImage();
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      patient.username = prefs.getString("FullName");
                      patient.email = prefs.getString("Email");
                      patient.phoneNumber = prefs.getString("PhoneNumber");
                      patient.password = prefs.getString("Password");
                      patient.age = prefs.getString("Age");
                      patient.gender = prefs.getString("Gender");
                      patient.image = prefs.getString("Image");

                      Report report = Report(
                          patientId: FirebaseAuth.instance.currentUser!.uid,
                          image: burnImage,
                          age: patient.age,
                          causeOfBurn: causeController.text,
                          burnDegree: "2nd degree",
                          diabates: isDiabetes == false ? "No" : "Yes",
                          pressure: isPresure == true
                              ? "Hypertension"
                              : (isLowPresure == true ? "Hypotension" : "No"),
                          gender: patient.gender,
                          name: patient.username,
                          phoneNumber: patient.phoneNumber,
                          date: formatDate(
                              DateTime.now(), [dd, '/', mm, '/', yyyy]));
                      await report.AddReport(report, context);
                    },
                    child: const Text(
                      'Go To Report',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ])));
  }
}
