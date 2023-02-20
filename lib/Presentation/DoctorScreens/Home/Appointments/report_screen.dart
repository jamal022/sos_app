import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sos_app/Presentation/Styles/colors.dart';
import '../../../../Data/Models/ReportModel.dart';
import '../../../Screens/Chats/chat_page_screen.dart';
import '../../../Styles/fonts.dart';

class ReportScreen extends StatefulWidget {
  Report report;

  ReportScreen({Key? key, required this.report}) : super(key: key);

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

var doctorName;

class _ReportScreenState extends State<ReportScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      doctorName = prefs.getString("FullName");
      setState(() {});
    }();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: back,
        appBar: AppBar(
          backgroundColor: primaryColor,
          elevation: 0,
          centerTitle: true,
          toolbarHeight: 64.5,
          title: Text(widget.report.name,
              style:
                  const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            Container(
              margin: const EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 10.0),
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Column(children: <Widget>[
                const SizedBox(height: 10),
                Container(
                    margin: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 5.0),
                    child: Center(
                      child: Padding(
                          padding: const EdgeInsets.all(10.5),
                          child: Image.network(
                            widget.report.image,
                            width: size.width / 2,
                            height: size.height / 4,
                          )),
                    )),
                Container(
                    margin: const EdgeInsets.all(20),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          const SizedBox(height: 10),
                          //Degree of burn
                          Row(children: <Widget>[
                            const Text('Degree of burn:',
                                style: TextStyle(
                                    fontSize: fontfonty,
                                    fontWeight: FontWeight.bold)),
                            Text("   ${widget.report.burnDegree}",
                                style: const TextStyle(
                                    fontSize: fontfonty,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey)),
                          ]),
                          const SizedBox(height: 10),
                          //Patient Name
                          Row(children: <Widget>[
                            const Text('Patient Name:',
                                style: TextStyle(fontSize: fontfonty)),
                            Text("   ${widget.report.name}",
                                style: const TextStyle(
                                    fontSize: fontfonty, color: Colors.grey)),
                          ]),
                          const SizedBox(height: 10),
                          //Age
                          Row(children: <Widget>[
                            const Text('Age:',
                                style: TextStyle(fontSize: fontfonty)),
                            Text("   ${widget.report.age}",
                                style: const TextStyle(
                                    fontSize: fontfonty, color: Colors.grey)),
                          ]),
                          const SizedBox(height: 10),
                          //Gender
                          Row(children: <Widget>[
                            const Text('Gender:',
                                style: TextStyle(fontSize: fontfonty)),
                            Text("   ${widget.report.gender}",
                                style: const TextStyle(
                                    fontSize: fontfonty, color: Colors.grey)),
                          ]),
                          const SizedBox(height: 10),
                          //Phone Number
                          Row(children: <Widget>[
                            const Text('Phone Number:',
                                style: TextStyle(fontSize: fontfonty)),
                            Text("   ${widget.report.phoneNumber}",
                                style: const TextStyle(
                                    fontSize: fontfonty, color: Colors.grey)),
                          ]),
                          const SizedBox(height: 10),

                          //Diabetes
                          Row(children: <Widget>[
                            const Text('Diabetes:',
                                style: TextStyle(fontSize: fontfonty)),
                            Text("   ${widget.report.diabates}",
                                style: const TextStyle(
                                    fontSize: fontfonty, color: Colors.grey)),
                          ]),
                          const SizedBox(height: 10),
                          //Blood Pressure
                          Row(children: <Widget>[
                            const Text('Blood Pressure:',
                                style: TextStyle(fontSize: fontfonty)),
                            Text("   ${widget.report.pressure}",
                                style: const TextStyle(
                                    fontSize: fontfonty, color: Colors.grey)),
                          ]),
                          const SizedBox(height: 10),
                          //Cause of burn
                          Row(children: const <Widget>[
                            Text('Cause of burn:',
                                style: TextStyle(fontSize: fontfonty)),
                          ]),
                          Text("   ${widget.report.causeOfBurn}",
                              style: const TextStyle(
                                  fontSize: fontfonty, color: Colors.grey)),
                          const SizedBox(height: 10),
                          //First aid
                          Row(children: const <Widget>[
                            Text('First aid:',
                                style: TextStyle(fontSize: fontfonty)),
                          ]),

                          const Text('Bla Bla Bla',
                              style: TextStyle(
                                  fontSize: fontfonty, color: Colors.grey)),
                        ])),
                const SizedBox(height: 20),
              ]),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(primaryColor),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ))),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChatPageScreen(
                                currentuser: doctorName,
                                peerId: widget.report.name,
                                groupChatId:
                                    "${widget.report.name}-${doctorName}",
                              )),
                    );
                  },
                  child: const Text('Send message',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ))),
            ),
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
              height: 10,
            ),
          ]),
        ));
  }
}
