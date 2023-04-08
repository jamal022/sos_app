import 'dart:io';
import 'dart:math';
import 'package:path/path.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:sos_app/Presentation/Screens/Login/login_screen.dart';
import 'package:sos_app/Presentation/Styles/colors.dart';
import 'package:sos_app/Presentation/Widgets/loading_widget.dart';
import 'package:sos_app/Presentation/Widgets/textFormField_widget.dart';
import 'package:date_format/date_format.dart';
import '../../../../Data/Models/ReportModel.dart';
import '../../../Styles/fonts.dart';

class ReportFormScreen extends StatefulWidget {
  final degree;
  final confidence;
  final image;
  ReportFormScreen(
      {Key? key,
      required this.degree,
      required this.confidence,
      required this.image})
      : super(key: key);

  @override
  State<ReportFormScreen> createState() => _ReportFormScreenState();
}

class _ReportFormScreenState extends State<ReportFormScreen> {
  List<String> firstAidList = [
    "1-Cool the burn. Immediately immerse the burn in cool tap water or apply cold, wet compresses. Do this for about 10 minutes or until the pain subsides.\n2-Apply petroleum jelly two to three times daily. Do not apply ointments, toothpaste or butter to the burn, as these may cause an infection. Do not apply topical antibiotics.\n3-Cover the burn with a nonstick, sterile bandage. If blisters form, let them heal on their own while keeping the area covered. Do not pop the blisters.\n4-Consider taking over-the-counter pain medication. Acetaminophen or ibuprofen can help relieve the pain and reduce inflammation.\n5-Protect the area from the sun. Once the burn heals, protect the area from the sun by seeking shade, wearing protective clothing or applying a broad-spectrum, water-resistant sunscreen with an SPF of 30 or higher. This will help minimize scarring, as the redness from a burn sometimes persists for weeks, especially in those with darker skin tones.",
    "Try to keep your burn area under water for at least five minutes, up to 30 minutes. Gently pat the burn dry with a clean towel. Cover your burn with a clean bandage or wound dressing like non-stick gauze. Avoid touching your burn or placing clothing on your skin that can cause friction or rub against your wound.",
    "Do not soak the burn with water. Do not apply any ointment, butter, grease, or spray. Do not remove clothing that is stuck to the area. Cover the area with a sterile bandage or a clean loose cloth."
  ];

  _addBurnImage(image) async {
    var file = File(image!.path);
    var rand = Random().nextInt(100000);
    var imagename = "$rand" + basename(image!.path);
    var ref = FirebaseStorage.instance.ref("burnPhotos").child("$imagename");
    await ref.putFile(file);
    var imageurl = await ref.getDownloadURL();
    return imageurl;
  }

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
                      showLoading(context);
                      var firstAid;
                      if (widget.degree == "First Degree") {
                        firstAid = firstAidList[0];
                      } else if (widget.degree == "Second Degree") {
                        firstAid = firstAidList[1];
                      } else if (widget.degree == "Third Degree") {
                        firstAid = firstAidList[2];
                      }
                      String burnImage = await _addBurnImage(widget.image);
                      Report report = Report(
                          patientId: FirebaseAuth.instance.currentUser!.uid,
                          image: burnImage,
                          causeOfBurn: causeController.text,
                          firstAid: firstAid,
                          burnDegree: widget.degree,
                          diabates: isDiabetes == false ? "No" : "Yes",
                          pressure: isPresure == true
                              ? "Hypertension"
                              : (isLowPresure == true ? "Hypotension" : "No"),
                          date: formatDate(
                              DateTime.now(), [dd, '/', mm, '/', yyyy]));

                      await AddReport(report, context);
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
