

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hexcolor/hexcolor.dart';

import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:xai_pneumonia_detect/modules/app_screens/module/page/widget/image_picker.dart';
import 'package:xai_pneumonia_detect/shared/components/components.dart';


class Floating_butt extends StatefulWidget {
  const Floating_butt({
    Key? key,
  }) : super(key: key);

  @override
  State<Floating_butt> createState() => _Floating_buttState();
}

class _Floating_buttState extends State<Floating_butt> {
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final ageController = TextEditingController();
  final phoneController = TextEditingController();
  final genderController = TextEditingController();
  Color color = Colors.grey;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(1),
        child: FloatingActionButton(
          backgroundColor: HexColor('#0000FF'),
          child: const Icon(Icons.add),
          onPressed: () {
            showModalBottomSheet(
                backgroundColor: Colors.white,
                context: context,
                isScrollControlled: true,
                isDismissible: true,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                  top: Radius.circular(40),
                )),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                builder: (BuildContext context) {
                  return Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            color: HexColor('#0000FF'),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    width: 5.0,
                                    color: Colors.blue,
                                  ),
                                ),
                                width: 110,
                                height: 110,
                                child: const ProfileImgPicker(),
                              ),
                            ),
                          ),
                          CustomScrollView(
                            shrinkWrap: true,
                            slivers: <Widget>[
                              SliverPadding(
                                  padding: EdgeInsets.only(
                                      bottom: MediaQuery.of(context)
                                          .viewInsets
                                          .bottom),
                                  sliver: SliverList(
                                      delegate:
                                          SliverChildListDelegate(<Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: defaultFormField(
                                        borderColor: HexColor('#0000FF'),
                                        iconColor: HexColor('#0080ff'),
                                        labelColor: HexColor('#0080ff'),
                                        controller: nameController,
                                        type: TextInputType.name,
                                        validate: (value) {
                                          if (value!.isEmpty) {
                                            return 'please enter Patient name';
                                          }
                                          return null;
                                        },
                                        label: 'Patient Name',
                                        prefix: Icons.person,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: defaultFormField(
                                          borderColor: HexColor('#0000FF'),
                                          iconColor: HexColor('#0080ff'),
                                          labelColor: HexColor('#0080ff'),
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
                                          borderColor: HexColor('#0000FF'),
                                          iconColor: HexColor('#0080ff'),
                                          labelColor: HexColor('#0080ff'),
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
                                          borderColor: HexColor('#0000FF'),
                                          iconColor: HexColor('#0080ff'),
                                          labelColor: HexColor('#0080ff'),
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
                                          borderColor: HexColor('#0000FF'),
                                          iconColor: HexColor('#0080ff'),
                                          labelColor: HexColor('#0080ff'),
                                          controller: genderController,
                                          type: TextInputType.text,
                                          validate: (value) {
                                            if (value!.isEmpty) {
                                              return 'please enter Patient Genger';
                                            }
                                            return null;
                                          },
                                          label: 'Patient Gender',
                                          prefix: Icons
                                              .supervised_user_circle_outlined),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        top: 8.0,
                                        right: 8.0,
                                        left: 8.0,
                                      ),
                                      child:  SizedBox(
                                        height: 100,
                                        child: TextField(
                                          style: TextStyle(color: color),
                                          decoration: InputDecoration(
                                            hintText: 'Note',
                                            hintStyle: TextStyle(
                                                color: HexColor('#0080ff')),
                                            prefixIcon: Icon(Icons.info_outline,
                                                color: HexColor('#0080ff')),
                                            filled: true,
                                            fillColor: Colors.white12,
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  const BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(15),
                                                      bottomRight:
                                                          Radius.circular(15)),
                                              borderSide: BorderSide(
                                                  color: HexColor('#0000FF')),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              borderSide: BorderSide(
                                                  color: HexColor('#0000FF')),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(bottom: 20),
                                      width: double.infinity,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          MaterialButton(
                                            elevation: 0,
                                            hoverColor: Colors.blue,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: const BorderRadius.only(topLeft: Radius.circular(20),bottomLeft: Radius.circular(20)),
                                                side: BorderSide(color: HexColor('#0000FF'))
                                            ),

                                            onPressed: () {
                                              // Respond to button press
                                            },
                                            child: Text("Add",style: TextStyle(color: HexColor('#0000FF')),),
                                          ),
                                          MaterialButton(
                                            elevation: 0,
                                            hoverElevation: 0,
                                            focusElevation: 0,
                                            highlightElevation: 0,
                                            color: HexColor('#0000FF'),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: const BorderRadius.only(topRight: Radius.circular(20),bottomRight: Radius.circular(20)),
                                                side: BorderSide(color: HexColor('#0000FF'))
                                            ),

                                            onPressed: () {
                                              // Respond to button press
                                            },
                                            child: Text("Cancel",style: TextStyle(color: HexColor('#FFFFFF')),),
                                          ),

                                        ],
                                      ),
                                    )
                                  ])))
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                });
          },
        ));
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
