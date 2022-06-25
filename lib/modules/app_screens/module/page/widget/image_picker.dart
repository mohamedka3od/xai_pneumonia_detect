import 'dart:io';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';

class ProfileImgPicker extends StatefulWidget {
  final File? image;

  const ProfileImgPicker({Key? key, this.image}) : super(key: key);

  @override
  State<ProfileImgPicker> createState() => _ProfileImgPickerState();
}

class _ProfileImgPickerState extends State<ProfileImgPicker> {
  late File img;
  File? image = const ProfileImgPicker().image;

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() => this.image = imageTemporary);
    } on PlatformException catch (e) {
      print('failed:$e');
    }
  }

  Future getImage() async {
    setState(() {
      img = File(image!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
      return Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
                   CircularProfileAvatar(
                     '',
                     child:image != null
                         ?Image.file(image!, fit: BoxFit.cover,):  Icon(Icons.add_a_photo_outlined,color: HexColor('#0000FF'),size: 50,),
                      radius: 50,
                      backgroundColor: Colors.white,
                      borderWidth: 5,
                      borderColor: Colors.blue,
                      elevation: 5.0,
                      foregroundColor: Colors.blue,
                      cacheImage: true,
                      imageFit: BoxFit.cover,
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) => SimpleDialog(
                              title: const Text('Pick From'),
                              children: <Widget>[
                                SimpleDialogOption(
                                  onPressed: () {
                                    pickImage(ImageSource.gallery);
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Gallery'),
                                ),
                                SimpleDialogOption(
                                  onPressed: () {
                                    pickImage(ImageSource.camera);
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Camera'),
                                ),
                              ],
                            ));
                      },
                      // sets on tap
                      showInitialTextAbovePicture: false, 
                    ),
            ],
          ),
        ),
      );
  }
}
