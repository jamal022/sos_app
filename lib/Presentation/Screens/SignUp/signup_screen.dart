import 'dart:io';
import 'dart:math';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sos_app/Presentation/Screens/Login/login_screen.dart';
import 'package:sos_app/Presentation/Styles/colors.dart';
import 'package:sos_app/Presentation/Widgets/loading_widget.dart';
import 'package:sos_app/Presentation/Widgets/textFormField_widget.dart';
import '../../../Data/Authentication/signup.dart';
import '../../../Data/Models/patient.dart';
import '../../Styles/fonts.dart';

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

  XFile? _image;
  final ImagePicker _picker = ImagePicker();
  Reference? _ref;
  File? _file;
  String? _imageurl;
  var _userImage;

  _addImage() async {
    if (_picker != null) {
      _file = File(_image!.path);
      var _rand = Random().nextInt(100000);
      var _imagename = "$_rand" + basename(_image!.path);
      _ref = FirebaseStorage.instance.ref("Profiles").child("$_imagename");
      await _ref!.putFile(_file!);
      _imageurl = await _ref!.getDownloadURL();
      _image = null;
      _ref = null;
      _file = null;

      return _imageurl;
    }
  }

  Future _getImage(ImageSource media) async {
    var _img = await _picker.pickImage(source: media);
    setState(() {
      _image = _img;
    });
  }

  Widget bottomSheet(context) {
    return Container(
      height: 150,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          const Text(
            "Choose Profile Photo",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: primaryColor),
          ),
          const SizedBox(
            height: 20,
          ),
          Column(
            children: [
              TextButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                  _getImage(ImageSource.camera);
                },
                icon: const Icon(
                  Icons.camera,
                  color: primaryColor,
                  size: 25,
                ),
                label: const Text(
                  "Camera",
                  style: TextStyle(color: primaryColor, fontSize: 22),
                ),
              ),
              TextButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                  _getImage(ImageSource.gallery);
                },
                icon: const Icon(
                  Icons.image,
                  color: primaryColor,
                  size: 25,
                ),
                label: const Text(
                  "Gallery",
                  style: TextStyle(color: primaryColor, fontSize: 22),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

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
                const SizedBox(height: 20),
                textFieldTitle('Upload Image'),
                Padding(
                  padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
                  child: Row(
                    children: [
                      MaterialButton(
                          elevation: 5.0,
                          color: primaryColor,
                          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                          shape: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          onPressed: () {
                            showModalBottomSheet(
                                context: context,
                                builder: ((context) => bottomSheet(context)));
                          },
                          child: const Text(
                            'Upload Image',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          )),
                      _image != null
                          ? Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.file(
                                  //to show image, you type like this.
                                  File(_image!.path),
                                  fit: BoxFit.cover,
                                  width: 100,
                                  height: 100,
                                ),
                              ),
                            )
                          : const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                "No Image",
                                style: TextStyle(fontSize: 20),
                              ),
                            )
                    ],
                  ),
                ),
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
                    color: primaryColor,
                    padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                    shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide.none,
                    ),
                    onPressed: () async {
                      var formdata = formKey.currentState;
                      if (formdata!.validate()) {
                        formdata.save();
                        if (_image != null) {
                          if (role != null) {
                            showLoading(context);
                            _userImage = await _addImage();
                            Register(
                              username: nameController.text,
                              email: emailController.text,
                              phone: phoneController.text,
                              password: passwordController.text,
                              age: ageController.text,
                              gender: gender,
                              image: _userImage,
                              context: context,
                              role: role,
                            );
                          } else {
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.error,
                              animType: AnimType.rightSlide,
                              headerAnimationLoop: false,
                              title: 'Error',
                              desc: 'You must select the role',
                            ).show();
                          }
                        } else {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.error,
                            animType: AnimType.rightSlide,
                            headerAnimationLoop: false,
                            title: 'Error',
                            desc: 'You must select an image',
                          ).show();
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text("Enter valid values to continue"),
                              behavior: SnackBarBehavior.floating),
                        );
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
