import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:xai_pneumonia_detect/modules/app_screens/module/page/widget/image_picker.dart';
import 'package:xai_pneumonia_detect/shared/components/navigation_drawer_widget.dart';

import '../../../../shared/app_cubit/cubit.dart';
import '../../../../shared/app_cubit/states.dart';
import '../../../../shared/components/components.dart';

class ImportantPage extends StatefulWidget {
  ImportantPage({Key? key}) : super(key: key);

  @override
  State<ImportantPage> createState() => _ImportantPageState();
}

class _ImportantPageState extends State<ImportantPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final nameController = TextEditingController();

  final emailController = TextEditingController();

  final ageController = TextEditingController();

  final phoneController = TextEditingController();

  final genderController = TextEditingController();

  Color color = Colors.grey;

  final formKey = GlobalKey<FormState>();

  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

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
                leading: IconButton(
                  icon: const Icon(
                    Icons.menu,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    _scaffoldKey.currentState!.openDrawer();
                  },
                ),
                title: const Text('Important'),
                centerTitle: true,
                backgroundColor: Colors.green,
              ),
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: RoundedLoadingButton(
                    color: HexColor('#0000FF'),
                    child: const Text('Submit',
                        style: TextStyle(color: Colors.white)),
                    controller: _btnController,
                    onPressed: _doSomething),
              ));
        });
  }

  void _doSomething() async {
    Timer(const Duration(seconds: 3), () {
      _btnController.start();
      navigateAndFinish(context, ImportantPage());
    });
  }
}
