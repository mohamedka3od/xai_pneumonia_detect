import 'package:flutter/material.dart';
import 'custom_advanced_text_field.dart';


class EditText extends StatelessWidget {
  const EditText({Key? key, required this.data}) : super(key: key);
  final String? data;
  @override
  Widget build(BuildContext context) {

    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          AdvanceTextField(
            type: AdvanceTextFieldType.EDIT,
            editLabel: const Icon(
              Icons.edit,
              color: Colors.white,
            ),
            saveLabel: const Icon(
              Icons.check,
              color: Colors.white,
            ),
            text: data!,
            textHint: "None",
            onEditTap: () {},
            onSaveTap: (text) {
             text = data!;
            },
          )
        ],
      );

  }
}