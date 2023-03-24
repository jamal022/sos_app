import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:sos_app/Presentation/Widgets/loading_widget.dart';

class Support {
  var supportId;
  var username;
  var userEmail;
  var message;

  Support(
      {this.supportId,
      required this.username,
      required this.userEmail,
      required this.message});
}

AddSuport(Support support, context) async {
  showLoading(context);
  await FirebaseFirestore.instance.collection("Supports").add({
    "UserName": support.username,
    "UserEmail": support.userEmail,
    "Message": support.message,
  }).then((value) {
    Navigator.pop(context);
  });
  return "Added";
}

GetSupports() async {
  List<Support> supports = [];
  await FirebaseFirestore.instance.collection("Supports").get().then((value) {
    for (var s in value.docs) {
      supports.add(Support(
          supportId: s.id,
          username: s.data()["UserName"],
          userEmail: s.data()["UserEmail"],
          message: s.data()["Message"]));
    }
  });
  return supports;
}

DeleteSupport(id, context) async {
  await FirebaseFirestore.instance
      .collection("Supports")
      .doc(id)
      .delete()
      .then((value) {
    Navigator.pop(context);
  });
  return "deleted";
}
