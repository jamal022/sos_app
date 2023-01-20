import 'package:flutter/material.dart';
import 'package:sos_app/Presentation/Styles/colors.dart';
import 'package:sos_app/Presentation/Styles/fonts.dart';
import 'package:toggle_list/toggle_list.dart';

import '../../Constants/app_assets.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          elevation: 0,
          centerTitle: true,
          toolbarHeight: 64.5,
          title: const Text(
            "About Us",
            style: (TextStyle(
              fontSize: titleInfoFont,
              fontWeight: FontWeight.bold,
              color: white,
            )),
          ),
          leading: IconButton(
            onPressed: () {
              return Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_rounded,
                color: white, size: 30),
          ),
        ),
        body: Container(
          margin: const EdgeInsets.only(top: 40),
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: AboutUSList.length,
            itemBuilder: (BuildContext context, int index) {
              //card of question & answer
              return Card(
                margin: const EdgeInsets.all(20),
                elevation: 7,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                color: primaryColor,
                child: ToggleList(
                  shrinkWrap: true,
                  toggleAnimationDuration: const Duration(milliseconds: 400),
                  scrollPosition: AutoScrollPosition.begin,
                  children: [
                    //toggle question
                    ToggleListItem(
                        itemDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        headerDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        title: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              "${AboutUSList[index].id} : ${AboutUSList[index].question}",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: white,
                                decoration: TextDecoration.none,
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                        ),

                        //toggle answer
                        content: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Text(
                              "${AboutUSList[index].answer} ",
                              style: const TextStyle(
                                color: white,
                                decoration: TextDecoration.none,
                                fontSize: contentFont,
                              ),
                            ))),
                  ],
                ),
              );
            },
          ),
        ));
  }
}
