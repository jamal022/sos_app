import 'package:flutter/material.dart';
import 'package:sos_app/Data/Authentication/login.dart';
import 'package:sos_app/Presentation/Screens/App_Layout/bottom_nav_bar.dart';
import 'package:sos_app/Presentation/Styles/colors.dart';
import 'package:sos_app/Presentation/Styles/fonts.dart';
import 'package:sos_app/Presentation/Widgets/textFormField_widget.dart';
import '../../../Data/Models/patient.dart';
import '../../Constants/app_assets.dart';
import '../../Screens/Settings/settings_screen.dart';
import '../../Widgets/upoladPhoto_widget.dart';

class PatientEditScreen extends StatefulWidget {
  Patient patient;
  PatientEditScreen({Key? key, required this.patient}) : super(key: key);

  @override
  State<PatientEditScreen> createState() => _PatientEditScreen();
}

var nameController = TextEditingController();
var emailController = TextEditingController();
var passwordController = TextEditingController();
var ageController = TextEditingController();
var phoneController = TextEditingController();
var confirmPasswordController = TextEditingController();
GlobalKey<FormState> formKey = GlobalKey<FormState>();
var userImage;

String? passwordMatching(String password, String confirmPassword) {
  if (password == confirmPassword) {
    return null;
  } else {
    return 'The password must match the confirm password';
  }
}

class _PatientEditScreen extends State<PatientEditScreen> {
  @override
  void initState() {
    super.initState();
    nameController.text = widget.patient.username;
    emailController.text = widget.patient.email;
    passwordController.text = widget.patient.password;
    confirmPasswordController.text = widget.patient.password;
    ageController.text = widget.patient.age;
    phoneController.text = widget.patient.phoneNumber;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Edit Profile",
            style:
                TextStyle(fontWeight: FontWeight.bold, fontSize: formTitleFont),
          ),
          centerTitle: true,
          toolbarHeight: 60.2,
          elevation: 5.00,
          backgroundColor: primaryColor,
        ),
        body: Container(
            height: double.infinity,
            color: back,
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 30),
                    TextFormFieldWidget(
                      hintText: 'Patient Name',
                      icon: Icons.person_rounded,
                      type: TextInputType.name,
                      textController: nameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'You must fill the full name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormFieldWidget(
                      hintText: 'PatientEmail@gmail.com',
                      icon: Icons.email,
                      type: TextInputType.emailAddress,
                      textController: emailController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'You must fill the email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormFieldWidget(
                      hintText: '**',
                      icon: Icons.lock,
                      type: TextInputType.visiblePassword,
                      textController: passwordController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'You must fill the password';
                        }
                        if (value.length < 6) {
                          return 'The password must be greater than 6 characters';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormFieldWidget(
                      hintText: '**',
                      icon: Icons.lock,
                      type: TextInputType.visiblePassword,
                      textController: confirmPasswordController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'You must fill the confirm password';
                        }
                        if (value.length < 6) {
                          return 'The password must be greater than 6 characters';
                        }
                        return passwordMatching(passwordController.text,
                            confirmPasswordController.text);
                        ;
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormFieldWidget(
                      hintText: 'Age',
                      icon: Icons.numbers,
                      type: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'You must fill the age';
                        }
                        return null;
                      },
                      textController: ageController,
                    ),
                    const SizedBox(height: 10),
                    TextFormFieldWidget(
                      hintText: '01234567891',
                      icon: Icons.phone,
                      type: TextInputType.phone,
                      textController: phoneController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'You must fill the phone number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    //upload image
                    //const SizedBox(height: 10),
                    //const UploadPhotoWidget(text: 'Upload Image'),
                    const SizedBox(height: 30),
                    MaterialButton(
                        elevation: 5.0,
                        color: primaryColor,
                        padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                        shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: BorderSide.none,
                        ),
                        onPressed: () {
                          //userImage = await addImage();
                          Patient pat = Patient(
                              username: nameController.text,
                              email: emailController.text,
                              phoneNumber: phoneController.text,
                              password: passwordController.text,
                              age: ageController.text,
                              gender: widget.patient.gender,
                              image: widget.patient.image);

                          pat.Update_Patient(pat, formKey);

                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          'Update',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: formButtonFont,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                    const SizedBox(
                      height: 50,
                    )
                  ],
                ),
              ),
            )));
  }
}
