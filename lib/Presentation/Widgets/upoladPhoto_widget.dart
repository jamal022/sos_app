import 'dart:io';
import 'dart:math';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../Styles/colors.dart';

class UploadPhotoWidget extends StatefulWidget {
  final text;
  const UploadPhotoWidget({super.key, @required this.text});

  @override
  State<UploadPhotoWidget> createState() => _UploadPhotoWidgetState();
}

XFile? image;
final ImagePicker picker = ImagePicker();
Reference? ref;
File? file;
String? imageurl;

addImage() async {
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

class _UploadPhotoWidgetState extends State<UploadPhotoWidget> {
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MaterialButton(
          color: primaryColor,
          onPressed: () {
            myAlert(context);
          },
          child: const Text('Upload Photo'),
        ),
        const SizedBox(
          width: 20,
        ),
        //if image not null show the image
        //if image null show text
        image != null
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.file(
                    //to show image, you type like this.
                    File(image!.path),
                    fit: BoxFit.cover,
                    width: 100,
                    height: 100,
                  ),
                ),
              )
            : const Text(
                "No Image",
                style: TextStyle(fontSize: 20),
              )
      ],
    );
  }
}
