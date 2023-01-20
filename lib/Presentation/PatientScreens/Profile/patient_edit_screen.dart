import 'package:flutter/material.dart';
import 'package:sos_app/Presentation/Styles/colors.dart';
import 'package:sos_app/Presentation/Styles/fonts.dart';
import 'package:sos_app/Presentation/Widgets/textFormField_widget.dart';
import '../../Constants/app_assets.dart';
import '../../Widgets/upoladPhoto_widget.dart';

class PatientEditScreen extends StatefulWidget {
  const PatientEditScreen({Key? key}) : super(key: key);

  @override
  State<PatientEditScreen> createState() => _PatientEditScreen();
}

class _PatientEditScreen extends State<PatientEditScreen> {
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
            color: back,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 30),
                  const TextFormFieldWidget(
                    hintText: 'Patient Name',
                    icon: Icons.person_rounded,
                    type: TextInputType.name,
                  ),
                  const SizedBox(height: 10),
                  const TextFormFieldWidget(
                    hintText: 'PatientEmail@gmail.com',
                    icon: Icons.email,
                    type: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 10),
                  const TextFormFieldWidget(
                    hintText: '**',
                    icon: Icons.lock,
                    type: TextInputType.visiblePassword,
                  ),
                  const SizedBox(height: 10),
                  const TextFormFieldWidget(
                    hintText: '**',
                    icon: Icons.lock,
                    type: TextInputType.visiblePassword,
                  ),
                  const SizedBox(height: 10),
                  const TextFormFieldWidget(
                    hintText: 'Age',
                    icon: Icons.numbers,
                    type: TextInputType.number,
                  ),
                  const SizedBox(height: 10),
                  const TextFormFieldWidget(
                    hintText: '012345678912',
                    icon: Icons.phone,
                    type: TextInputType.phone,
                  ),
                  const SizedBox(height: 10),
                  //upload image
                  const SizedBox(height: 10),
                  const UploadPhotoWidget(text: 'Upload Image'),
                  const SizedBox(height: 30),
                  MaterialButton(
                      elevation: 5.0,
                      color: primaryColor,
                      padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                      shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide.none,
                      ),
                      onPressed: () {},
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
            )));
  }
}
