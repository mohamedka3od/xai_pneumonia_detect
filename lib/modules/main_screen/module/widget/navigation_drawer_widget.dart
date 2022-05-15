import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:xai_pneumonia_detect/modules/main_screen/main_screen.dart';
import 'package:xai_pneumonia_detect/modules/main_screen/module/page/patients.dart';
import 'package:xai_pneumonia_detect/modules/main_screen/module/page/important.dart';

import 'package:xai_pneumonia_detect/modules/main_screen/module/page/settings.dart';
import 'package:xai_pneumonia_detect/shared/app_cubit/cubit.dart';

import '../../../../network/local/cache_helper.dart';
import '../../../../shared/components/components.dart';
import '../../../login/login_screen.dart';

class NavigationDrawerWidget extends StatelessWidget {
  final padding = const EdgeInsets.symmetric(horizontal: 20);

  const NavigationDrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final name = 'Monkey D Luffy';
    final email = 'MonkeyDG4@oneP.com';
    final urlImage =
        'https://image.winudf.com/v2/image/Y29tLkdoYW54aXMuTW9ua2V5REx1ZmZ5V2FsbHBhcGVySERfc2NyZWVuXzJfMTUyMzg4NTIzNF8wNDg/screen-2.jpg?fakeurl=1&type=.webp';

    return Drawer(
      child: Material(
        color: HexColor('#0000FF'),
        child: ListView(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height / 5,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(50),
                ),
                color: Color.fromRGBO(50, 75, 205, 1),
              ),
              child: buildHeader(
                  urlImage: urlImage,
                  name: name,
                  email: email,
                  onClicked: () => Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => MainScreen()),
                        (Route<dynamic> route) => false,
                      )),
            ),
            Container(
              padding: padding,
              child: Column(
                children: [
                  buildMenuItem(
                    text: 'Patients',
                    icon: Icons.people,
                    onClicked: () => selectedItem(context, 0),
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'Important',
                    icon: Icons.favorite_border,
                    onClicked: () => selectedItem(context, 1),
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'Setting',
                    icon: Icons.workspaces_outline,
                    onClicked: () => selectedItem(context, 2),
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'Updates',
                    icon: Icons.update,
                    onClicked: () => selectedItem(context, 3),
                  ),
                  const SizedBox(height: 24),
                  const Divider(color: Colors.white70),
                  const SizedBox(height: 24),
                  buildMenuItem(
                    text: 'Logout',
                    icon: Icons.account_tree_outlined,
                    onClicked: () => selectedItem(context, 4),
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'About',
                    icon: Icons.notifications_outlined,
                    onClicked: () => selectedItem(context, 5),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildHeader({
    required String urlImage,
    required String name,
    required String email,
    required VoidCallback onClicked,
  }) =>
      InkWell(
        onTap: onClicked,
        child: Container(
          padding: padding.add(const EdgeInsets.symmetric(vertical: 20)),
          child: Row(
            children: [
              CircleAvatar(radius: 30, backgroundImage: NetworkImage(urlImage)),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 120,
                    child: Text(
                      name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    width: 120,
                    child: Text(
                      email,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 14, color: Colors.white),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              const CircleAvatar(
                radius: 24,
                backgroundColor: Color.fromRGBO(30, 60, 168, 1),
                child: Icon(Icons.add_comment_outlined, color: Colors.white),
              )
            ],
          ),
        ),
      );

  // Widget buildSearchField() {
  //   final color = Colors.white;
  //
  //   return TextField(
  //     style: TextStyle(color: color),
  //     decoration: InputDecoration(
  //       contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
  //       hintText: 'Search',
  //       hintStyle: TextStyle(color: color),
  //       prefixIcon: Icon(Icons.search, color: color),
  //       filled: true,
  //       fillColor: Colors.white12,
  //       enabledBorder: OutlineInputBorder(
  //         borderRadius: BorderRadius.circular(5),
  //         borderSide: BorderSide(color: color.withOpacity(0.7)),
  //       ),
  //       focusedBorder: OutlineInputBorder(
  //         borderRadius: BorderRadius.circular(5),
  //         borderSide: BorderSide(color: color.withOpacity(0.7)),
  //       ),
  //     ),
  //   );
  // }

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    const color = Colors.white;
    const hoverColor = Colors.white70;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: const TextStyle(color: color)),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();

    switch (index) {
      case 0:
        navigateAndFinish(context, PatientPage());
        break;
      case 1:
        navigateAndFinish(context, ImportantPage());
        break;
      case 2:
        //setting
        navigateTo(context,  Settings());
        break;
      case 3:
        AppCubit.get(context).addPatient();
        break;
      case 4:
        //LOgout Hereeeeeeee
        CacheHelper.removeData(key: 'token').then((value) {
          if (value) {
            navigateAndFinish(context, LoginScreen());
          }
        });
        break;
      case 5:
        break;
    }
  }
}
