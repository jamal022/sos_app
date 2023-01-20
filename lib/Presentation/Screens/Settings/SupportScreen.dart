import 'package:flutter/material.dart';
import 'package:sos_app/Presentation/Screens/SignUp/signup_screen.dart';
import 'package:sos_app/Presentation/Styles/colors.dart';
import 'package:sos_app/Presentation/Styles/fonts.dart';
import 'package:sos_app/Presentation/Widgets/textFormField_widget.dart';
import '../../Constants/app_assets.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({Key? key}) : super(key: key);

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          elevation: 0,
          centerTitle: true,
          toolbarHeight: 64.5,
          title: const Text(
            "Support",
            style: (TextStyle(
              fontSize: titleInfoFont,
              fontWeight: FontWeight.bold,
              color: white,
            )),
          ),
          leading: IconButton(
            onPressed: () {
              return Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_rounded,
                color: white, size: 30),
          ),
        ),
        body: Container(
            color: back,
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      child: TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Name',
                      prefixIcon: const Icon(Icons.people),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(
                          color: Colors.black12,
                        ),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(
                          color: Colors.black12,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(
                          color: Colors.black12,
                        ),
                      ),
                    ),
                  )),
                  const SizedBox(height: 30),
                  Container(
                      child: TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Email',
                      prefixIcon: const Icon(Icons.email),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(
                          color: Colors.black12,
                        ),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(
                          color: Colors.black12,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(
                          color: Colors.black12,
                        ),
                      ),
                    ),
                  )),
                  const SizedBox(height: 30),
                  Container(
                      width: 320,
                      color: Colors.white,
                      height: 150,
                      child: Column(children: <Widget>[
                        TextField(
                          minLines: 1,
                          maxLines: 8,
                          decoration: const InputDecoration(
                              hintText: 'What\'s making you unhappy?',
                              contentPadding: EdgeInsets.all(15),
                              border: InputBorder.none),
                          onChanged: (value) {},
                        ),
                      ])),
                  const SizedBox(height: 40),
                  Container(
                    child: MaterialButton(
                        elevation: 5.0,
                        color: primaryColor,
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 35),
                        shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: BorderSide.none,
                        ),
                        onPressed: () {},
                        child: const Text(
                          'Submit',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: contentFont,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                  )
                ])));

    //Scaffold
  }
}
