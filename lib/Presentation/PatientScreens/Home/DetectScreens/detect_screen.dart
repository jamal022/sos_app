import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sos_app/Presentation/PatientScreens/Home/DetectScreens/report_form_screen.dart';
import 'package:tflite/tflite.dart';
import '../../../Styles/colors.dart';

class DetectScreen extends StatefulWidget {
  const DetectScreen({super.key});

  @override
  State<DetectScreen> createState() => _DetectScreenState();
}

class _DetectScreenState extends State<DetectScreen> {
  bool _loading = true;
  late File _image;
  late List _output;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    loadModel().then((value) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    Tflite.close();
  }

  classifyImage(File image) async {
    var output = await Tflite.runModelOnImage(path: image.path);
    setState(() {
      _output = output!;
      _loading = false;
    });
  }

  loadModel() async {
    await Tflite.loadModel(
        model: "assets/model/MobileNetV2.tflite",
        labels: "assets/model/labels.txt");
  }

  pickImage() async {
    var image = await picker.pickImage(source: ImageSource.camera);
    if (image == null) return null;
    setState(() {
      _image = File(image.path);
    });
    classifyImage(_image);
  }

  pickGalleryImage() async {
    var image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) return null;
    setState(() {
      _image = File(image.path);
    });
    classifyImage(_image);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: back,
      appBar: AppBar(
        title: const Text(
          "Detect Burn",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
        ),
        centerTitle: true,
        toolbarHeight: 60.2,
        elevation: 4,
        backgroundColor: primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          children: [
            Container(
              child: Center(
                  child: _loading == true
                      ? Container(
                          child: Column(children: [
                            GestureDetector(
                              onTap: pickImage,
                              child: Container(
                                width: MediaQuery.of(context).size.width - 200,
                                alignment: Alignment.center,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 24, vertical: 17),
                                decoration: BoxDecoration(
                                    color: primaryColor,
                                    borderRadius: BorderRadius.circular(15)),
                                child: const Text(
                                  'Take a Photo',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            GestureDetector(
                              onTap: pickGalleryImage,
                              child: Container(
                                width: MediaQuery.of(context).size.width - 200,
                                alignment: Alignment.center,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 24, vertical: 17),
                                decoration: BoxDecoration(
                                    color: primaryColor,
                                    borderRadius: BorderRadius.circular(15)),
                                child: const Text(
                                  'Select a Picture',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ),
                            ),
                          ]),
                        )
                      : Container(
                          child: Column(children: [
                            Container(
                              height: MediaQuery.of(context).size.width * 0.8,
                              width: MediaQuery.of(context).size.width * 0.6,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Image.file(
                                  _image,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            _output != null
                                ?
                                // Text(
                                //     'The degree is: ${_output[0]['label']} - ${_output[0]['confidence'] * 100}%',
                                //     style: const TextStyle(
                                //         color: primaryColor,
                                //         fontSize: 18,
                                //         fontWeight: FontWeight.w400),
                                //   )

                                MaterialButton(
                                    color: primaryColor,
                                    elevation: 3.0,
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ReportFormScreen(
                                                    degree: _output[0]['label'],
                                                    confidence: (_output[0]
                                                                ['confidence'] *
                                                            100)
                                                        .toStringAsFixed(2),
                                                    image: _image),
                                          ));
                                    },
                                    child: const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        'Next',
                                        style: TextStyle(
                                            fontSize: 20, color: white),
                                      ),
                                    ),
                                  )
                                : Container(),
                          ]),
                        )),
            ),
          ],
        ),
      ),
    );
  }
}
