import 'package:flutter/material.dart';
import '../../Styles/colors.dart';
import '../../Views/home_card_widget.dart';

class DoctorHomeScreen extends StatefulWidget {
  const DoctorHomeScreen({Key? key}) : super(key: key);

  @override
  State<DoctorHomeScreen> createState() => _DoctorHomeScreen();
}

List<String> texts = ["Community", "Appointments", "Schedule", "Articles"];

List<IconData> listIcons = [
  Icons.question_answer_outlined,
  Icons.calendar_month_outlined,
  Icons.edit_calendar_outlined,
  Icons.newspaper_outlined
];

class _DoctorHomeScreen extends State<DoctorHomeScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: back,
        body: Container(
            color: back,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(children: [
                GridView.extent(
                  shrinkWrap: true,
                  primary: false,
                  padding:
                      const EdgeInsets.symmetric(vertical: 150, horizontal: 5),
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  maxCrossAxisExtent: 200.0,
                  children: <Widget>[
                    for (var i = 0; i < 4; i++)
                      HomeCardWidget(
                        text: texts[i],
                        cardIcon: listIcons[i],
                      ),
                  ],
                )
              ]),
            )));
  }
}
