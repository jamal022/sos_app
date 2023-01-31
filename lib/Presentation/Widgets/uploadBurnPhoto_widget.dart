import 'dart:io';
import 'dart:math';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sos_app/Presentation/PatientScreens/Home/DetectScreens/report_form_screen.dart';
import '../Styles/colors.dart';
import '../Styles/colors.dart';

class UploadBurnPhotoWidget extends StatefulWidget {
  final text;
  const UploadBurnPhotoWidget({super.key, @required this.text});

  @override
  State<UploadBurnPhotoWidget> createState() => _UploadBurnPhotoWidgetState();
}

XFile? image;
final ImagePicker picker = ImagePicker();
Reference? ref;
File? file;
String? imageurl;

addBurnImage() async {
  if (picker != null) {
    file = File(image!.path);
    var rand = Random().nextInt(100000);
    var imagename = "$rand" + basename(image!.path);
    ref = FirebaseStorage.instance.ref("burnPhotos").child("$imagename");
    await ref!.putFile(file!);
    imageurl = await ref!.getDownloadURL();
    image = null;
    ref = null;
    file = null;

    return imageurl;
  }
}

class _UploadBurnPhotoWidgetState extends State<UploadBurnPhotoWidget> {
  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);
    setState(() {
      image = img as XFile?;
    });
  }

  void myAlert(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: const Text('Please choose media to select'),
            content: SizedBox(
              height: MediaQuery.of(context).size.height / 6,
              child: Column(
                children: [
                  MaterialButton(
                    //if user click this button, user can upload image from gallery
                    color: primaryColor,
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.gallery);
                    },
                    child: Row(
                      children: const [
                        Icon(
                          Icons.image,
                          color: white,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'From Gallery',
                          style: TextStyle(color: white),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    //if user click this button. user can upload image from camera
                    color: primaryColor,
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.camera);
                    },
                    child: Row(
                      children: const [
                        Icon(
                          Icons.camera,
                          color: white,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'From Camera',
                          style: TextStyle(color: white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          MaterialButton(
            color: primaryColor,
            onPressed: () {
              myAlert(context);
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Upload Photo',
                style: TextStyle(fontSize: 25),
              ),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          //if image not null show the image
          //if image null show text
          image != null
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(
                          //to show image, you type like this.
                          File(image!.path),
                          fit: BoxFit.cover,
                          width: 300,
                          height: 300,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      MaterialButton(
                        color: primaryColor,
                        elevation: 3.0,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ReportFormScreen(),
                              ));
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Next',
                            style: TextStyle(fontSize: 20, color: white),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : const Text(
                  "No Image",
                  style: TextStyle(fontSize: 20),
                )
        ],
      ),
    );
  }
}
