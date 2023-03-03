import 'dart:io';
import 'dart:math';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sos_app/Data/Authentication/login.dart';
import 'package:sos_app/Presentation/Styles/colors.dart';
import 'package:sos_app/Presentation/Styles/fonts.dart';
import 'package:sos_app/Presentation/Widgets/loading_widget.dart';
import 'package:sos_app/Presentation/Widgets/textFormField_widget.dart';
import '../../../Data/Models/doctor.dart';

class DoctorEditScreen extends StatefulWidget {
  Doctor doctor;
  DoctorEditScreen({Key? key, required this.doctor}) : super(key: key);

  @override
  State<DoctorEditScreen> createState() => _DoctorEditScreen();
}

XFile? image;
final ImagePicker picker = ImagePicker();
Reference? ref;
File? file;
String? imageurl;
var doctorImage;
_addImage() async {
  if (picker != null) {
    file = File(image!.path);
    var rand = Random().nextInt(100000);
    var imagename = "$rand" + basename(image!.path);
    ref = FirebaseStorage.instance.ref("images").child("$imagename");
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
var fieldController = TextEditingController();
var priceController = TextEditingController();
var experienceController = TextEditingController();
var bioController = TextEditingController();
GlobalKey<FormState> _formKey = GlobalKey<FormState>();

String? passwordMatching(String password, String confirmPassword) {
  if (password == confirmPassword) {
    return null;
  } else {
    return 'The password must match the confirm password';
  }
}

class _DoctorEditScreen extends State<DoctorEditScreen> {
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
    nameController.text = widget.doctor.username;
    emailController.text = widget.doctor.email;
    passwordController.text = widget.doctor.password;
    confirmPasswordController.text = widget.doctor.password;
    ageController.text = widget.doctor.age;
    phoneController.text = widget.doctor.phoneNumber;
    fieldController.text = widget.doctor.field;
    priceController.text = widget.doctor.price;
    experienceController.text = widget.doctor.experience;
    bioController.text = widget.doctor.bio;
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
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
                image = null;
              }),
        ),
        body: Container(
          height: double.infinity,
          color: back,
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 20),
                  Center(
                    child: Stack(children: [
                      CircleAvatar(
                        radius: 80,
                        backgroundImage: image == null
                            ? NetworkImage(widget.doctor.image)
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
                    hintText: 'Doctor Name',
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
                    hintText: '********',
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
                    hintText: '********',
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
                    hintText: '012345678912',
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
                  TextFormFieldWidget(
                    hintText: 'Doctor Field',
                    icon: Icons.pages,
                    type: TextInputType.name,
                    textController: fieldController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'You must fill the field';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormFieldWidget(
                    hintText: 'Ticket Price',
                    icon: Icons.price_change_outlined,
                    type: TextInputType.number,
                    textController: priceController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'You must fill the price';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormFieldWidget(
                    hintText: 'Years of Experience',
                    icon: Icons.numbers_outlined,
                    type: TextInputType.number,
                    textController: experienceController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'You must fill the years of experience';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  TextFormFieldWidget(
                    hintText: "Write a brief about your experience.....",
                    icon: Icons.post_add,
                    type: TextInputType.multiline,
                    textController: bioController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'You must fill the bio';
                      }
                      if (value.length > 200) {
                        return 'Must be less than 200 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 30),
                  MaterialButton(
                      elevation: 5.0,
                      color: primaryColor,
                      padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                      shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide.none,
                      ),
                      onPressed: () async {
                        if (image != null) {
                          showLoading(context);
                          doctorImage = await _addImage();
                          var formdata = _formKey.currentState;
                          Doctor doc = Doctor(
                              id: widget.doctor.id,
                              username: nameController.text,
                              email: emailController.text,
                              phoneNumber: phoneController.text,
                              password: passwordController.text,
                              age: ageController.text,
                              gender: widget.doctor.gender,
                              image: doctorImage,
                              field: fieldController.text,
                              experience: experienceController.text,
                              addressLat: widget.doctor.addressLat,
                              addressLong: widget.doctor.addressLong,
                              price: priceController.text,
                              bio: bioController.text,
                              rate: widget.doctor.rate,
                              verified: widget.doctor.verified);

                          await doc.Update_Doctor(doc, formdata, context);
                          Navigator.pop(context, "refresh");
                        } else {
                          var formdata = _formKey.currentState;
                          Doctor doc = Doctor(
                              id: widget.doctor.id,
                              username: nameController.text,
                              email: emailController.text,
                              phoneNumber: phoneController.text,
                              password: passwordController.text,
                              age: ageController.text,
                              gender: widget.doctor.gender,
                              image: widget.doctor.image,
                              field: fieldController.text,
                              experience: experienceController.text,
                              addressLat: widget.doctor.addressLat,
                              addressLong: widget.doctor.addressLong,
                              price: priceController.text,
                              bio: bioController.text,
                              rate: widget.doctor.rate,
                              verified: widget.doctor.verified);

                          await doc.Update_Doctor(doc, formdata, context);
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
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
