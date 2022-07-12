
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xai_pneumonia_detect/shared/components/navigation_drawer_widget.dart';

import '../../../../models/patient_model.dart';
import '../../../../shared/app_cubit/cubit.dart';
import '../../../../shared/app_cubit/states.dart';
import '../../../../shared/components/build_patient_card.dart';
import '../../../../shared/style/colors.dart';


class ImportantPage extends StatelessWidget {
  ImportantPage({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = AppCubit.get(context);
          return Scaffold(
            key: _scaffoldKey,
            drawer: const NavigationDrawerWidget(),
            appBar: AppBar(
              systemOverlayStyle:  const SystemUiOverlayStyle(
                // Status bar color
                statusBarColor: Colors.blueAccent,
                // Status bar brightness (optional)
                statusBarIconBrightness: Brightness.light, // For Android (dark icons)
                statusBarBrightness: Brightness.light, // For iOS (dark icons)

              ),
              leading: IconButton(
                icon: CircleAvatar(
                  backgroundColor: backGroundColor2,
                  child: const Icon(
                    Icons.menu,
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  _scaffoldKey.currentState!.openDrawer();
                },
              ),
              title:  Text(
                'Important',
                style: TextStyle(color: backGroundColor2),
              ),
              centerTitle: true,
              backgroundColor: Colors.transparent,
            ),
            backgroundColor: backGroundColor1,
            body: Padding(
              padding: const EdgeInsets.all(4.0),
              child: StreamBuilder<List<PatientModel>>(
                stream: cubit.getImportantPatients(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    print(snapshot.error);
                    return const Center(child: Text("we got error"));
                  } else if (snapshot.hasData) {
                    final patients = snapshot.data!;
                    if(patients.isEmpty){
                      return  const Center(
                          child:Text("No Important Patient yet",style: TextStyle(fontWeight: FontWeight.bold , fontSize: 18,color: Colors.blueGrey),)
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
          );
        });
  }
}
