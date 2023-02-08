import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import '../../../../Data/Models/ScheduleModel.dart';
import '../../../Styles/colors.dart';
import '../../../Styles/fonts.dart';
import 'new_schedule_screen.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

List<Schedule> schedules = [];
var _fromTime, _fromPeriod, _toTime, _toPeriod, _date;
late Schedule schedule;

class _ScheduleScreenState extends State<ScheduleScreen> {
  DateTime today = DateTime.now();
  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
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
          title: const Text('Schedule',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(10.0),
          child: Column(children: <Widget>[
            Container(
                alignment: Alignment.bottomRight,
                child: MaterialButton(
                  elevation: 5.0,
                  color: Colors.red,
                  padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                  shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide.none,
                  ),
                  child: const Text(
                    "Delete",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: contentFont,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    showDialog(
                      useSafeArea: false,
                      context: context,
                      barrierColor: splashBack,
                      builder: (ctx) => AlertDialog(
                        content: Text(
                            "Are you sure,you want to delete this date ${schedule.day}/${schedule.month}/${schedule.year}?",
                            style: const TextStyle(
                              fontSize: contentFont,
                            )),
                        actions: [
                          Row(
                            children: [
                              //btn cancel
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: OutlinedButton(
                                    onPressed: () {
                                      Navigator.pop(ctx);
                                    },
                                    child: const Text(
                                      "Cancel",
                                      style: TextStyle(
                                        color: primaryColor,
                                        fontSize: contentFont,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              //btn sure
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: MaterialButton(
                                    elevation: 6.0,
                                    color: Colors.redAccent,
                                    onPressed: () async {
                                      var result =
                                          await DeleteSchedule(schedule);
                                      if (result == "deleted") {
                                        Navigator.pop(ctx);
                                      }
                                    },
                                    child: const Text(
                                      'Delete',
                                      style: TextStyle(
                                        color: white,
                                        fontSize: contentFont,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                )),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    color: Color.fromARGB(128, 226, 162, 130),
                  ),
                  alignment: Alignment.topCenter,
                  //Calender Table
                  child: HeatMap(
                      //The selected dates on calender
                      datasets: {
                        for (var item in schedules)
                          DateTime(item.year, item.month, item.day): 5,
                      },
                      startDate: DateTime.utc(DateTime.now().year, 1, 1),
                      endDate: DateTime.utc(DateTime.now().year, 12, 31),
                      size: 40,
                      textColor: const Color.fromARGB(235, 141, 61, 21),
                      defaultColor: Colors.white,
                      colorMode: ColorMode.opacity,
                      showText: true,
                      scrollable: true,
                      showColorTip: false,
                      colorsets: const {
                        1: Color.fromRGBO(237, 96, 35, 0.922),
                        2: Color.fromRGBO(237, 96, 40, 0.922),
                        3: Color.fromRGBO(237, 96, 45, 0.922),
                        4: Color.fromRGBO(237, 96, 50, 0.922),
                        5: Color.fromRGBO(237, 96, 55, 0.922),
                      },
                      //Navigate the date you choose
                      onClick: (value) async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        var id = prefs.getString("Id");
                        schedules = await GetSchedulesForDoctor(id);

                        for (var i = 0; i < schedules.length; i++) {
                          if (schedules[i].day == value.day &&
                              schedules[i].month == value.month &&
                              schedules[i].year == value.year) {
                            setState(() {
                              schedule = schedules[i];
                              _fromTime = schedules[i].fromTime;
                              _fromPeriod = schedules[i].fromPeriod;
                              _toTime = schedules[i].toTime;
                              _toPeriod = schedules[i].toPeriod;
                              _date =
                                  "${schedules[i].day} / ${schedules[i].month} / ${schedules[i].year}";
                            });
                          }
                        }
                      })),
            ),
            const SizedBox(height: 50),
            Container(
                alignment: Alignment.topRight,
                padding: const EdgeInsets.fromLTRB(35.0, 0.0, 0.0, 10.0),
                child: Row(children: <Widget>[
                  const Text(
                    "Date:",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: formSubtitleFont,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    _date != null ? "           ${_date}" : " ",
                    style: const TextStyle(
                        color: Colors.black, fontSize: formSubtitleFont),
                  ),
                ])),
            const SizedBox(
              height: 20,
            ),
            Container(
                alignment: Alignment.topRight,
                padding: const EdgeInsets.fromLTRB(35.0, 0.0, 0.0, 10.0),
                child: Row(children: <Widget>[
                  const Text(
                    "From:",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: formSubtitleFont,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    _fromTime != null
                        ? "      ${_fromTime}:00 ${_fromPeriod}"
                        : " ",
                    style: const TextStyle(
                        color: Colors.black, fontSize: formSubtitleFont),
                  ),
                ])),
            const SizedBox(height: 20),
            Container(
                alignment: Alignment.topRight,
                padding: const EdgeInsets.fromLTRB(35.0, 0.0, 0.0, 10.0),
                child: Row(children: <Widget>[
                  const Text(
                    "To:",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: formSubtitleFont,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    _toTime != null
                        ? "           ${_toTime}:00 ${_toPeriod}"
                        : " ",
                    style: const TextStyle(
                        color: Colors.black, fontSize: formSubtitleFont),
                  ),
                ])),
            const SizedBox(
              height: 20,
            ),
          ]),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NewScheduleScreen()),
            );
          },
          backgroundColor: primaryColor,
          child: const Icon(Icons.add),
        ));
  }
}
