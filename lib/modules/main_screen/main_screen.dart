import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:xai_pneumonia_detect/modules/main_screen/module/appbar_form.dart';
import 'package:xai_pneumonia_detect/modules/main_screen/module/data/data.dart';
import 'package:xai_pneumonia_detect/shared/app_cubit/cubit.dart';
import 'package:xai_pneumonia_detect/shared/app_cubit/states.dart';
import 'module/widget/edit_textfield.dart';
import 'module/widget/navigation_drawer_widget.dart';

class MainScreen extends StatelessWidget {
  MainScreen({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final searchController = TextEditingController();
  final _iconSize = 40.0;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
            key: _scaffoldKey,
            drawer: const NavigationDrawerWidget(),
            appBar: CustomAppBar(
              title: 'User Profile',
              childHeight: _iconSize,
              firstIcon: IconButton(
                icon: const Icon(
                  Icons.menu,
                  color: Colors.white,
                ),
                onPressed: () {
                  _scaffoldKey.currentState!.openDrawer();
                },
              ),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 5.0,
                    color: Colors.white,
                  ),
                ),
                child: Container(
                  width: 80,
                  height: 80,

                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                      width: 5.0,
                      color: Colors.blue,
                    ),
                  ),
                  child: CircleAvatar(
                    backgroundImage: AssetImage(Pro_Data().image),
                  ),
                ),
              ),
            ),
            body: Center(
              child: Column(
                children: [
                  Edit_Text(data:Pro_Data().id),
                  SizedBox(height: 15,),
                  Edit_Text(data:Pro_Data().aga.toString()),
                  SizedBox(height: 15,),
                  Edit_Text(data:Pro_Data().email),
                  SizedBox(height: 15,),
                  Edit_Text(data:Pro_Data().mobilenum.toString()),
                ],
              ),
            )
        );
      },
    );
  }
}
