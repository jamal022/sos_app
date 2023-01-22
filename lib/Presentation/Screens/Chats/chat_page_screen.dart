import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:sos_app/Presentation/Constants/app_assets.dart';
import '../../Styles/colors.dart';
import '../../Styles/fonts.dart';

class ChatPageScreen extends StatefulWidget {
  ChatPageScreen({Key? key}) : super(key: key);

  @override
  State<ChatPageScreen> createState() => _ChatPageScreen();
}

class _ChatPageScreen extends State<ChatPageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(253, 243, 222, 195),
        appBar: AppBar(
          title: Text(
            "Doctor Name",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
          ),
          actions: [
            CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage('assets/images/R.jpeg'),
            )
          ],
          centerTitle: true,
          toolbarHeight: 60.2,
          elevation: 4,
          backgroundColor: primaryColor,
        ),
        body: Column(children: <Widget>[
          Expanded(
            child: Column(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                        alignment: Alignment.topLeft,
                        child: Container(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.8,
                          ),
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                )
                              ]),
                          child: Text('Hii , How are you?',
                              style: TextStyle(color: Colors.black54)),
                        )),
                    Row(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40)),
                              border: Border.all(
                                  width: 2,
                                  color: Theme.of(context).primaryColor),
                              //shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  blurRadius: 5,
                                  spreadRadius: 2,
                                )
                              ]),
                          child: CircleAvatar(
                            radius: 15,
                            backgroundImage: AssetImage('assets/images/R.jpeg'),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text('12:30',
                            style:
                                TextStyle(fontSize: 12, color: Colors.black45)),
                      ],
                    )
                  ],
                ),
                Column(children: <Widget>[
                  Container(
                      alignment: Alignment.topRight,
                      child: Container(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.8,
                        ),
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 214, 160, 80),
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                              )
                            ]),
                        child: Text('I am fine , Thank you ..',
                            style: TextStyle(color: Colors.black54)),
                      )),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          '12:32',
                          style: TextStyle(fontSize: 12, color: Colors.black45),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          padding: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40)),
                              border: Border.all(
                                  width: 2,
                                  color: Theme.of(context).primaryColor),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  blurRadius: 5,
                                  spreadRadius: 2,
                                )
                              ]),
                          child: CircleAvatar(
                            radius: 15,
                            backgroundImage:
                                AssetImage('assets/images/dr.jpeg'),
                          ),
                        ),
                      ])
                ]),
                Container(
                    alignment: Alignment.topLeft,
                    child: Container(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.8,
                      ),
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                            )
                          ]),
                      child: Text('Welcome ...',
                          style: TextStyle(color: Colors.black54)),
                    )),
                Row(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(40)),
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
                        radius: 15,
                        backgroundImage: AssetImage('assets/images/R.jpeg'),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text('12:35',
                        style: TextStyle(fontSize: 12, color: Colors.black45)),
                  ],
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5),
            margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
            height: 60,
            color: Color.fromARGB(255, 255, 247, 234),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.photo),
                  iconSize: 25,
                  color: primaryColor,
                ),
                Expanded(
                    child: TextField(
                  decoration: InputDecoration.collapsed(
                    hintText: 'Send a message ...',
                  ),
                  textCapitalization: TextCapitalization.sentences,
                )),
                IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.send),
                    iconSize: 25,
                    color: primaryColor)
              ],
            ),
          )
        ]));
  }
}
