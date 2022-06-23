import 'package:flutter/material.dart';
import 'package:xai_pneumonia_detect/shared/components/navigation_drawer_widget.dart';

class Settings extends StatelessWidget {
  Settings({Key? key}) : super(key: key);
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
        title: const Text('Settings'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: const Center(child:  Text('Settings')),
    );
  }
}
