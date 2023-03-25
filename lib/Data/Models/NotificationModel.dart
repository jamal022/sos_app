import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;

class NotificationModel {
  var notificationId;
  var userId;
  var message;

  NotificationModel({
    this.notificationId,
    required this.userId,
    required this.message,
  });
}

AddNotification(NotificationModel notification) async {
  await FirebaseFirestore.instance.collection("Notifications").add({
    "UserId": notification.userId,
    "Message": notification.message,
  });
  return "sent";
}

GetNotifications() async {
  List<NotificationModel> notifications = [];
  await FirebaseFirestore.instance
      .collection("Notifications")
      .get()
      .then((value) {
    for (var notify in value.docs) {
      notifications.add(NotificationModel(
          userId: notify.data()["UserId"],
          message: notify.data()["Message"],
          notificationId: notify.id));
    }
  });
  return notifications;
}

DeleteNotification(notificationId) async {
  await FirebaseFirestore.instance
      .collection("Notifications")
      .doc(notificationId)
      .delete();
  return "deleted";
}

SendNotify(String body) async {
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
      'to':
          "dJdi9YiwTK-DJARRbcN1s8:APA91bE6cT7jM_3AYIeQrG3pU2Y9eUn-0cGQ4j-SFTXB-6AMweIHht0HmsDi_77k6ul72mL7RIrZuKU2zIbM66AifGR4Xyg-N07npyzsXGKIQtIZSHXUYdH80Rrd-W-vAb-NG2-bHSqC",
    }),
  );
  AddNotification(NotificationModel(userId: '1220', message: body));
}
