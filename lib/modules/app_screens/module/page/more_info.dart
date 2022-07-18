import 'package:flutter/material.dart';
import 'package:xai_pneumonia_detect/shared/style/colors.dart';

import '../../../../models/patient_model.dart';
class MoreInfo extends StatelessWidget {
  final PatientModel patient;
  const MoreInfo({Key? key,required this.patient}) : super(key: key);

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
          child: Row(
            children: [
              Text("Name:",style: TextStyle(color: backGroundColor3,fontSize: 16),),
              Text(patient.name),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text("Email:",style: TextStyle(color: backGroundColor3,fontSize: 16),),
              Text(patient.email!.isEmpty?'not available':patient.email!),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text("Phone:",style: TextStyle(color: backGroundColor3,fontSize: 16),),
              Text(patient.phone!.isEmpty?'not available':patient.phone!),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text("Gender:",style: TextStyle(color: backGroundColor3,fontSize: 16),),
              Text(patient.gender!),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text("Age:",style: TextStyle(color: backGroundColor3,fontSize: 16),),
              Text(patient.age.toString()),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text("Doctor's Note:",style: TextStyle(color: backGroundColor3,fontSize: 16),),
              Text(patient.notes!.isEmpty?'not available':patient.notes!),
            ],
          ),
        )
      ],),
    );
  }
}
