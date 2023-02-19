import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sos_app/Data/Models/patient.dart';
import '../../../Data/Models/ChatMessages.dart';
import '../../Styles/colors.dart';

class ChatPageScreen extends StatefulWidget {
  String currentuser;
  String peerId;
  String groupChatId;
  ChatPageScreen(
      {Key? key,
      required this.peerId,
      required this.currentuser,
      required this.groupChatId})
      : super(key: key);

  @override
  State<ChatPageScreen> createState() => _ChatPageScreen();
}

class _ChatPageScreen extends State<ChatPageScreen> {
  Patient patient = Patient();
  TextEditingController MessageController = new TextEditingController();
  List<QueryDocumentSnapshot> listMessage = [];
  int _limit = 20;
  int _limitIncrement = 20;

  void readLocal() {
    List<String> users = [widget.currentuser, widget.peerId];

    FirebaseFirestore.instance
        .collection("Messages")
        .doc(widget.groupChatId)
        .set({
      'Users': users,
      'ChatId': widget.groupChatId,
    });
  }

  void onSendMessage(String content, int type) {
    if (content.trim().isNotEmpty) {
      MessageController.clear();
      sendMessage(
          content, type, widget.groupChatId, widget.currentuser, widget.peerId);
    }
  }

  @override
  void initState() {
    () async {
      readLocal();
      setState(() {});
    }();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(253, 243, 222, 195),
      appBar: AppBar(
        title: Text(
          widget.peerId,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
        ),
        actions: [
          CircleAvatar(
            radius: 25,
            //backgroundImage: NetworkImage(
            //  peerImage!,
            //),
          )
        ],
        centerTitle: true,
        toolbarHeight: 60.2,
        elevation: 4,
        backgroundColor: primaryColor,
      ),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                // List of messages
                buildListMessage(),

                // Input content
                buildInput(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildInput() {
    return Container(
      child: Row(
        children: <Widget>[
          // Edit text
          Flexible(
            child: Container(
              child: TextField(
                onSubmitted: (value) {
                  onSendMessage(MessageController.text, TypeMessage.text);
                },
                style: TextStyle(color: primaryColor, fontSize: 15),
                controller: MessageController,
                decoration: InputDecoration.collapsed(
                  hintText: 'Type your message...',
                  hintStyle: TextStyle(color: black),
                ),
                autofocus: true,
              ),
            ),
          ),
// Button send message
          Material(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 8),
              child: IconButton(
                icon: Icon(Icons.send),
                onPressed: () =>
                    onSendMessage(MessageController.text, TypeMessage.text),
                color: primaryColor,
              ),
            ),
            color: Colors.white,
          ),
        ],
      ),
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
          border: Border(top: BorderSide(color: black, width: 0.5)),
          color: Colors.white),
    );
  }

  Widget buildListMessage() {
    return Flexible(
      child: widget.groupChatId.isNotEmpty
          ? StreamBuilder<QuerySnapshot>(
              stream: getChatStream(widget.groupChatId, _limit),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  listMessage = snapshot.data!.docs;
                  if (listMessage.length > 0) {
                    return ListView.builder(
                      padding: EdgeInsets.only(
                          left: 14, right: 14, top: 10, bottom: 10),
                      itemBuilder: (context, index) =>
                          buildItem(index, snapshot.data?.docs[index]),
                      itemCount: snapshot.data?.docs.length,
                      reverse: true,
                    );
                  } else {
                    return Center(child: Text("No message here yet..."));
                  }
                } else {
                  return Center(
                    child: CircularProgressIndicator(
                      color: black,
                    ),
                  );
                }
              },
            )
          : Center(
              child: CircularProgressIndicator(
                color: black,
              ),
            ),
    );
  }

  bool isLastMessageLeft(int index) {
    if ((index > 0 &&
            listMessage[index - 1].get("IdFrom") == widget.currentuser) &&
        index == 0) {
      return true;
    } else {
      return false;
    }
  }

  bool isLastMessageRight(int index) {
    if ((index > 0 &&
            listMessage[index - 1].get("IdFrom") != widget.currentuser) &&
        index == 0) {
      return true;
    } else {
      return false;
    }
  }

  Widget buildItem(int index, DocumentSnapshot? document) {
    if (document != null) {
      MessageChat messageChat = MessageChat.fromDocument(document);
      if (messageChat.idFrom == widget.currentuser) {
        // Right (my message)
        return Row(
          children: <Widget>[
            // Text
            Container(
              child: Text(
                messageChat.content,
                style: TextStyle(color: white),
              ),
              padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
              width: 200,
              decoration: BoxDecoration(
                  color: primaryColor, borderRadius: BorderRadius.circular(8)),
              margin: EdgeInsets.only(
                  bottom: isLastMessageRight(index) ? 20 : 10, right: 10),
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.end,
        );
      } else {
        // Left (peer message)
        return Container(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  isLastMessageLeft(index)
                      ? Material(
                          // child: Image.network(
                          // patient.image,
                          //width: 35,
                          //height: 35,
                          //fit: BoxFit.cover,
                          //),
                          borderRadius: BorderRadius.all(
                            Radius.circular(18),
                          ),
                          clipBehavior: Clip.hardEdge,
                        )
                      : Container(width: 35),
                  Container(
                    child: Text(
                      messageChat.content,
                      style: TextStyle(color: Colors.white),
                    ),
                    padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                    width: 200,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 214, 160, 80),
                        borderRadius: BorderRadius.circular(8)),
                    margin: EdgeInsets.only(left: 10),
                  )
                ],
              ),
            ],
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
          margin: EdgeInsets.only(bottom: 10),
        );
      }
    } else {
      return SizedBox.shrink();
    }
  }
}
