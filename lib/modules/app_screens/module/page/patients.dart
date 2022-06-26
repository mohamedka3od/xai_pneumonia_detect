import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:xai_pneumonia_detect/models/patient_model.dart';
import 'package:xai_pneumonia_detect/modules/app_screens/module/page/widget/bottom_appbar_sheet.dart';
import 'package:xai_pneumonia_detect/shared/components/navigation_drawer_widget.dart';
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
              systemOverlayStyle:  SystemUiOverlayStyle(
                // Status bar color
                statusBarColor: HexColor('#0000FF'),

                // Status bar brightness (optional)
                statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
                statusBarBrightness: Brightness.light, // For iOS (dark icons)

              ),
              leading: IconButton(
                icon: const Icon(
                  Icons.menu,
                  color: Colors.white,
                ),
                onPressed: () {
                  _scaffoldKey.currentState!.openDrawer();
                },
              ),
              title: const Text(
                'Patients',
                style: TextStyle(color: Colors.white),
              ),
              centerTitle: true,
              backgroundColor: HexColor('#0000FF'),
            ),
            body: StreamBuilder<List<PatientModel>>(
              stream: cubit.getPatients(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  print(snapshot.error);
                  return const Center(child: Text("we got error"));
                } else if (snapshot.hasData) {
                  final patients = snapshot.data!;
                  return ListView(
                    children: patients.map(buildPatientCard).toList(),
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
