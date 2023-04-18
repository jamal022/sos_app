import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sos_app/Presentation/AdminScreens/Community/admin_community_screens.dart';
import 'package:sos_app/Presentation/AdminScreens/Articles/admin_articles_screen.dart';
import 'package:sos_app/Presentation/AdminScreens/Hospitals/admin_hospitals_screen.dart';
import 'package:sos_app/Presentation/AdminScreens/Doctors/admin_doctors_screen.dart';
import 'package:sos_app/Presentation/AdminScreens/admin_supports_screen.dart';
import 'package:sos_app/Presentation/Views/home_card_widget.dart';
import '../Screens/Login/login_screen.dart';
import '../Styles/colors.dart';
import '../Styles/fonts.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({Key? key}) : super(key: key);

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

List<String> texts = [
  "Community",
  "Hopitals",
  "Doctors",
  "Articles",
];

List<IconData> listIcons = [
  Icons.question_answer_outlined,
  Icons.medical_services_outlined,
  Icons.medical_information_outlined,
  Icons.newspaper_outlined,
];

List<Widget> screens = [
  const AdminCommunityScreen(),
  const AdminHospitalsScreen(),
  const AdminDoctorsScreen(),
  const AdminArticlesScreen(),
];

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Admin',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
          ),
          toolbarHeight: 60.2,
          elevation: 4,
          backgroundColor: black,
        ),
        drawer: Drawer(
          backgroundColor: adminback,
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: black,
                ),
                child: Center(
                    child: Text(
                  'SOS',
                  style: TextStyle(
                      color: adminback,
                      fontSize: 80,
                      fontWeight: FontWeight.bold),
                )),
              ),
              ListTile(
                leading: const Icon(
                  Icons.contact_support_outlined,
                  color: black,
                  size: 35,
                ),
                title: const Text(
                  'Support Messages',
                  style: TextStyle(
                      color: black, fontSize: 20, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AdminSupportScreen()));
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.logout_outlined,
                  color: black,
                  size: 35,
                ),
                title: const Text(
                  'LogOut',
                  style: TextStyle(
                      color: black, fontSize: 20, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    barrierColor: splashBack,
                    builder: (ctx) => AlertDialog(
                      title: const Text("Logout"),
                      content: const Text("Are you sure ?",
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
                                      color: black,
                                      fontSize: contentFont,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            //btn sure
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: MaterialButton(
                                  elevation: 6.0,
                                  color: black,
                                  onPressed: () async {
                                    SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    prefs.clear();
                                    await FirebaseAuth.instance
                                        .signOut()
                                        .then((value) {
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                LoginScreen()),
                                        (Route<dynamic> route) => false,
                                      );
                                    });
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
              ),
            ],
          ),
        ),
        body: Container(
            color: adminback,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(children: [
                GridView.extent(
                  shrinkWrap: true,
                  primary: false,
                  padding:
                      const EdgeInsets.symmetric(vertical: 140, horizontal: 5),
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  maxCrossAxisExtent: 200.0,
                  children: <Widget>[
                    for (int i = 0; i < 4; i++)
                      HomeCardWidget(
                          text: texts[i],
                          cardIcon: listIcons[i],
                          screen: screens[i])
                  ],
                )
              ]),
            )));
  }
}
