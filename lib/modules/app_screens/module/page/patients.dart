import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xai_pneumonia_detect/models/patient_model.dart';
import 'package:xai_pneumonia_detect/modules/app_screens/module/page/widget/bottom_appbar_sheet.dart';
import 'package:xai_pneumonia_detect/shared/components/navigation_drawer_widget.dart';
import 'package:xai_pneumonia_detect/shared/style/colors.dart';
import '../../../../shared/app_cubit/cubit.dart';
import '../../../../shared/app_cubit/states.dart';
import '../../../../shared/components/build_patient_card.dart';


class PatientPage extends StatelessWidget {
  PatientPage({Key? key}) : super(key: key);

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
              actions: [
                IconButton(
                  iconSize: 40,
                    onPressed: (){},
                    icon: CircleAvatar(
                    backgroundColor:backGroundColor2,
                        child: const Icon(
                          Icons.search_rounded,
                          color: Colors.white,
                        )
                    )
                )
              ],
              title:  Text(
                'Patients',
                style: TextStyle(color: backGroundColor2),
              ),
              centerTitle: true,
              backgroundColor: Colors.transparent,
            ),
            backgroundColor: backGroundColor1,
            body: StreamBuilder<List<PatientModel>>(
              stream: cubit.getPatients(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  print(snapshot.error);
                  return const Center(child: Text("we got error"));
                } else if (snapshot.hasData) {
                  final patients = snapshot.data!;
                  return ListView.builder(
                    // children: patients.map(buildPatientCard).toList(),
                    itemCount: patients.length,
                    itemBuilder: (context,index)=> buildPatientCard(context: context, model: patients[index])
                  );

                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
            floatingActionButton:  FloatingButt(),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: const BotBar(),
          );
        });
  }
}
