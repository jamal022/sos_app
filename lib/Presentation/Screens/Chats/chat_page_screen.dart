import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sos_app/Data/Models/patient.dart';
import '../../../Data/Models/ChatMessages.dart';
import '../../Styles/colors.dart';

class ChatPageScreen extends StatefulWidget {
  String currentuser;
  String peerId;
  String groupChatId;
  String currentimage;
  String peerimage;
  String peername;
  String currentname;
  ChatPageScreen({
    Key? key,
    required this.peerId,
    required this.currentuser,
    required this.groupChatId,
    required this.currentimage,
    required this.peerimage,
    required this.peername,
    required this.currentname,
  }) : super(key: key);

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
      'UserImage1': widget.currentimage,
      'UserImage2': widget.peerimage,
      'PeerName': widget.peername,
      'CurrentName': widget.currentname,
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
          widget.peername,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage(
                widget.peerimage,
              ),
            ),
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
      width: double.infinity,
      height: 50,
      decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: black, width: 0.5)),
          color: Colors.white),
      child: Row(
        children: <Widget>[
          // Edit text
          Flexible(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onSubmitted: (value) {
                    onSendMessage(MessageController.text, TypeMessage.text);
                  },
                  style: const TextStyle(color: primaryColor, fontSize: 15),
                  controller: MessageController,
                  decoration: const InputDecoration.collapsed(
                    hintText: 'Type your message...',
                    hintStyle: TextStyle(color: black),
                  ),
                ),
              ),
            ),
          ),
// Button send message
          Material(
            color: Colors.white,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              child: IconButton(
                icon: const Icon(Icons.send),
                onPressed: () {
                  onSendMessage(MessageController.text, TypeMessage.text);
                },
                color: primaryColor,
              ),
            ),
          ),
        ],
      ),
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
                      padding: const EdgeInsets.only(
                          left: 0, right: 10, top: 10, bottom: 10),
                      itemBuilder: (context, index) =>
                          buildItem(index, snapshot.data?.docs[index]),
                      itemCount: snapshot.data?.docs.length,
                      reverse: true,
                    );
                  } else {
                    return const Center(child: Text("No message here yet..."));
                  }
                } else {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: black,
                    ),
                  );
                }
              },
            )
          : const Center(
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
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            // Text
            Container(
              padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
              width: 200,
              decoration: BoxDecoration(
                  color: primaryColor, borderRadius: BorderRadius.circular(8)),
              margin: EdgeInsets.only(
                  bottom: isLastMessageRight(index) ? 20 : 10, right: 10),
              child: Text(
                messageChat.content,
                style: const TextStyle(color: white),
              ),
            ),
          ],
        );
      } else {
        // Left (peer message)
        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  isLastMessageLeft(index)
                      ? Material(
                          clipBehavior: Clip.hardEdge,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(18),
                          ),
                          child: Image.network(
                            widget.peerimage,
                            width: 35,
                            height: 35,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Container(width: 35),
                  Container(
                    padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                    width: 200,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 228, 176, 97),
                        borderRadius: BorderRadius.circular(8)),
                    margin: const EdgeInsets.only(left: 10),
                    child: Text(
                      messageChat.content,
                      style: const TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            ],
          ),
        );
      }
    } else {
      return const SizedBox.shrink();
    }
  }
}
