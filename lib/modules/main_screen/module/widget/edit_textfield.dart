import 'package:advance_text_field/advance_text_field.dart';
import 'package:flutter/material.dart';

import '../data/data.dart';


class Edit_Text extends StatelessWidget {
  const Edit_Text({Key? key, required this.data}) : super(key: key);
  final String data;
  @override
  Widget build(BuildContext context) {

    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          AdvanceTextField(
            type: AdvanceTextFieldType.EDIT,
            editLabel: Icon(
              Icons.edit,
              color: Colors.white,
            ),
            saveLabel: Icon(
              Icons.check,
              color: Colors.white,
            ),
            text: data,
            textHint: "None",
            onEditTap: () {},
            onSaveTap: (text) {
             text = data;
            },
          )
        ],
      );

  }
}