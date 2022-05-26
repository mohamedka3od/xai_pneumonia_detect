import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:xai_pneumonia_detect/modules/main_screen/module/data/data.dart';
import 'package:xai_pneumonia_detect/shared/components/components.dart';

class Floating_butt extends StatefulWidget {
  const Floating_butt({
    Key? key,
  }) : super(key: key);

  @override
  State<Floating_butt> createState() => _Floating_buttState();
}

class _Floating_buttState extends State<Floating_butt> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final ageController = TextEditingController();
  final phoneController = TextEditingController();
  final genderController = TextEditingController();
  Color color = Colors.grey;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1),
      child: FloatingActionButton(
        backgroundColor: HexColor('#0000FF'),
        child: const Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet<void>(
            context: context,
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(40),
              ),
            ),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            builder: (BuildContext context) {
              return Container(
                  height: MediaQuery.of(context).size.height * 0.75,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 5.0,
                              color: Colors.blue,
                            ),
                          ),
                          width: 100,
                          height: 100,
                          child: CircleAvatar(
                            backgroundImage: AssetImage(Pro_Data().image),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: defaultFormField(
                            controller: nameController,
                            type: TextInputType.name,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'please enter Patient name';
                              }
                              return null;
                            },
                            label: 'Patient Name',
                            prefix: Icons.person),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: defaultFormField(
                            controller: ageController,
                            type: TextInputType.number,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'please enter Patient age';
                              }
                              return null;
                            },
                            label: 'Patient age',
                            prefix: Icons.date_range),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: defaultFormField(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'please enter Patient email address';
                              }
                              return null;
                            },
                            label: 'Patient Email',
                            prefix: Icons.email_outlined),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: defaultFormField(
                            controller: phoneController,
                            type: TextInputType.phone,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'please enter Patient mobile phone';
                              }
                              return null;
                            },
                            label: 'Patient Mobile Phone',
                            prefix: Icons.phone_android_outlined),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: defaultFormField(
                            controller: phoneController,
                            type: TextInputType.phone,
                            validate: (value) {
                              if (value!.isEmpty) {
                                return 'please enter Patient Genger';
                              }
                              return null;
                            },
                            label: 'Patient Gender',
                            prefix: Icons.supervised_user_circle_outlined),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Expanded(
                          child: TextField(
                            style: TextStyle(color: color),
                            decoration: InputDecoration(

                              hintText: 'Note',
                              hintStyle: TextStyle(color: color),
                              prefixIcon: Icon(Icons.info_outline, color: color),
                              filled: true,
                              fillColor: Colors.white12,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(15),bottomRight:  Radius.circular(15)),
                                borderSide:
                                BorderSide(color: color),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide:
                                BorderSide(color: color),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ));
            },
          );
        },
      ),
    );
  }
}

class BotBar extends StatelessWidget {
  const BotBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 5,
      color: HexColor('#0000FF'),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            icon: const Icon(Icons.home, color: Colors.white),
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => const MyXray()),
              //);
            },
          ),
          IconButton(
              icon: const Icon(Icons.upload_rounded, color: Colors.white),
              onPressed: () {})
        ],
      ),
    );
  }
}
