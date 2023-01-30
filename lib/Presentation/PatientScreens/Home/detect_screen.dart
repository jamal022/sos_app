import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sos_app/Presentation/Widgets/uploadBurnPhoto_widget.dart';
import 'package:sos_app/Presentation/Widgets/upoladPhoto_widget.dart';

import '../../Styles/colors.dart';

class DetectScreen extends StatefulWidget {
  const DetectScreen({super.key});

  @override
  State<DetectScreen> createState() => _DetectScreenState();
}

class _DetectScreenState extends State<DetectScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            const UploadBurnPhotoWidget(text: "Upload Photo"),
          ],
        ),
      ),
    );
  }
}
