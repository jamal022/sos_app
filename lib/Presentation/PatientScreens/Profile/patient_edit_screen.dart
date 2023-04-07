import 'dart:io';
import 'dart:math';
import 'package:date_format/date_format.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sos_app/Presentation/Styles/colors.dart';
import 'package:sos_app/Presentation/Styles/fonts.dart';
import 'package:sos_app/Presentation/Widgets/textFormField_widget.dart';
import '../../../Data/Models/patient.dart';
import '../../Widgets/loading_widget.dart';

class PatientEditScreen extends StatefulWidget {
  Patient patient;
  PatientEditScreen({Key? key, required this.patient}) : super(key: key);

  @override
  State<PatientEditScreen> createState() => _PatientEditScreen();
}

XFile? image;
final ImagePicker picker = ImagePicker();
Reference? ref;
File? file;
String? imageurl;
var patientImage;

_addImage() async {
  if (picker != null) {
    file = File(image!.path);
    var rand = Random().nextInt(100000);
    var imagename = "$rand" + basename(image!.path);
    ref = FirebaseStorage.instance.ref("Profiles").child("$imagename");
    await ref!.putFile(file!);
    imageurl = await ref!.getDownloadURL();
    image = null;
    ref = null;
    file = null;

    return imageurl;
  }
}

var nameController = TextEditingController();
var emailController = TextEditingController();
var passwordController = TextEditingController();
var ageController = TextEditingController();
var phoneController = TextEditingController();
var confirmPasswordController = TextEditingController();
GlobalKey<FormState> formKey = GlobalKey<FormState>();

String? passwordMatching(String password, String confirmPassword) {
  if (password == confirmPassword) {
    return null;
  } else {
    return 'The password must match the confirm password';
  }
}

class _PatientEditScreen extends State<PatientEditScreen> {
  Future _getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);
    setState(() {
      image = img;
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
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                  const SizedBox(height: 20),
                  Center(
                    child: Stack(children: [
                      CircleAvatar(
                        radius: 80,
                        backgroundImage: image == null
                            ? NetworkImage(widget.patient.image)
                            : FileImage(File(image!.path)) as ImageProvider,
                      ),
                      Positioned(
                        bottom: 25,
                        right: 25,
                        child: InkWell(
                          onTap: () {
                            showModalBottomSheet(
                                context: context,
                                builder: ((context) => bottomSheet(context)));
                          },
                          child: const Icon(
                            Icons.camera_alt_rounded,
                            color: white,
                            size: 28,
                          ),
                        ),
                      ),
                    ]),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormFieldWidget(
                    hintText: 'Patient Name',
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
                  TextFormFieldWidget(
                    hintText: '',
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
                    hintText: '',
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
                      if (value.length < 12 && value.length > 12) {
                        return 'Phone number must be 11 number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 40),
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
                          if (image != null) {
                            showLoading(context);
                            DeletePatientProfile(widget.patient.image);
                            patientImage = await _addImage();
                            Patient pat = Patient(
                                id: widget.patient.id,
                                username: nameController.text,
                                email: emailController.text,
                                phoneNumber: phoneController.text,
                                password: passwordController.text,
                                age: ageController.text,
                                gender: widget.patient.gender,
                                image: patientImage);

                            await Update_Patient(
                                pat, widget.patient.password, context);
                          } else {
                            showLoading(context);
                            Patient pat = Patient(
                                id: widget.patient.id,
                                username: nameController.text,
                                email: emailController.text,
                                phoneNumber: phoneController.text,
                                password: passwordController.text,
                                age: ageController.text,
                                gender: widget.patient.gender,
                                image: widget.patient.image);

                            await Update_Patient(
                                pat, widget.patient.password, context);
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
          ),
        ));
  }
}
