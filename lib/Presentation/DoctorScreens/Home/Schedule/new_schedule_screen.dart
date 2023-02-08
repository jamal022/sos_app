import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sos_app/Data/Models/ScheduleModel.dart';
import 'package:sos_app/Presentation/Screens/Login/login_screen.dart';
import 'package:sos_app/Presentation/Styles/colors.dart';
import 'package:sos_app/Presentation/Widgets/textFormField_widget.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:numberpicker/numberpicker.dart';
import '../../../Styles/fonts.dart';

class NewScheduleScreen extends StatefulWidget {
  const NewScheduleScreen({Key? key}) : super(key: key);

  @override
  State<NewScheduleScreen> createState() => _NewScheduleScreenState();
}

class _NewScheduleScreenState extends State<NewScheduleScreen> {
  DateTime today = DateTime.now();

  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
  }

  int _currentValue = 00;
  int _selectedValue = 00;

  bool isfromAm = false;
  bool isfromPm = false;

  var maxNbController = TextEditingController();

  Color getFromTime(Set<MaterialState> states) {
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

  bool isToAm = false;
  bool isToPm = false;

  Color getToTime(Set<MaterialState> states) {
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
        title: const Text('New Schedule',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        //To stop scrolling
        child: Column(children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                color: white,
              ),
              alignment: Alignment.topCenter,
              //Calender Table
              child: TableCalendar(
                locale: "en_US",
                rowHeight: 43,
                headerStyle: const HeaderStyle(
                    formatButtonVisible: false, titleCentered: true),
                availableGestures: AvailableGestures.all,
                selectedDayPredicate: (day) => isSameDay(day, today),
                focusedDay: today,
                firstDay: DateTime.utc(DateTime.now().year, 1, 1),
                lastDay: DateTime.utc(DateTime.now().year, 12, 31),
                onDaySelected: _onDaySelected,
                //To style the calender
                calendarStyle: const CalendarStyle(
                    isTodayHighlighted: true,
                    selectedDecoration: BoxDecoration(
                      color: primaryColor,
                      shape: BoxShape.circle,
                    ),
                    todayDecoration: BoxDecoration(
                      color: back,
                      shape: BoxShape.circle,
                    ),
                    selectedTextStyle: TextStyle(color: Colors.white)),
              ),
            ),
          ),
          const SizedBox(height: 10),
          textFieldTitle('From:'),
          const SizedBox(height: 10),
          Container(
            alignment: Alignment.topRight,
            padding: const EdgeInsets.fromLTRB(35.0, 0.0, 0.0, 10.0),
            child: Row(
              children: [
                //To pick a date
                NumberPicker(
                  value: _currentValue,
                  minValue: 00,
                  maxValue: 11,
                  itemHeight: 25,
                  onChanged: (value) => setState(() => _currentValue = value),
                  selectedTextStyle: const TextStyle(
                    fontSize: formSubtitleFont,
                    color: primaryColor,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white60,
                    backgroundBlendMode: BlendMode.color,
                    borderRadius: BorderRadius.circular(60),
                    border: Border.all(color: Colors.white60),
                  ),
                ),
                //Time CheckBox
                Theme(
                  data: ThemeData(unselectedWidgetColor: Colors.white),
                  child: Checkbox(
                    value: isfromPm,
                    checkColor: Colors.white,
                    activeColor: primaryColor,
                    onChanged: (value) {
                      setState(
                        () {
                          isfromPm = value!;
                          isfromAm = false;
                        },
                      );
                    },
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(right: formSubtitleFont),
                  child: Text(
                    "Pm",
                    style: TextStyle(
                        color: Colors.black, fontSize: formSubtitleFont),
                  ),
                ),
                Theme(
                  data: ThemeData(unselectedWidgetColor: Colors.white),
                  child: Checkbox(
                    value: isfromAm,
                    checkColor: Colors.white,
                    activeColor: primaryColor,
                    onChanged: (value) {
                      setState(
                        () {
                          isfromAm = value!;
                          isfromPm = false;
                        },
                      );
                    },
                  ),
                ),
                const Text(
                  "Am",
                  style: TextStyle(
                      color: Colors.black, fontSize: formSubtitleFont),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          textFieldTitle('To:'),
          const SizedBox(height: 10),
          Container(
            alignment: Alignment.topRight,
            padding: const EdgeInsets.fromLTRB(35.0, 0.0, 0.0, 10.0),
            child: Row(
              children: [
                NumberPicker(
                  value: _selectedValue,
                  minValue: 00,
                  maxValue: 11,
                  itemHeight: 25,
                  onChanged: (value) => setState(() => _selectedValue = value),
                  selectedTextStyle: const TextStyle(
                      fontSize: formSubtitleFont, color: primaryColor),
                  decoration: BoxDecoration(
                    color: Colors.white60,
                    backgroundBlendMode: BlendMode.color,
                    borderRadius: BorderRadius.circular(60),
                    border: Border.all(color: Colors.white60),
                  ),
                ),
                Theme(
                  data: ThemeData(unselectedWidgetColor: Colors.white),
                  child: Checkbox(
                    value: isToPm,
                    checkColor: Colors.white,
                    activeColor: primaryColor,
                    onChanged: (value) {
                      setState(
                        () {
                          isToPm = value!;
                          isToAm = false;
                        },
                      );
                    },
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(right: formSubtitleFont),
                  child: Text(
                    "Pm",
                    style: TextStyle(
                        color: Colors.black, fontSize: formSubtitleFont),
                  ),
                ),
                Theme(
                  data: ThemeData(unselectedWidgetColor: Colors.white),
                  child: Checkbox(
                    value: isToAm,
                    checkColor: Colors.white,
                    activeColor: primaryColor,
                    onChanged: (value) {
                      setState(
                        () {
                          isToAm = value!;
                          isToPm = false;
                        },
                      );
                    },
                  ),
                ),
                const Text(
                  "Am",
                  style: TextStyle(
                      color: Colors.black, fontSize: formSubtitleFont),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          textFieldTitle('Max number of appointments:'),
          const SizedBox(height: 10),
          TextFormFieldWidget(
            icon: Icons.numbers,
            type: TextInputType.number,
            textController: maxNbController,
          ),
          const SizedBox(
            height: 20,
          ),
          MaterialButton(
              elevation: 5.0,
              color: primaryColor,
              padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
              shape: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
                borderSide: BorderSide.none,
              ),
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                var name = prefs.getString("FullName");
                Schedule sch = Schedule(
                    doctorId: FirebaseAuth.instance.currentUser!.uid,
                    doctorName: name,
                    day: today.day,
                    month: today.month,
                    year: today.year,
                    fromTime: _currentValue,
                    fromPeriod: isfromPm == true ? "PM" : "AM",
                    toPeriod: isToPm == true ? "PM" : "AM",
                    toTime: _selectedValue,
                    maxNbAppointments: maxNbController.text,
                    nbAppointments: 0);

                await AddSchedule(sch, context);
              },
              child: const Text(
                'Add',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              )),
          const SizedBox(
            height: 20,
          ),
        ]),
      ),
    );
  }
}
