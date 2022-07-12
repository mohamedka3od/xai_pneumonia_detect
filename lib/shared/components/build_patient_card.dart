import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:xai_pneumonia_detect/models/patient_model.dart';
import 'package:xai_pneumonia_detect/modules/app_screens/module/page/patient_info.dart';
import 'package:xai_pneumonia_detect/shared/app_cubit/cubit.dart';
import 'package:xai_pneumonia_detect/shared/components/components.dart';
Widget buildPatientCard({required BuildContext context ,required PatientModel model}) {
  var cubit = AppCubit.get(context);
  return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Material(
        color: Colors.white,
        elevation: 5,
        borderRadius:BorderRadius.circular(70),
        child: InkWell(
          splashColor: Colors.blue.withOpacity(.5),
          borderRadius: BorderRadius.circular(70),
          onTap: (){
            AppCubit.get(context).addPatientData(week: 1, pid: model.id);
            navigateTo(context, PatientInfo(patient: model));
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(70),
            ),
            height:60,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children:  [
                  CircularProfileAvatar('',backgroundColor: Colors.blue,radius: 24,imageFit: BoxFit.cover ,cacheImage: true,child:model.imageUrl!.isEmpty?const Icon(Icons.person,size: 40,color:Colors.white,): Image(fit: BoxFit.fill, image: NetworkImage(model.imageUrl!,)) ,),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           Text(
                            model.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                height: 1,
                                fontSize: 18
                            ),

                          ),
                          Expanded(
                            child: Row(
                              children: const [
                                Text("Pneumonia",style:TextStyle(height: .5,),),
                                SizedBox(
                                  width: 2,
                                ),
                                Icon(Icons.circle,color: Colors.red,size: 10,),
                              ],
                            ),
                          ),
                           Text(model.date,style: const TextStyle(height: .5,color: Colors.grey),),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Center(
                    child: PopupMenuButton<String>(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      onSelected: (val){},
                      icon: const Icon(Icons.more_horiz_rounded ,size: 35,color: Colors.blue,),
                      itemBuilder: (context){
                        return[
                          PopupMenuItem(
                              padding: const EdgeInsets.only(right: 5, left: 20),
                              onTap: (){
                                cubit.changeImportantState(model);
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(
                                    SnackBar(
                                        content: model.important? const Text('removed from important'):const Text('added to important'),
                                      backgroundColor: Colors.blue,
                                    )
                                );

                              },
                              value: 'important',
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children:  [
                                      const Expanded(
                                        child: Text(
                                          'Important',
                                          style: TextStyle(
                                              color: Colors.blue,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Icon(
                                        model.important?Icons.check_box_rounded:Icons.check_box_outline_blank_outlined,
                                        size: 20,
                                        color: Colors.blue,
                                      ),

                                    ],
                                  ),
                                  const Divider()
                                ],
                              )),
                          PopupMenuItem(
                              padding: const EdgeInsets.only(right: 5, left: 20),
                              onTap: (){
                                cubit.deletePatient(pId: model.id);
                                ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(content: Text('patient deleted'),backgroundColor: Colors.blue,));

                              },
                              value: 'delete',
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children:  const [
                                      Expanded(
                                        child: Text(
                                          'Delete',
                                          style: TextStyle(
                                              color: Colors.blue,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Icon(
                                        Icons.delete,
                                        size: 20,
                                        color: Colors.blue,
                                      ),

                                    ],
                                  ),
                                  const Divider()
                                ],
                              )),

                        ];
                      },

                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
}

Widget buildPatientInfoCard({required BuildContext context ,required PatientInfoModel model})=>
    Padding(
      padding: const EdgeInsets.only(top: 8.0,bottom: 0.8),
      child: Material(
        color: Colors.white,
        elevation: 5,
        borderRadius:BorderRadius.circular(70),
        child: InkWell(
          splashColor: Colors.blue.withOpacity(.5),
          borderRadius: BorderRadius.circular(70),
          onTap: (){
            //navigateTo(context, PatientInfo(patient: model));
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(70),
            ),
            height:60,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children:  [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Week: ${model.week}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          height: 1,
                          fontSize: 18
                      ),

                    ),
                  ),
                  const SizedBox(
                    width: 5.0,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Row(
                              children: const [
                                Text("not available yet",style:TextStyle(height: 1.2,),),
                                SizedBox(
                                  width: 2,
                                ),
                               Icon(Icons.circle,color: Colors.green,size: 10,),
                              ],
                            ),
                          ),
                          Text(model.date,style: const TextStyle(height:0,color: Colors.grey),),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  TextButton(onPressed: (){},
                      child:const Text(
                        '...',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 30,
                            height: 1
                        ),))
                ],
              ),
            ),
          ),
        ),
      ),
    );