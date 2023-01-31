import 'package:flutter/material.dart';
import 'package:sos_app/Presentation/PatientScreens/Profile/BurnReports/specific_report_screen.dart';
import 'package:sos_app/Presentation/Styles/colors.dart';
import 'package:sos_app/Presentation/Styles/fonts.dart';
import '../../../../Data/Models/ReportModel.dart';

class BurnReportsScreen extends StatefulWidget {
  List<Report> reports;
  BurnReportsScreen({Key? key, required this.reports}) : super(key: key);

  @override
  State<BurnReportsScreen> createState() => _BurnReportsScreenState();
}

class _BurnReportsScreenState extends State<BurnReportsScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        centerTitle: true,
        toolbarHeight: 64.5,
        title: const Text('Burn Reports',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            return Navigator.pop(context);
          },
          icon:
              const Icon(Icons.arrow_back_ios_rounded, color: white, size: 30),
        ),
      ),
      body: Container(
        color: back,
        child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: widget.reports.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                        margin: const EdgeInsets.all(10),
                        elevation: 7,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        color: white,
                        child: ListTile(
                          title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(children: <Widget>[
                                  const Text(
                                    "Degree:",
                                    style: TextStyle(
                                      fontSize: contentFont,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "    ${widget.reports[index].burnDegree}",
                                    style: const TextStyle(
                                      fontSize: contentFont,
                                      color: Colors.grey,
                                    ),
                                  )
                                ]),
                                Row(children: <Widget>[
                                  const Text(
                                    "Date:",
                                    style: TextStyle(
                                      letterSpacing: 0.5,
                                      fontSize: contentFont,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "       ${widget.reports[index].Date}",
                                    style: const TextStyle(
                                      letterSpacing: 0.5,
                                      fontSize: contentFont,
                                      color: Colors.grey,
                                    ),
                                  )
                                ]),
                              ]),
                          trailing: const Icon(
                            Icons.navigate_next_outlined,
                            size: 30,
                            color: black,
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SpecificReportScreen(
                                      report: widget.reports[index]),
                                ));
                          },
                        )),
                  );
                })),
      ),
    );
  }
}
