import 'package:flutter/material.dart';
import 'package:sos_app/Data/Models/SupportModel.dart';
import 'package:sos_app/Presentation/Styles/colors.dart';
import 'package:sos_app/Presentation/Styles/fonts.dart';

class SupportScreen extends StatefulWidget {
  var name;
  var email;
  SupportScreen({Key? key, required this.name, required this.email})
      : super(key: key);

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

var nameController = TextEditingController();
var emailController = TextEditingController();
var messageController = TextEditingController();

class _SupportScreenState extends State<SupportScreen> {
  @override
  void initState() {
    super.initState();
    nameController.text = widget.name;
    emailController.text = widget.email;
    messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: back,
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
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                  child: TextField(
                controller: nameController,
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
                controller: emailController,
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
                      controller: messageController,
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
                    onPressed: () async {
                      Support support = Support(
                        username: nameController.text,
                        userEmail: emailController.text,
                        message: messageController.text,
                      );
                      var result = await AddSuport(support, context);
                      if (result == "Added") {
                        Navigator.pop(context, "Added");
                      }
                    },
                    child: const Text(
                      'Submit',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: contentFont,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
              )
            ]),
      )),
    );

    //Scaffold
  }
}
