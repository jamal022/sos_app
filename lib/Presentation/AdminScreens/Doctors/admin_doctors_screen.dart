import 'package:flutter/material.dart';
import 'package:sos_app/Data/Models/doctor.dart';
import '../../Styles/colors.dart';
import '../../Styles/fonts.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class AdminDoctorsScreen extends StatefulWidget {
  const AdminDoctorsScreen({Key? key}) : super(key: key);

  @override
  State<AdminDoctorsScreen> createState() => _AdminDoctorsScreenState();
}

List<Doctor> doctors = [];
bool flag = false;

class _AdminDoctorsScreenState extends State<AdminDoctorsScreen> {
  _getDoctors() async {
    doctors = await getDoctorsForAdmin();
    flag = true;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _getDoctors();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: adminback,
        appBar: AppBar(
          title: const Text(
            "\t\Doctors",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
          ),
          centerTitle: true,
          toolbarHeight: 60.2,
          elevation: 4,
          backgroundColor: black,
        ),
        body: flag != false
            ? doctors.length != 0
                ? SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        children: [
                          for (var i = 0; i < doctors.length; i++)
                            Column(
                              children: [
                                Slidable(
                                  endActionPane: ActionPane(
                                    motion: const ScrollMotion(),
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.green,
                                        ),
                                        child: IconButton(
                                          icon: const Icon(Icons.done),
                                          onPressed: (() async {
                                            var result =
                                                await UpdateVerifiedToVerify(
                                                    doctors[i].id,
                                                    doctors[i].token);
                                            if (result == "updated") {
                                              _getDoctors();
                                            }
                                          }),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.redAccent,
                                        ),
                                        child: IconButton(
                                          icon: const Icon(Icons.block),
                                          onPressed: (() async {
                                            var result =
                                                await UpdateVerifiedToBlock(
                                                    doctors[i].id,
                                                    doctors[i].token);
                                            if (result == "updated") {
                                              _getDoctors();
                                            }
                                          }),
                                        ),
                                      ),
                                    ],
                                  ),
                                  child: Card(
                                    elevation: 6,
                                    color: admincard,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: ListTile(
                                      leading: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 5, 0, 5),
                                        child: CircleAvatar(
                                          backgroundImage: NetworkImage(
                                            doctors[i].image,
                                          ),
                                          radius: 40,
                                        ),
                                      ),
                                      title: Padding(
                                        padding: const EdgeInsets.all(0.2),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Column(children: <Widget>[
                                                const Text(
                                                  "Doctor Name:",
                                                  style: TextStyle(
                                                    fontSize: contentFont,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                Text(
                                                  doctors[i].username,
                                                  style: const TextStyle(
                                                    fontSize: contentFont,
                                                    color: Colors.grey,
                                                  ),
                                                )
                                              ]),
                                            ]),
                                      ),
                                      trailing: const Icon(
                                        Icons.navigate_next_outlined,
                                        size: 30,
                                        color: black,
                                      ),
                                      onTap: () {
                                        // Navigator.push(
                                        //     context,
                                        //     MaterialPageRoute(
                                        //       builder: (context) => const DocInfoScreen(),
                                        //     ));
                                      },
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                  )
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
                          'There is no Doctors',
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
