import 'package:flutter/material.dart';
import 'package:sos_app/Presentation/Styles/colors.dart';
import 'package:sos_app/Presentation/Styles/fonts.dart';
import 'package:sos_app/Presentation/Widgets/textFormField_widget.dart';
import '../../Constants/app_assets.dart';
import '../../Widgets/upoladPhoto_widget.dart';

class DoctorEditScreen extends StatefulWidget {
  const DoctorEditScreen({Key? key}) : super(key: key);

  @override
  State<DoctorEditScreen> createState() => _DoctorEditScreen();
}

class _DoctorEditScreen extends State<DoctorEditScreen> {
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
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          color: back,
          child: Column(
            children: <Widget>[
              const SizedBox(height: 30),
              TextFormFieldWidget(
                hintText: 'Doctor Name',
                icon: Icons.person_rounded,
                type: TextInputType.name,
              ),
              const SizedBox(height: 10),
              TextFormFieldWidget(
                hintText: 'DoctorEmail@gmail.com',
                icon: Icons.email,
                type: TextInputType.emailAddress,
              ),
              const SizedBox(height: 10),
              TextFormFieldWidget(
                hintText: '**',
                icon: Icons.lock,
                type: TextInputType.visiblePassword,
              ),
              const SizedBox(height: 10),
              TextFormFieldWidget(
                hintText: '**',
                icon: Icons.lock,
                type: TextInputType.visiblePassword,
              ),
              const SizedBox(height: 10),
              TextFormFieldWidget(
                hintText: 'Age',
                icon: Icons.numbers,
                type: TextInputType.number,
              ),
              const SizedBox(height: 10),
              TextFormFieldWidget(
                hintText: '012345678912',
                icon: Icons.phone,
                type: TextInputType.phone,
              ),
              const SizedBox(height: 10),
              TextFormFieldWidget(
                hintText: 'Doctor Field',
                icon: Icons.pages,
                type: TextInputType.name,
              ),
              const SizedBox(height: 10),
              TextFormFieldWidget(
                hintText: 'Ticket Price',
                icon: Icons.price_change_outlined,
                type: TextInputType.number,
              ),
              const SizedBox(height: 10),
              TextFormFieldWidget(
                hintText: 'Years of Experience',
                icon: Icons.numbers_outlined,
                type: TextInputType.number,
              ),
              const SizedBox(height: 10),
              TextFormFieldWidget(
                hintText: 'Address',
                icon: Icons.home,
                type: TextInputType.name,
              ),
              //upload image
              const SizedBox(height: 10),
              const UploadPhotoWidget(text: 'Upload Image'),
              const SizedBox(height: 40),
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
                height: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}
