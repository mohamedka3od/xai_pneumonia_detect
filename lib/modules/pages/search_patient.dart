import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xai_pneumonia_detect/shared/app_cubit/cubit.dart';
import 'package:xai_pneumonia_detect/shared/app_cubit/states.dart';
import 'package:xai_pneumonia_detect/shared/components/components.dart';
import 'package:xai_pneumonia_detect/shared/style/colors.dart';

import '../../../../models/patient_model.dart';
import '../../../../shared/components/build_patient_card.dart';

class SearchScreen extends StatelessWidget {
   SearchScreen({Key? key}) : super(key: key);
  final  searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){
          searchController.addListener(() { });
        },
      builder: (context, state){
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios_rounded,
                  color: backGroundColor3,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title:  Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text('Search for patient', style: TextStyle(color: backGroundColor3),),
              ),
            ),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: defaultFormField(
                      controller: searchController,
                      type: TextInputType.text,
                      textInputAction: TextInputAction.search,
                      validate: (val){return null;},
                      label: 'Patient Name',
                      prefix:Icons.search_rounded,
                      onChange: (val){AppCubit.get(context).changeName(val.toString());},
                    borderColor: Colors.black54,
                    isAutofocus: true,
                  ),
                ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: StreamBuilder<List<PatientModel>>(
                    stream: AppCubit.get(context).searchPatients(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        print(snapshot.error);
                        return const Center(child: Text("we got error"));
                      } else if (snapshot.hasData) {
                        final patients = snapshot.data!;
                        if(patients.isEmpty){
                          return  Center(
                              child:Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text("No Such Name",style: TextStyle(fontWeight: FontWeight.bold , fontSize: 18,color: Colors.blueGrey),),
                                ],
                              )
                          );
                        }
                        else{
                          return ListView.builder(
                            // children: patients.map(buildPatientCard).toList(),//listView
                              itemCount: patients.length,
                              itemBuilder: (context,index)=> buildPatientCard(context: context, model: patients[index])
                          );
                        }
                      }
                      else{
                        return const Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
              ),

              ],
            ),
          );
      },
    );
  }
}
