import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xai_pneumonia_detect/shared/app_cubit/cubit.dart';
import 'package:xai_pneumonia_detect/shared/app_cubit/states.dart';
import 'package:xai_pneumonia_detect/shared/style/colors.dart';
import '../../../../models/patient_model.dart';

class PatientInfo extends StatelessWidget {
  final PatientModel patient;

   const PatientInfo({Key? key,required this.patient}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {},
      builder: (context , state) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon:  Icon(
                Icons.arrow_back_ios_rounded, color: backGroundColor2,),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: Container(
            color: backGroundColor1,

          ),


        );
      }
    );
  }
}
