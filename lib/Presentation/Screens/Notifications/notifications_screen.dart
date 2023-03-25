import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:sos_app/Data/Models/NotificationModel.dart';
import '../../Styles/colors.dart';

class NotificationsScreen extends StatefulWidget {
  NotificationsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationsScreen> createState() => _NotificationsScreen();
}

class _NotificationsScreen extends State<NotificationsScreen> {
  List<NotificationModel> notifications = [];

  getNotifications() async {
    notifications = await GetNotifications();
    var userToken = await FirebaseMessaging.instance.getToken();
    print("token========= ${userToken}=====");
    // await FirebaseMessaging.onMessage.listen((message) {
    //   notifications.add(message.notification!.body.toString());
    // });
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNotifications();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: const Color.fromARGB(253, 243, 222, 195),
        body: notifications.length != 0
            ? Column(
                children: [
                  for (var i = 0; i < notifications.length; i++)
                    Column(
                      children: [
                        Text(notifications[i].message),
                        const SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                ],
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
