import 'package:cloud_firestore/cloud_firestore.dart';

class MessageChat {
  String idFrom;
  String idTo;
  String timestamp;
  String content;
  int type;

  MessageChat({
    required this.idFrom,
    required this.idTo,
    required this.timestamp,
    required this.content,
    required this.type,
  });

  Map<String, dynamic> toJson() {
    return {
      "IdFrom": this.idFrom,
      "IdTo": this.idTo,
      "TimeStamp": this.timestamp,
      "Content": this.content,
      "Type": this.type,
    };
  }

  factory MessageChat.fromDocument(DocumentSnapshot doc) {
    String idFrom = doc.get("IdFrom");
    String idTo = doc.get("IdTo");
    String timestamp = doc.get("TimeStamp");
    String content = doc.get("Content");
    int type = doc.get("Type");
    return MessageChat(
        idFrom: idFrom,
        idTo: idTo,
        timestamp: timestamp,
        content: content,
        type: type);
  }
}

Stream<QuerySnapshot> getChatStream(String groupChatId, int limit) {
  return FirebaseFirestore.instance
      .collection("Messages")
      .doc(groupChatId)
      .collection(groupChatId)
      .orderBy("TimeStamp", descending: true)
      .limit(limit)
      .snapshots();
}

void sendMessage(String content, int type, String groupChatId,
    String currentUserId, String peerId) {
  DocumentReference documentReference = FirebaseFirestore.instance
      .collection("Messages")
      .doc(groupChatId)
      .collection(groupChatId)
      .doc(DateTime.now().toString());

  MessageChat messageChat = MessageChat(
    idFrom: currentUserId,
    idTo: peerId,
    timestamp: DateTime.now().toString(),
    content: content,
    type: type,
  );

  FirebaseFirestore.instance.runTransaction((transaction) async {
    transaction.set(
      documentReference,
      messageChat.toJson(),
    );
  });
}

class TypeMessage {
  static const text = 0;
}

Future<Stream<QuerySnapshot>> getUserChats(String itIsMyName) async {
  return await FirebaseFirestore.instance
      .collection("Messages")
      .where("Users", arrayContains: itIsMyName)
      .snapshots();
}

getUserInfo(String username) async {
  return await FirebaseFirestore.instance
      .collection("Patients")
      .where("FullName", isEqualTo: username)
      .get();
}
