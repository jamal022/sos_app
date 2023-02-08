import 'package:flutter/material.dart';
import 'package:sos_app/Presentation/Styles/colors.dart';
import 'package:sos_app/Presentation/Styles/fonts.dart';
import 'package:sos_app/Presentation/Widgets/textFormField_widget.dart';
import '../../../Data/Models/doctor.dart';

class DoctorEditScreen extends StatefulWidget {
  Doctor doctor;
  DoctorEditScreen({Key? key, required this.doctor}) : super(key: key);

  @override
  State<DoctorEditScreen> createState() => _DoctorEditScreen();
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
        ),
        body: Container(
          height: double.infinity,
          color: back,
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 30),
                  TextFormFieldWidget(
                    hintText: 'Doctor Name',
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
                    hintText: 'DoctorEmail@gmail.com',
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
                    hintText: 'Bio',
                    icon: Icons.home,
                    type: TextInputType.name,
                    textController: bioController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'You must fill the bio';
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
                            bio: bioController.text);

                        await doc.Update_Doctor(doc, formdata, context);
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
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
