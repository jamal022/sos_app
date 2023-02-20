import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../Data/Models/ChatMessages.dart';
import '../Screens/Chats/chat_page_screen.dart';

class ChatCardWidget extends StatefulWidget {
  final String userName;
  final String ChatId;
  const ChatCardWidget(
      {super.key, required this.userName, required this.ChatId});

  @override
  State<ChatCardWidget> createState() => _ChatCardWidgetState();
}

class _ChatCardWidgetState extends State<ChatCardWidget> {
  String profilePicUrl = "", username = "";

  getThisUserInfo() async {
    username =
        widget.ChatId.replaceAll(widget.userName, "").replaceAll("-", "");
    QuerySnapshot querySnapshot = await getUserInfo("FullName");
    profilePicUrl = querySnapshot.docs[0]["Image"];
    setState(() {});
  }

  @override
  void initState() {
    getThisUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatPageScreen(
                  currentuser: widget.userName,
                  peerId: username,
                  groupChatId: widget.ChatId,
                ),
              ));
        },
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Row(children: <Widget>[
              Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(40)),
                    border: Border.all(
                        width: 2, color: Theme.of(context).primaryColor),

                    //shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        blurRadius: 5,
                        spreadRadius: 2,
                      )
                    ]),
                child: CircleAvatar(
                  radius: 35,
                  backgroundImage: NetworkImage(
                    profilePicUrl,
                  ),
                ),
              ),
              Container(
                  width: MediaQuery.of(context).size.width * 0.65,
                  padding: const EdgeInsets.only(left: 20),
                  child: Column(children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              username,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 5),
                              width: 7,
                              height: 7,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Theme.of(context).primaryColor,
                              ),
                            )
                          ],
                        ),
                        const Text(
                          'Mon',
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 18,
                              fontWeight: FontWeight.w300),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'This is the last message...',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.black54,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    )
                  ]))
            ])));
  }
}
