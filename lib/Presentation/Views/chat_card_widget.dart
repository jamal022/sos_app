import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sos_app/Presentation/Styles/colors.dart';
import '../Screens/Chats/chat_page_screen.dart';

class ChatCardWidget extends StatefulWidget {
  final String userName;
  final String ChatId;
  final String userImage;
  final String currentname;
  const ChatCardWidget(
      {super.key,
      required this.userName,
      required this.ChatId,
      required this.userImage,
      required this.currentname});

  @override
  State<ChatCardWidget> createState() => _ChatCardWidgetState();
}

class _ChatCardWidgetState extends State<ChatCardWidget> {
  String username = "",
      userimage = "",
      currentImage = "",
      Image = "",
      chatid = "",
      lastmessage = "",
      time = "",
      peername = "",
      currentname = "",
      name = "";

  getThisUserInfo() {
    username =
        widget.ChatId.replaceAll(widget.userName, "").replaceAll("-", "");

    setState(() {});
  }

  getUserdata() {
    FirebaseFirestore.instance
        .collection('Messages')
        .doc(widget.ChatId)
        .get()
        .then((snapshot) {
      setState(() {
        userimage = snapshot.data()!['UserImage1'];
        currentImage = snapshot.data()!['UserImage2'];
        peername = snapshot.data()!['PeerName'];
        currentname = snapshot.data()!['CurrentName'];
      });
    });
  }

  getpeerimage() {
    if (userimage == widget.userImage) {
      Image = currentImage;
    } else {
      Image = userimage;
    }
    return Image;
  }

  getpeername() {
    if (peername == widget.currentname) {
      name = currentname;
    } else {
      name = peername;
    }
    return name;
  }

  @override
  void initState() {
    getUserdata();
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
                currentimage: widget.userImage,
                peerimage: Image,
                peername: getpeername(),
                currentname: widget.currentname,
              ),
            ));
      },
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
              color: const Color.fromARGB(255, 247, 245, 245),
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 5, 10),
                  child: Row(children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(40)),
                          border: Border.all(width: 2, color: primaryColor),
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
                          getpeerimage(),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.65,
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        getpeername(),
                        style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                    )
                  ])))),
    );
  }
}
