import 'package:pdf/widgets.dart' as pw;
import '../Styles/fonts.dart';

buildPrintableData(report, image) => pw.Container(
      margin: const pw.EdgeInsets.fromLTRB(15.0, 20.0, 15.0, 10.0),
      decoration: const pw.BoxDecoration(
          //color: pw.Colors.white,
          ),
      child: pw.Column(children: <pw.Widget>[
        pw.SizedBox(height: 10),
        pw.Container(
            margin: const pw.EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 5.0),
            child: pw.Center(
              child: pw.Padding(
                  padding: const pw.EdgeInsets.all(10.5),
                  child: pw.Image(
                    image,
                    width: 200,
                    height: 300,
                  )),
            )),
        pw.Container(
            margin: const pw.EdgeInsets.all(20),
            child: pw.Column(
                mainAxisAlignment: pw.MainAxisAlignment.start,
                children: <pw.Widget>[
                  pw.SizedBox(height: 10),
                  //Degree of burn
                  pw.Row(children: <pw.Widget>[
                    pw.Text('Degree of burn:',
                        style: pw.TextStyle(
                            fontSize: fontfonty,
                            fontWeight: pw.FontWeight.bold)),
                    pw.Text("   ${report.burnDegree}",
                        style: pw.TextStyle(
                          fontSize: fontfonty,
                          fontWeight: pw.FontWeight.bold,
                          //color: Colors.grey,
                        )),
                  ]),
                  pw.SizedBox(height: 10),
                  //Patient Name
                  pw.Row(children: <pw.Widget>[
                    pw.Text('Patient Name:',
                        style: pw.TextStyle(fontSize: fontfonty)),
                    pw.Text("   ${report.name}",
                        style: pw.TextStyle(
                          fontSize: fontfonty,
                          //color: Colors.grey,
                        )),
                  ]),
                  pw.SizedBox(height: 10),
                  //Age
                  pw.Row(children: <pw.Widget>[
                    pw.Text('Age:', style: pw.TextStyle(fontSize: fontfonty)),
                    pw.Text("   ${report.age}",
                        style: pw.TextStyle(
                          fontSize: fontfonty,
                          //color: Colors.grey,
                        )),
                  ]),
                  pw.SizedBox(height: 10),
                  //Gender
                  pw.Row(children: <pw.Widget>[
                    pw.Text('Gender:',
                        style: pw.TextStyle(fontSize: fontfonty)),
                    pw.Text("   ${report.gender}",
                        style: pw.TextStyle(
                          fontSize: fontfonty,
                          //color: Colors.grey,
                        )),
                  ]),
                  pw.SizedBox(height: 10),
                  //Phone Number
                  pw.Row(children: <pw.Widget>[
                    pw.Text('Phone Number:',
                        style: pw.TextStyle(fontSize: fontfonty)),
                    pw.Text("   ${report.phoneNumber}",
                        style: pw.TextStyle(
                          fontSize: fontfonty,
                          //color: Colors.grey,
                        )),
                  ]),
                  pw.SizedBox(height: 10),

                  //Diabetes
                  pw.Row(children: <pw.Widget>[
                    pw.Text('Diabetes:',
                        style: pw.TextStyle(fontSize: fontfonty)),
                    pw.Text("   ${report.diabates}",
                        style: pw.TextStyle(
                          fontSize: fontfonty,
                          //color: Colors.grey,
                        )),
                  ]),
                  pw.SizedBox(height: 10),
                  //Blood Pressure
                  pw.Row(children: <pw.Widget>[
                    pw.Text('Blood Pressure:',
                        style: pw.TextStyle(fontSize: fontfonty)),
                    pw.Text("   ${report.pressure}",
                        style: pw.TextStyle(
                          fontSize: fontfonty,
                          //color: Colors.grey,
                        )),
                  ]),
                  pw.SizedBox(height: 10),
                  //Cause of burn
                  pw.Row(children: <pw.Widget>[
                    pw.Text('Cause of burn:',
                        style: pw.TextStyle(fontSize: fontfonty)),
                  ]),
                  pw.Text("   ${report.causeOfBurn}",
                      style: const pw.TextStyle(
                        fontSize: fontfonty,
                        //color: Colors.grey,
                      )),
                  pw.SizedBox(height: 10),
                  //First aid
                  pw.Row(children: <pw.Widget>[
                    pw.Text('First aid:',
                        style: pw.TextStyle(fontSize: fontfonty)),
                  ]),

                  pw.Text('Bla Bla Bla',
                      style: pw.TextStyle(
                        fontSize: fontfonty,
                        //color: Colors.grey,
                      )),
                ])),
        pw.SizedBox(height: 20),
      ]),
    );
