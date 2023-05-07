import 'package:flutter/cupertino.dart';
import 'package:pdf/widgets.dart' as pw;
import '../Styles/fonts.dart';

buildPrintableData(report, image, logo) => pw.Container(
      margin: const pw.EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
      decoration: const pw.BoxDecoration(),
      child: pw.Column(children: <pw.Widget>[
        pw.Container(
            child: pw.Row(children: <pw.Widget>[
          pw.Container(child: pw.Image(logo), width: 80, height: 80),
          pw.Text("SOS - Save Our Skin", style: pw.TextStyle(fontSize: 20)),
        ])),
        pw.Container(
            margin: const pw.EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 5.0),
            child: pw.Center(
              child: pw.Padding(
                  padding: const pw.EdgeInsets.all(10.5),
                  child: pw.Image(image,
                      width: 200, height: 150, fit: pw.BoxFit.fill)),
            )),
        pw.Container(
            margin: const pw.EdgeInsets.all(10),
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
                    pw.Text("   ${report.causeOfBurn}",
                        style: const pw.TextStyle(
                          fontSize: fontfonty,
                          //color: Colors.grey,
                        )),
                  ]),

                  pw.SizedBox(height: 10),
                  //First aid
                  pw.Row(children: <pw.Widget>[
                    pw.Text('First aid:',
                        style: pw.TextStyle(fontSize: fontfonty)),
                  ]),

                  pw.Text('${report.firstAid}',
                      style: pw.TextStyle(
                        fontSize: fontfonty,
                        //color: Colors.grey,
                      )),
                ])),
        pw.Container(
            child: pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.end,
                mainAxisAlignment: pw.MainAxisAlignment.end,
                children: <pw.Widget>[
              pw.Text("${DateTime.now()}",
                  style: pw.TextStyle(
                    fontSize: 18,
                  )),
            ])),
      ]),
    );
