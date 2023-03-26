import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;

class NotificationModel {
  var notificationId;
  var userId;
  var message;
  var date;

  NotificationModel({
    this.notificationId,
    required this.userId,
    required this.message,
    required this.date,
  });
}

AddNotification(NotificationModel notification) async {
  await FirebaseFirestore.instance.collection("Notifications").add({
    "UserId": notification.userId,
    "Message": notification.message,
    "Date": notification.date,
  });
  return "sent";
}

GetNotifications(userId) async {
  List<NotificationModel> notifications = [];
  await FirebaseFirestore.instance
      .collection("Notifications")
      .where("UserId", isEqualTo: userId)
      .orderBy("Date", descending: true)
      .get()
      .then((value) {
    for (var notify in value.docs) {
      notifications.add(NotificationModel(
          userId: notify.data()["UserId"],
          message: notify.data()["Message"],
          date: notify.data()["Date"],
          notificationId: notify.id));
    }
  });

  return notifications;
}

SendNotifyToUser(String body, String token, String userId) async {
  var serverToken =
      "AAAA49edij8:APA91bGmk1SrTIStsQZgdj3WWDtgrWX__yQWhOnNTghDe7Gy6C9tVyWb3EN-FshKBmPjnvkY0CccbXFggo4GEgZ6K-JErp41RnmcWeVqgx2QZQJKfuBm1OdcJK9Ox0-spgYkv0kH4ETM";
  await http.post(
    Uri.parse('https://fcm.googleapis.com/fcm/send'),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'Key=$serverToken',
    },
    body: jsonEncode(<String, dynamic>{
      'notification': <String, dynamic>{
        'body': body.toString(),
        'title': "New Notification"
      },
      'priority': 'high',
      'data': <String, dynamic>{
        'click-action': 'FLUTTER_NOTIFICATION_CLICK',
      },
      'to': token,
    }),
  );
  var date =
      "${DateTime.now().year} - ${DateTime.now().month} - ${DateTime.now().day}";
  AddNotification(NotificationModel(userId: userId, message: body, date: date));
}

SendNotifyToTopic(String body) async {
  var serverToken =
      "AAAA49edij8:APA91bGmk1SrTIStsQZgdj3WWDtgrWX__yQWhOnNTghDe7Gy6C9tVyWb3EN-FshKBmPjnvkY0CccbXFggo4GEgZ6K-JErp41RnmcWeVqgx2QZQJKfuBm1OdcJK9Ox0-spgYkv0kH4ETM";
  await http.post(
    Uri.parse('https://fcm.googleapis.com/fcm/send'),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'Key=$serverToken',
    },
    body: jsonEncode(<String, dynamic>{
      'notification': <String, dynamic>{
        'body': body.toString(),
        'title': "New Notification"
      },
      'priority': 'high',
      'data': <String, dynamic>{
        'click-action': 'FLUTTER_NOTIFICATION_CLICK',
      },
      'to': "/topics/sos",
    }),
  );
  var date =
      "${DateTime.now().year} - ${DateTime.now().month} - ${DateTime.now().day}";
  AddNotification(NotificationModel(userId: "sos", message: body, date: date));
}
