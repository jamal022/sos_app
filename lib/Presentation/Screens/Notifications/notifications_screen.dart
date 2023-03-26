import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sos_app/Data/Models/NotificationModel.dart';
import '../../Styles/colors.dart';
import '../../Styles/fonts.dart';

class NotificationsScreen extends StatefulWidget {
  NotificationsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationsScreen> createState() => _NotificationsScreen();
}

class _NotificationsScreen extends State<NotificationsScreen> {
  List<NotificationModel> notifications = [];
  var id;

  _getPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    id = prefs.getString("Id");
  }

  _getNotifications() async {
    notifications = await GetNotifications(id);

    // await FirebaseMessaging.onMessage.listen((message) {
    //   notifications.add(NotificationModel(
    //       userId: "151", message: message.notification!.body.toString()));
    // });
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _getPrefs();
    _getNotifications();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: const Color.fromARGB(253, 243, 222, 195),
        body: notifications.length != 0
            ? Center(
                child: ListView(
                  children: [
                    for (var i = 0; i < notifications.length; i++)
                      ListTile(
                        title: Text(
                          notifications[i].message,
                          style: const TextStyle(fontSize: 18),
                        ),
                      )
                  ],
                ),
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const Padding(padding: EdgeInsets.fromLTRB(25, 2, 25, 5)),
                    const Icon(
                      Icons.notifications_none_outlined,
                      size: 120,
                      color: primaryColor,
                    ),
                    SizedBox(
                      height: size.height / 20,
                    ),
                    const Text(
                      'There is no Notification',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: primaryColor),
                    ),
                  ],
                ),
              ));
  }
}
