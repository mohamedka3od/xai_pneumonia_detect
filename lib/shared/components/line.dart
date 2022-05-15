import 'package:flutter/material.dart';

Widget hDivider(BuildContext context ) => Padding(
  padding: const EdgeInsetsDirectional.all(16),
  child: Center(
    child: Container(
      width: (MediaQuery.of(context).size.width/3)-5,
      height: 1,
      color: Colors.grey,
    ),
  ),
);

Widget wDivider( ) => Padding(
  padding: const EdgeInsetsDirectional.only(
    start: 20,
  ),
  child: Container(
    width: 1,
    height: 50,
    color: Colors.grey,
  ),
);