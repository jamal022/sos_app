import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sos_app/Presentation/Screens/Login/login_screen.dart';
import 'package:sos_app/Presentation/Styles/colors.dart';
import 'package:sos_app/Presentation/Widgets/loading_widget.dart';
import 'package:sos_app/Presentation/Widgets/textFormField_widget.dart';
import '../../../Data/Authentication/signup.dart';
import '../../../Data/Models/patient.dart';
import '../../Styles/fonts.dart';
import '../../Widgets/upoladPhoto_widget.dart';
import 'doctorSignup_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var ageController = TextEditingController();
  var phoneController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late Patient patient;
  String? gender;
  String? role;
  var userImage;
  String? passwordMatching(String password, String confirmPassword) {
    if (password == confirmPassword) {
      return null;
    } else {
      return 'The password must match the confirm password';
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: primaryColor,
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 10.0),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
            color: containerColor,
          ),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                const SizedBox(height: 15),
                const Text(
                  "Register",
                  style: TextStyle(
                      fontSize: formTitleFont, fontWeight: FontWeight.bold),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(fontSize: 18),
                      children: <TextSpan>[
                        const TextSpan(
                          text: 'Already have an account? ',
                          style: TextStyle(
                              color: Color.fromARGB(255, 212, 137, 24)),
                        ),
                        TextSpan(
                            text: 'Login',
                            style: const TextStyle(
                                color: Color.fromARGB(255, 136, 88, 16)),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreen()),
                                  (Route<dynamic> route) => false,
                                );
                              }),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                textFieldTitle('Full Name'),
                TextFormFieldWidget(
                  hintText: 'Full Name',
                  icon: Icons.person_rounded,
                  type: TextInputType.name,
                  textController: nameController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'You must fill the full name';
                    }
                    if (value.length > 15) {
                      return 'Must be less than 15 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                textFieldTitle('Email'),
                TextFormFieldWidget(
                  hintText: 'email@gmail.com',
                  icon: Icons.email,
                  type: TextInputType.emailAddress,
                  textController: emailController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'You must fill a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                textFieldTitle('Password'),
                TextFormFieldWidget(
                  hintText: '**********',
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
                textFieldTitle('Confirm Password'),
                TextFormFieldWidget(
                  hintText: '**********',
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
                textFieldTitle('Age'),
                TextFormFieldWidget(
                  hintText: 'Age',
                  icon: Icons.numbers,
                  type: TextInputType.number,
                  textController: ageController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'You must fill the age';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                textFieldTitle('Phone Number'),
                TextFormFieldWidget(
                  hintText: '01234567891',
                  icon: Icons.phone,
                  type: TextInputType.phone,
                  textController: phoneController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'You must fill the phone number';
                    }
                    if (value.length < 12 && value.length > 12) {
                      return 'Phone number must be 11 number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                textFieldTitle('Gender'),
                Container(
                  padding: const EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
                  child: RadioListTile(
                    activeColor: primaryColor,
                    title: const Text(
                      "Male",
                      style: TextStyle(
                          color: Colors.black, fontSize: formSubtitleFont),
                    ),
                    value: "male",
                    groupValue: gender,
                    onChanged: (value) {
                      setState(() {
                        gender = value.toString();
                      });
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
                  child: RadioListTile(
                    activeColor: primaryColor,
                    title: const Text(
                      "Female",
                      style: TextStyle(
                          color: Colors.black, fontSize: formSubtitleFont),
                    ),
                    value: "female",
                    groupValue: gender,
                    onChanged: (value) {
                      setState(() {
                        gender = value.toString();
                      });
                    },
                  ),
                ),
                //CheckboxesWidget(text1: 'Male', text2: 'Female'),
                const SizedBox(height: 20),
                textFieldTitle('Upload Image'),
                const UploadPhotoWidget(text: 'Upload Image'),
                const SizedBox(height: 30),
                textFieldTitle('Role'),
                Container(
                  padding: const EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
                  child: RadioListTile(
                    activeColor: primaryColor,
                    title: const Text(
                      "Patient",
                      style: TextStyle(
                          color: Colors.black, fontSize: formSubtitleFont),
                    ),
                    value: "patient",
                    groupValue: role,
                    onChanged: (value) {
                      setState(() {
                        role = value.toString();
                      });
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
                  child: RadioListTile(
                    activeColor: primaryColor,
                    title: const Text(
                      "Doctor",
                      style: TextStyle(
                          color: Colors.black, fontSize: formSubtitleFont),
                    ),
                    value: "doctor",
                    groupValue: role,
                    onChanged: (value) {
                      setState(() {
                        role = value.toString();
                      });
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                MaterialButton(
                    elevation: 5.0,
                    color: const Color.fromARGB(238, 237, 96, 35),
                    padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                    shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide.none,
                    ),
                    onPressed: () async {
                      var formdata = formKey.currentState;
                      if (formdata!.validate()) {
                        formdata.save();
                        showLoading(context);
                        userImage = await addImage();
                        if (role == "patient") {
                          patient = Patient(
                              username: nameController.text,
                              email: emailController.text,
                              phoneNumber: phoneController.text,
                              password: passwordController.text,
                              age: ageController.text,
                              gender: gender,
                              image: userImage);
                          Register(context: context, patient: patient);
                        } else if (role == "doctor") {
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (_) => DoctorSignupScreen(
                                    name: nameController.text,
                                    email: emailController.text,
                                    phone: phoneController.text,
                                    password: passwordController.text,
                                    age: ageController.text,
                                    gender: gender,
                                    image: userImage)),
                            (Route<dynamic> route) => false,
                          );
                        }
                      }
                    },
                    child: const Text(
                      'Register',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                const SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
