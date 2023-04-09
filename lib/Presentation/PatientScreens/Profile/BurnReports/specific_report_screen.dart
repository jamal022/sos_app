import 'package:flutter/material.dart';
import 'package:sos_app/Presentation/Styles/colors.dart';
import '../../../../Data/Models/ReportModel.dart';
import '../../../Styles/fonts.dart';

class SpecificReportScreen extends StatefulWidget {
  Report report;
  SpecificReportScreen({Key? key, required this.report}) : super(key: key);

  @override
  State<SpecificReportScreen> createState() => _SpecificReportScreenState();
}

class _SpecificReportScreenState extends State<SpecificReportScreen> {
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
          title: Text('${widget.report.burnDegree} (${widget.report.date})',
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        body: SingleChildScrollView(
            child: Column(children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 10, 8, 0),
            child: Center(
              child: MaterialButton(
                  elevation: 5.0,
                  color: Colors.red,
                  padding: const EdgeInsets.all(10),
                  shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide.none,
                  ),
                  onPressed: () {
                    showDialog(
                      useSafeArea: false,
                      context: context,
                      barrierColor: splashBack,
                      builder: (ctx) => AlertDialog(
                        content: const Text(
                            "Are you sure, you want to delete this report?",
                            style: TextStyle(
                              fontSize: contentFont,
                            )),
                        actions: [
                          Row(
                            children: [
                              //btn cancel
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: OutlinedButton(
                                    onPressed: () {
                                      Navigator.pop(ctx);
                                    },
                                    child: const Text(
                                      "Cancel",
                                      style: TextStyle(
                                        color: primaryColor,
                                        fontSize: contentFont,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: MaterialButton(
                                    elevation: 6.0,
                                    color: Colors.redAccent,
                                    onPressed: () async {
                                      await DeleteReportImage(
                                          widget.report.image);
                                      var res = await DeleteReport(
                                          widget.report.reportId, context);
                                      if (res == "deleted") {
                                        Navigator.pop(context, "refresh");
                                      }
                                    },
                                    child: const Text(
                                      'Sure',
                                      style: TextStyle(
                                        color: white,
                                        fontSize: contentFont,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                  child: const Text(
                    '  Delete  ',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
            ),
          ),
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
        ])));
  }
}
