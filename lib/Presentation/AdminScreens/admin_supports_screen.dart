import 'package:flutter/material.dart';
import 'package:sos_app/Data/Models/SupportModel.dart';
import '../Styles/colors.dart';
import '../Styles/fonts.dart';

class AdminSupportScreen extends StatefulWidget {
  const AdminSupportScreen({super.key});

  @override
  State<AdminSupportScreen> createState() => _AdminSupportScreenState();
}

List<Support> supports = [];
bool flag = false;

class _AdminSupportScreenState extends State<AdminSupportScreen> {
  _getSupports() async {
    supports = await GetSupports();
    flag = true;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _getSupports();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: adminback,
        appBar: AppBar(
          backgroundColor: black,
          centerTitle: true,
          toolbarHeight: 64.5,
          title: const Text("Support",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
        ),
        body: flag != false
            ? supports.length != 0
                ? SingleChildScrollView(
                    child: Padding(
                        padding: const EdgeInsets.fromLTRB(5.0, 8.0, 5.0, 8.0),
                        child: Column(children: [
                          for (var i = 0; i < supports.length; i++)
                            Card(
                                margin: const EdgeInsets.all(15),
                                elevation: 7,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                color: admincard,
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            const Text('Username:',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Text('  ${supports[i].username}',
                                                style: const TextStyle(
                                                    fontSize: 16)),
                                          ],
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              showDialog(
                                                useSafeArea: false,
                                                context: context,
                                                barrierColor: splashBack,
                                                builder: (ctx) => AlertDialog(
                                                  content: const Text(
                                                      "Are you sure, you want to delete this support message?",
                                                      style: TextStyle(
                                                        fontSize: contentFont,
                                                      )),
                                                  actions: [
                                                    Row(
                                                      children: [
                                                        //btn cancel
                                                        Expanded(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child:
                                                                OutlinedButton(
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    ctx);
                                                              },
                                                              child: const Text(
                                                                "Cancel",
                                                                style:
                                                                    TextStyle(
                                                                  color: black,
                                                                  fontSize:
                                                                      contentFont,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),

                                                        Expanded(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child:
                                                                MaterialButton(
                                                              elevation: 6.0,
                                                              color: Colors
                                                                  .redAccent,
                                                              onPressed:
                                                                  () async {
                                                                var result =
                                                                    await DeleteSupport(
                                                                        supports[i]
                                                                            .supportId,
                                                                        context);
                                                                if (result ==
                                                                    "deleted") {
                                                                  _getSupports();
                                                                }
                                                              },
                                                              child: const Text(
                                                                'Sure',
                                                                style:
                                                                    TextStyle(
                                                                  color: white,
                                                                  fontSize:
                                                                      contentFont,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
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
                                            icon: const Icon(Icons.delete)),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Text('Email:',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold)),
                                        Text('  ${supports[i].userEmail}',
                                            style:
                                                const TextStyle(fontSize: 16)),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      margin: const EdgeInsets.all(5.0),
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0)),
                                        color: white,
                                      ),
                                      child: Container(
                                        margin: const EdgeInsets.all(7.0),
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          supports[i].message,
                                          style: const TextStyle(
                                            fontSize: 16.0,
                                            letterSpacing: 0.5,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ]),
                                ))
                        ])))
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        const Padding(
                            padding: EdgeInsets.fromLTRB(25, 2, 25, 5)),
                        const Icon(
                          Icons.warning_amber_rounded,
                          size: 100,
                          color: black,
                        ),
                        SizedBox(
                          height: size.height / 40,
                        ),
                        const Text(
                          'There is no Messages',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: black),
                        ),
                      ],
                    ),
                  )
            : const Center(
                child: CircularProgressIndicator(),
              ));
  }
}
