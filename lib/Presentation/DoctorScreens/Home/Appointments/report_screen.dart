import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sos_app/Data/Models/patient.dart';
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

Patient doctor = Patient();

class _ReportScreenState extends State<ReportScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      doctor.id = prefs.getString("Id");
      doctor.image = prefs.getString("Image");
      doctor.username = prefs.getString("FullName");
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
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Image.network(
                    widget.report.image,
                    width: size.width / 2,
                    height: size.height / 4,
                  ),
                ),
                Container(
                    //margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.fromLTRB(20, 0, 10, 10),
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
                                    color: primaryColor)),
                          ]),
                          const SizedBox(height: 10),

                          //Patient Name
                          Row(children: <Widget>[
                            const Text('Patient Name:',
                                style: TextStyle(
                                    fontSize: fontfonty,
                                    fontWeight: FontWeight.bold)),
                            Text("   ${widget.report.name}",
                                style: const TextStyle(
                                    fontSize: fontfonty, color: Colors.grey)),
                          ]),
                          const SizedBox(height: 10),
                          //Age
                          Row(children: <Widget>[
                            const Text('Age:',
                                style: TextStyle(
                                    fontSize: fontfonty,
                                    fontWeight: FontWeight.bold)),
                            Text("   ${widget.report.age}",
                                style: const TextStyle(
                                    fontSize: fontfonty, color: Colors.grey)),
                          ]),
                          const SizedBox(height: 10),
                          //Gender
                          Row(children: <Widget>[
                            const Text('Gender:',
                                style: TextStyle(
                                    fontSize: fontfonty,
                                    fontWeight: FontWeight.bold)),
                            Text("   ${widget.report.gender}",
                                style: const TextStyle(
                                    fontSize: fontfonty, color: Colors.grey)),
                          ]),
                          const SizedBox(height: 10),
                          //Phone Number
                          Row(children: <Widget>[
                            const Text('Phone Number:',
                                style: TextStyle(
                                    fontSize: fontfonty,
                                    fontWeight: FontWeight.bold)),
                            Text("   ${widget.report.phoneNumber}",
                                style: const TextStyle(
                                    fontSize: fontfonty, color: Colors.grey)),
                          ]),
                          const SizedBox(height: 10),

                          //Diabetes
                          Row(children: <Widget>[
                            const Text('Diabetes:',
                                style: TextStyle(
                                    fontSize: fontfonty,
                                    fontWeight: FontWeight.bold)),
                            Text("   ${widget.report.diabates}",
                                style: const TextStyle(
                                    fontSize: fontfonty, color: Colors.grey)),
                          ]),
                          const SizedBox(height: 10),
                          //Blood Pressure
                          Row(children: <Widget>[
                            const Text('Blood Pressure:',
                                style: TextStyle(
                                    fontSize: fontfonty,
                                    fontWeight: FontWeight.bold)),
                            Text("   ${widget.report.pressure}",
                                style: const TextStyle(
                                    fontSize: fontfonty, color: Colors.grey)),
                          ]),
                          const SizedBox(height: 10),
                          //Cause of burn
                          Row(children: <Widget>[
                            const Text('Cause of burn:',
                                style: TextStyle(
                                    fontSize: fontfonty,
                                    fontWeight: FontWeight.bold)),
                            Text("  ${widget.report.causeOfBurn}",
                                style: const TextStyle(
                                    fontSize: fontfonty, color: Colors.grey))
                          ]),
                          const SizedBox(height: 10),
                          //First aid
                          Row(children: const <Widget>[
                            Text('First aid:\n',
                                style: TextStyle(
                                    fontSize: fontfonty,
                                    fontWeight: FontWeight.bold)),
                          ]),

                          Text(widget.report.firstAid,
                              style: const TextStyle(
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
                                currentuser: doctor.id,
                                peerId: widget.report.patientId,
                                groupChatId:
                                    "${doctor.id}-${widget.report.patientId}",
                                currentimage: doctor.image,
                                peerimage: widget.report.image,
                                peername: widget.report.name,
                                currentname: doctor.username,
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
