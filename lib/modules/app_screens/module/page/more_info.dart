import 'package:flutter/material.dart';
import 'package:xai_pneumonia_detect/shared/style/colors.dart';
class MoreInfo extends StatelessWidget {
  const MoreInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('More Info',style: TextStyle(color: backGroundColor3),),

      ),
      body: Column(
        crossAxisAlignment:CrossAxisAlignment.start,
        children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Name:",style: TextStyle(color: backGroundColor3,fontSize: 16),),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Email:",style: TextStyle(color: backGroundColor3,fontSize: 16),),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Phone:",style: TextStyle(color: backGroundColor3,fontSize: 16),),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Gender:",style: TextStyle(color: backGroundColor3,fontSize: 16),),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Age:",style: TextStyle(color: backGroundColor3,fontSize: 16),),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Doctor's Note:",style: TextStyle(color: backGroundColor3,fontSize: 16),),
        )
      ],),
    );
  }
}
