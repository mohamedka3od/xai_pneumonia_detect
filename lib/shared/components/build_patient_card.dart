import 'package:flutter/material.dart';
import 'package:xai_pneumonia_detect/models/patient_model.dart';
import 'package:xai_pneumonia_detect/modules/app_screens/module/page/patient_info.dart';
import 'package:xai_pneumonia_detect/shared/app_cubit/cubit.dart';
import 'package:xai_pneumonia_detect/shared/components/components.dart';

Widget buildPatientCard({required BuildContext context ,required PatientModel model})=>
    Padding(
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
                  const CircleAvatar(
                    radius: 24,
                    child: Center(child: Icon(Icons.person, color: Colors.white,size: 40,)),
                    backgroundColor: Colors.black,
                  ),
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