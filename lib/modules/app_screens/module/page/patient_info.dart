import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:xai_pneumonia_detect/modules/app_screens/module/page/widget/xray_picker_bsh.dart';
import 'package:xai_pneumonia_detect/shared/app_cubit/cubit.dart';
import 'package:xai_pneumonia_detect/shared/app_cubit/states.dart';
import 'package:xai_pneumonia_detect/shared/style/colors.dart';
import '../../../../models/patient_model.dart';
import '../../../../shared/components/build_patient_card.dart';

class PatientInfo extends StatelessWidget {
  final PatientModel patient;
  const PatientInfo({Key? key,required this.patient}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String pid = patient.id;
    var week = 1;
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {},
      builder: (context , state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          backgroundColor: backGroundColor1,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon:  Icon(
                Icons.arrow_back_ios_rounded, color: backGroundColor3,),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children:  [
                CircularProfileAvatar('',borderWidth: 3,borderColor: Colors.blue,backgroundColor: backGroundColor3,radius: 50,imageFit: BoxFit.cover ,cacheImage: true,child:patient.imageUrl!.isEmpty?const Icon(Icons.person,size: 40,color:Colors.white,): Image(fit: BoxFit.fill, image: NetworkImage(patient.imageUrl!,)) ,),
                const SizedBox(
                  height:15,
                ),
                Text(
                  patient.name,
                  style:Theme.of(context).textTheme.headline5?.copyWith(
                  color: HexColor('#060606'),
                  fontWeight: FontWeight.w100,
                  fontSize: 26,
                  height: 0,
                ),),
                TextButton(
                    onPressed: (){},
                    child: Text(
                      'more info',
                      style: TextStyle(
                        color: HexColor("#437FF6"),
                        fontWeight: FontWeight.w900,
                        fontSize: 16,
                        height: -1,
                      ),
                    ) ),
                Container(
                  width: double.infinity,
                  alignment: AlignmentDirectional.centerStart,
                  child: Text('X-Rays Results:',
                    style:Theme.of(context).textTheme.headline5?.copyWith(
                    color: HexColor('#060606'),
                    fontWeight: FontWeight.w100,
                    fontSize: 20,
                  ),),
                ),
                Expanded(
                  child: StreamBuilder<List<PatientInfoModel>>(
                    stream: cubit.getPatientData(pid),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        print(snapshot.error);
                        return const Center(child: Text("we got error"));
                      } else if (snapshot.hasData) {
                        final patientData = snapshot.data!;
                        if (patientData.isEmpty) {
                          return Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text("Add X-Ray from button below",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: Colors.blueGrey),),
                                  Icon(Icons.arrow_downward_sharp,
                                    color: Colors.blueGrey, size: 50,),
                                ],
                              )
                          );
                        }
                        else{
                          week = patientData.length+1;
                          return ListView.builder(
                            // children: patients.map(buildPatientCard).toList(),//listView
                              itemCount: patientData.length,
                              itemBuilder: (context, index) =>
                                  buildPatientInfoCard(
                                      context: context, model: patientData[index])
                          );
                        }

                      }
                      else{
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                )


              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: backGroundColor3,
            child: const Icon(
              Icons.add_circle_outline_outlined,
            ),
            onPressed: () {
              showModalBottomSheet(
                  backgroundColor: Colors.white,
                  context: context,
                  isScrollControlled: true,
                  isDismissible: true,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(40),
                      )),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  builder: (BuildContext context) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Text(
                            "Patient's Xray",
                            style: TextStyle(
                                color: backGroundColor3,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        ),

                         XRayImgPicker(pId: pid,week: week,),

                      ],
                    );
                  }
              );
            },
          ),


        );
      }
    );
  }
}
