import 'package:flutter/material.dart';

import 'package:xai_pneumonia_detect/shared/components/navigation_drawer_widget.dart';
import 'package:xai_pneumonia_detect/shared/style/colors.dart';


class Settings extends StatefulWidget {
  Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
        title: const Text('Settings', style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: backGroundColor3,
      ),
      body: Container(),
    );
  }
}
