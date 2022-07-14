import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class Result extends StatelessWidget {
  const Result({Key? key,  this.message, this.predict, this.rate}) : super(key: key);
  final String? message;
  final String? predict;
  final String? rate;


  @override
  Widget build(BuildContext context) {
    Uint8List? bytesImage;
    int len = message!.length - 1;
    bytesImage = base64.decode(message!.substring(2, len));
    print(bytesImage.toString());
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: HexColor("0000FF"))),
                      width: double.infinity,
                      height: 200,
                      child: GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FullImage( bytesImage: bytesImage,)
                                    )
                        ) ,
                        child: Hero(
                          tag: "image",
                          child: Image.memory(
                            bytesImage,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "X-Ray Classified as ${predict!}",
                style: TextStyle(
                    color: HexColor("0000FF"),
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class FullImage extends StatelessWidget {
  final Uint8List? bytesImage;
  const FullImage({Key? key, this.bytesImage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child :Hero(
        tag: "fullimage",
        child: InteractiveViewer(
          minScale: 0.1,
          maxScale: 1.6,
          child: Image.memory(
            bytesImage!,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
