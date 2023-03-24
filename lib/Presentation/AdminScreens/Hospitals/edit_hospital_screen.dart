import 'dart:math';
import 'dart:io';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sos_app/Presentation/Styles/colors.dart';
import 'package:sos_app/Presentation/Styles/fonts.dart';
import '../../../Data/Models/HospitalModel.dart';
import '../../Widgets/admin_textFormField_widget.dart';

class EditHospitalScreen extends StatefulWidget {
  Hospital hospital;
  EditHospitalScreen({Key? key, required this.hospital}) : super(key: key);

  @override
  State<EditHospitalScreen> createState() => _EditHospitalScreen();
}

XFile? image;
final ImagePicker picker = ImagePicker();
Reference? ref;
File? file;
String? imageurl;
var hospitalImage;

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
var tele1Controller = TextEditingController();
var tele2Controller = TextEditingController();
var ambulanceController = TextEditingController();

GlobalKey<FormState> formKey = GlobalKey<FormState>();

class _EditHospitalScreen extends State<EditHospitalScreen> {
  @override
  void initState() {
    super.initState();
    nameController.text = widget.hospital.name;
    emailController.text = widget.hospital.email;
    tele1Controller.text = widget.hospital.telephone1;
    tele2Controller.text = widget.hospital.telephone2;
    ambulanceController.text = widget.hospital.ambulancePhone;
  }

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
            "Choose Hospital Image",
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
                  color: black,
                  size: 25,
                ),
                label: const Text(
                  "Camera",
                  style: TextStyle(color: black, fontSize: 22),
                ),
              ),
              TextButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                  _getImage(ImageSource.gallery);
                },
                icon: const Icon(
                  Icons.image,
                  color: black,
                  size: 25,
                ),
                label: const Text(
                  "Gallery",
                  style: TextStyle(color: black, fontSize: 22),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: adminback,
      appBar: AppBar(
        title: const Text(
          "Edit Hospital",
          style:
              TextStyle(fontWeight: FontWeight.bold, fontSize: formTitleFont),
        ),
        centerTitle: true,
        toolbarHeight: 60.2,
        elevation: 5.00,
        backgroundColor: black,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
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
                        ? NetworkImage(widget.hospital.image)
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
              AdminTextFormField(
                hintText: 'Hospital Name',
                icon: Icons.person_rounded,
                type: TextInputType.name,
                textController: nameController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'You must fill the name';
                  }
                  if (value.length > 20) {
                    return 'Must be less than 20 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              AdminTextFormField(
                hintText: 'Hospital Email',
                icon: Icons.email,
                type: TextInputType.emailAddress,
                textController: emailController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'You must fill the email ';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 10),
              AdminTextFormField(
                hintText: 'Telephone 1',
                icon: Icons.phone,
                type: TextInputType.phone,
                textController: tele1Controller,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'You must fill the telephone 1';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 10),
              AdminTextFormField(
                hintText: 'Telephone 2',
                icon: Icons.phone,
                type: TextInputType.phone,
                textController: tele2Controller,
                validator: (value) {},
              ),
              const SizedBox(height: 10),
              AdminTextFormField(
                hintText: 'Ambulance Phone',
                icon: Icons.emergency,
                type: TextInputType.phone,
                textController: ambulanceController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'You must fill the ambulance phone';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 30),
              MaterialButton(
                  elevation: 5.0,
                  color: black,
                  padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                  shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide.none,
                  ),
                  onPressed: () async {
                    if (image != null) {
                      hospitalImage = await _addImage();
                      Hospital hos = Hospital(
                          hospitalId: widget.hospital.hospitalId,
                          name: nameController.text,
                          email: emailController.text,
                          telephone1: tele1Controller.text,
                          telephone2: tele2Controller.text,
                          ambulancePhone: ambulanceController.text,
                          image: hospitalImage);

                      await UpdateHospital(hos, formKey, context);
                    } else {
                      Hospital hos = Hospital(
                        hospitalId: widget.hospital.hospitalId,
                        name: nameController.text,
                        email: emailController.text,
                        telephone1: tele1Controller.text,
                        telephone2: tele2Controller.text,
                        ambulancePhone: ambulanceController.text,
                        image: widget.hospital.image,
                      );

                      await UpdateHospital(hos, formKey, context);
                    }
                  },
                  child: const Text(
                    'Save Changes',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: formButtonFont,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
              const SizedBox(
                height: 40,
              )
            ],
          ),
        ),
      ),
    );
  }
}
