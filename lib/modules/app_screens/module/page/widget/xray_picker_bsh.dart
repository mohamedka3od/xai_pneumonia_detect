import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../../../../shared/style/colors.dart';
import '../examination_result.dart';

class XRayImgPicker extends StatefulWidget {
  final File? image;

  const XRayImgPicker({Key? key, this.image}) : super(key: key);

  @override
  State<XRayImgPicker> createState() => _XRayImgPickerState();
}

class _XRayImgPickerState extends State<XRayImgPicker> {
  final RoundedLoadingButtonController _btnController =
  RoundedLoadingButtonController();
  late File img;
  File? image = const XRayImgPicker().image;
  String message = '';
  String predict = '';
  String rate = '';
  Uint8List? bytesImage;
  bool isLoading = false;
  bool ishere = false;
  late bool isnow;
  http.Response? response;
  onUploadImage(File? selectedImage) async {
    print(selectedImage!);
    final request = http.MultipartRequest(
      'POST',
      Uri.parse("http://3236-34-105-102-17.ngrok.io/upload"),
    );

    final headers = {"Content-type": "multipart/form-data"};
    request.files.add(
      http.MultipartFile(
        'image',
        selectedImage.readAsBytes().asStream(),
        selectedImage.lengthSync(),
        filename: selectedImage.path.split('/').last,
      ),
    );

    request.headers.addAll(headers);
    print("request: " + request.toString());
    final res = await request.send();
     response = await http.Response.fromStream(res);

    final rejs = jsonDecode(response!.body);
    message = rejs['image'];
    predict = rejs['predict'];
    rate = rejs['rate'];
    int len = message.length - 1;
    bytesImage = base64.decode(message.substring(2, len));
    ishere == true;
  }

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
            image != null
                ? Padding(
                    padding: const EdgeInsets.all(8),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: HexColor("0000FF"))),
                      width: double.infinity,
                      height: 200,
                      child: Image.file(
                        image!,
                        fit: BoxFit.fill,
                      ),
                    ),
                  )
                : Column(
                    children: [
                      Icon(
                        Icons.add_circle_outline_outlined,
                        color: backGroundColor3,
                        size: 50,
                      ),
                      const Text(
                        'No image Selected',
                      ),
                    ],
                  ),
            Container(
              padding: const EdgeInsets.all(8.0),
              width: 200,
              height: 60,
              child: ElevatedButton(
                onPressed: () {
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
                style: ElevatedButton.styleFrom(
                  primary:backGroundColor3,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                ),
                child: const Text(
                  'Select X-Ray',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ),
            const Divider(
              height: 10,
              thickness: 2,
              indent: 20,
              endIndent: 20,
              color: Colors.black26,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 200,
                height: 60,
                child: RoundedLoadingButton(

                    borderRadius: 5,
                    color: backGroundColor3,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:const  [
                        Text('Examine',
                            style: TextStyle(color: Colors.white)),
                      ],
                    ),
                    controller: _btnController,
                    onPressed: _doSomething),
              ),
            ),
          ],
        ),
      ),
    );
  }
  void _doSomething() async {
     getImage();
     setState(() {
       onUploadImage(img);
     });
     await Future.delayed(const Duration(seconds: 10));
     if (response!.statusCode == 200) {
      Navigator.push(
       context,
       MaterialPageRoute(
           builder: (context) =>
               Result(
                 bytesImage:
                 bytesImage!,
                 rate: rate,
                 predict: predict,))

     );
      _btnController.stop();
     };

  }
}
