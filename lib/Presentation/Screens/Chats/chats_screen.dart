import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sos_app/Presentation/Constants/app_assets.dart';
import 'package:sos_app/Presentation/Views/chat_card_widget.dart';
import '../../../Data/Models/ChatMessages.dart';
import '../../../Data/Models/patient.dart';
import '../../Styles/colors.dart';
import '../../Styles/fonts.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ChatsScreen extends StatefulWidget {
  ChatsScreen({Key? key}) : super(key: key);

  @override
  State<ChatsScreen> createState() => _ChatsScreen();
}

class _ChatsScreen extends State<ChatsScreen> {
  Patient patient = Patient();
  Stream? chatRooms;

  Widget chatRoomsList() {
    return StreamBuilder(
      stream: chatRooms,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.docs.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data.docs[index];
                  return ChatCardWidget();
                })
            : Center(child: CircularProgressIndicator());
      },
    );
  }

  getChatRooms() async {
    chatRooms = await getUserChats(patient.username);
    setState(() {});
  }

  @override
  void initState() {
    () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      patient.username = prefs.getString("FullName");
      patient.email = prefs.getString("Email");
      patient.phoneNumber = prefs.getString("PhoneNumber");
      patient.password = prefs.getString("Password");
      patient.age = prefs.getString("Age");
      patient.gender = prefs.getString("Gender");
      patient.image = prefs.getString("Image");
      getChatRooms();
      setState(() {});
    }();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(253, 243, 222, 195),
        appBar: AppBar(
          title: const Text(
            "Chats",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
          ),
          actions: <Widget>[
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search),
              color: Colors.white,
            )
          ],
          centerTitle: true,
          toolbarHeight: 60.2,
          elevation: 4,
          backgroundColor: primaryColor,
        ),
        body: chatRoomsList());
  }
}
