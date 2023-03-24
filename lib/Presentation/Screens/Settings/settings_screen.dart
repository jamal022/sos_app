import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sos_app/Presentation/Constants/constants.dart';
import 'package:sos_app/Presentation/Screens/Settings/aboutus_screen.dart';
import 'package:sos_app/Presentation/Screens/Settings/privacy_screen.dart';
import 'package:sos_app/Presentation/Screens/SignUp/signup_screen.dart';
import 'package:sos_app/Presentation/Styles/colors.dart';
import 'package:sos_app/Presentation/Styles/fonts.dart';
import 'package:sos_app/Presentation/Widgets/textFormField_widget.dart';
import 'package:toggle_list/toggle_list.dart';
import '../../Constants/app_assets.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';

import '../Login/login_screen.dart';
import 'SupportScreen.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    //bool shadowColor = false;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          elevation: 0,
          centerTitle: true,
          toolbarHeight: 64.5,
          title: const Text('Settings',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          automaticallyImplyLeading: false,
        ),
        body: Container(
          color: back,
          child: Column(children: <Widget>[
            SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          SizedBox(height: size.height / 40),
                          //Notification
                          Card(
                              color: white,
                              child: ListTile(
                                  title: const Text(
                                    "Notifications",
                                    style: TextStyle(
                                      fontSize: contentFont,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  onTap: () {},
                                  trailing: SizedBox(
                                    height: size.height / 20,
                                    child: LiteRollingSwitch(
                                      width: size.width / 4,
                                      //initial value
                                      value: true,
                                      textOn: 'On',
                                      textOff: 'Off',
                                      colorOn: primaryColor,
                                      colorOff: bubbles,
                                      iconOn: Icons.done,
                                      iconOff: Icons.alarm_off,
                                      textSize: 16.0,
                                      onChanged: (bool state) {
                                        //Use it to manage the different states
                                        print('The button is $state');
                                      },
                                      onTap: () {},
                                      onDoubleTap: () {},
                                      onSwipe: () {},
                                    ),
                                  ))),
                          //Privacy and Policies
                          SizedBox(height: size.height / 40),
                          Card(
                              color: white,
                              child: ListTile(
                                title: const Text(
                                  "Privacy and Policies",
                                  style: TextStyle(
                                    fontSize: contentFont,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                trailing: const Icon(
                                  Icons.navigate_next_outlined,
                                  size: 30,
                                  color: black,
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const PrivacyScreen(),
                                      ));
                                },
                              )),
                          //About Us
                          SizedBox(height: size.height / 40),
                          Card(
                            color: white,
                            child: ListTile(
                              title: const Text(
                                "About Us",
                                style: TextStyle(
                                  fontSize: contentFont,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              trailing: const Icon(
                                Icons.navigate_next_outlined,
                                size: 30,
                                color: black,
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const AboutUsScreen(),
                                    ));
                              },
                            ),
                          ),
                          //Support
                          SizedBox(height: size.height / 40),
                          Card(
                              color: white,
                              child: ListTile(
                                title: const Text(
                                  "Support",
                                  style: TextStyle(
                                    fontSize: contentFont,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                trailing: const Icon(
                                  Icons.navigate_next_outlined,
                                  size: 30,
                                  color: black,
                                ),
                                onTap: () async {
                                  var name, email;
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  name = prefs.getString("FullName");
                                  email = prefs.getString("Email");
                                  var result = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SupportScreen(
                                          name: name,
                                          email: email,
                                        ),
                                      ));
                                  if (result == "Added") {
                                    AwesomeDialog(
                                      context: context,
                                      dialogType: DialogType.success,
                                      animType: AnimType.rightSlide,
                                      headerAnimationLoop: false,
                                      title: 'Success',
                                      desc: 'Your support message is sent',
                                    ).show();
                                  }
                                },
                              )),

                          //Contact Us
                          SizedBox(height: size.height / 40),
                          ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: ContactUsList.length,
                            itemBuilder: (BuildContext context, int index) {
                              //card of question & answer
                              return Card(
                                color: white,
                                child: ToggleList(
                                  shrinkWrap: true,
                                  toggleAnimationDuration:
                                      const Duration(milliseconds: 400),
                                  scrollPosition: AutoScrollPosition.begin,
                                  children: [
                                    //toggle question
                                    ToggleListItem(
                                        title: Row(children: [
                                          Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Text(
                                              ContactUsList[index].question,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: black,
                                                decoration: TextDecoration.none,
                                                fontSize: contentFont,
                                              ),
                                            ),
                                          ),
                                        ]), //toggle answer
                                        content: Padding(
                                            padding: const EdgeInsets.all(2),
                                            child: Text(
                                              "${ContactUsList[index].answer} ",
                                              style: const TextStyle(
                                                color: black,
                                                decoration: TextDecoration.none,
                                                fontSize: contentFont,
                                              ),
                                            ))),
                                  ],
                                ),
                              );
                            },
                          ),

                          //Log out
                          SizedBox(height: size.height / 40),
                          Card(
                            color: white,
                            child: ListTile(
                              title: const Text(
                                "Log out",
                                style: TextStyle(
                                  fontSize: contentFont,
                                  fontWeight: FontWeight.bold,
                                ),
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
                                              padding:
                                                  const EdgeInsets.all(8.0),
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

                                          //btn sure
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: MaterialButton(
                                                elevation: 6.0,
                                                color: primaryColor,
                                                onPressed: () async {
                                                  SharedPreferences prefs =
                                                      await SharedPreferences
                                                          .getInstance();
                                                  await FirebaseAuth.instance
                                                      .signOut()
                                                      .then((value) {
                                                    prefs.clear();
                                                    Navigator
                                                        .pushAndRemoveUntil(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              LoginScreen()),
                                                      (Route<dynamic> route) =>
                                                          false,
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
                              trailing: const Icon(
                                Icons.logout_outlined,
                                size: 30,
                                color: black,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ]),
            ),
          ]),
        ));
  }
}
