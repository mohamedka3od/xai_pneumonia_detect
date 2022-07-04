import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class Result extends StatelessWidget {
  const Result({Key? key,  this.bytesImage, this.predict, this.rate}) : super(key: key);
  final Uint8List? bytesImage;
  final String? predict;
  final String? rate;


  @override
  Widget build(BuildContext context) {
    print(bytesImage.toString());
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: HexColor("0000FF"))),
                    width: double.infinity,
                    height: 200,
                    child: Image.memory(
                      bytesImage!,
                      fit: BoxFit.fill,
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
    );
  }
}
