import 'package:flutter/material.dart';
import 'package:sos_app/Presentation/Styles/colors.dart';
import 'package:sos_app/Presentation/Styles/fonts.dart';

import '../../Constants/app_assets.dart';

class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        centerTitle: true,
        toolbarHeight: 64.5,
        title: const Text(
          "Privacy and Policies",
          style: (TextStyle(
            fontSize: titleInfoFont,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          )),
        ),
        leading: IconButton(
          onPressed: () {
            return Navigator.pop(context);
          },
          icon:
              const Icon(Icons.arrow_back_ios_rounded, color: white, size: 30),
        ),
      ),
      body: Container(
        color: back,
        child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              color: white,
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: PrivacyAndPoliciesList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "${PrivacyAndPoliciesList[index]} ",
                            style: const TextStyle(fontSize: 20),
                          ),
                        );
                      })),
            )),
      ),
    );
  }
}
