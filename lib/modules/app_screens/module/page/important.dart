import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:xai_pneumonia_detect/modules/app_screens/module/page/widget/image_picker.dart';
import 'package:xai_pneumonia_detect/shared/components/navigation_drawer_widget.dart';

import '../../../../shared/app_cubit/cubit.dart';
import '../../../../shared/app_cubit/states.dart';
import '../../../../shared/components/components.dart';

class ImportantPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  ImportantPage({Key? key}) : super(key: key);
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final ageController = TextEditingController();
  final phoneController = TextEditingController();
  final genderController = TextEditingController();
  Color color = Colors.grey;
  final formKey = GlobalKey<FormState>();
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
            body: Center(
              child: Container(
                child:OutlinedButton(
                  onPressed: () { showModalBottomSheet(
                      backgroundColor: Colors.transparent,
                      context: context,
                      isScrollControlled: true,
                      isDismissible: true,
                      builder: (BuildContext context) {
                        return DraggableScrollableSheet(
                            initialChildSize: 0.75, //set this as you want
                            maxChildSize: 0.75, //set this as you want
                            minChildSize: 0.75, //set this as you want
                            expand: true,
                            builder: (context, scrollController) {

                              return Container(
                                color: Colors.white,
                                child: SingleChildScrollView(
                                  child: Column(children: [
                                    Text('aaah'),
                                    Text('aaah'),
                                    Text('aaah'),
                                    Text('aaah'),
                                    Text('aaah'),
                                    Text('aaah'),
                                    Text('aaah'),
                                  ],),
                                ),
                              ); //whatever you're returning, does not have to be a Container
                            }
                        );
                      }
                  ); },
                  child: Text('aaah'),
                ) ,),
            ),
          );
        });
  }
}
