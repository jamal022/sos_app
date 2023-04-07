import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sos_app/Data/Models/NotificationModel.dart';
import '../../Styles/colors.dart';

class NotificationsScreen extends StatefulWidget {
  NotificationsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationsScreen> createState() => _NotificationsScreen();
}

class _NotificationsScreen extends State<NotificationsScreen> {
  var id;

  _getNotifications() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    id = prefs.getString("Id");

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _getNotifications();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color.fromARGB(253, 243, 222, 195),
      body: StreamBuilder(
        stream: getNotifications(id),
        builder: (context, snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    List<QueryDocumentSnapshot> _notifications =
                        snapshot.data!.docs;
                    if (_notifications.length != 0) {
                      return Column(
                        children: [
                          Slidable(
                            endActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.redAccent,
                                  ),
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.delete,
                                      color: white,
                                    ),
                                    onPressed: (() async {
                                      await DeleteNotificatin(
                                          _notifications[index].id);
                                    }),
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                ListTile(
                                  title: Text(
                                    _notifications[index].get("Message"),
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 0, 10, 0),
                                      child: Text(
                                        _notifications[index].get("Date"),
                                        style: const TextStyle(
                                            fontSize: 16,
                                            color: Color.fromARGB(
                                                255, 99, 97, 97)),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const Divider(
                            color: Color.fromARGB(255, 80, 79, 79),
                            endIndent: 10,
                            height: 10,
                            indent: 10,
                            thickness: 2,
                          )
                        ],
                      );
                    } else {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            const Padding(
                                padding: EdgeInsets.fromLTRB(25, 2, 25, 5)),
                            const Icon(
                              Icons.warning_amber_rounded,
                              size: 100,
                              color: primaryColor,
                            ),
                            SizedBox(
                              height: size.height / 40,
                            ),
                            const Text(
                              'There is no Notifications',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor),
                            ),
                          ],
                        ),
                      );
                    }
                  })
              : const Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}
