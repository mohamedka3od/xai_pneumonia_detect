import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:xai_pneumonia_detect/modules/app_screens/module/page/widget/image_picker.dart';
import 'package:xai_pneumonia_detect/shared/components/components.dart';

import '../../../../../shared/app_cubit/cubit.dart';
import '../../../../../shared/app_cubit/states.dart';
import '../../../../../shared/style/colors.dart';

class FloatingButt extends StatelessWidget {
  FloatingButt({Key? key}) : super(key: key);

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final ageController = TextEditingController();
  final phoneController = TextEditingController();

  final noteController = TextEditingController();
  final Color color = Colors.grey;
  final formKey = GlobalKey<FormState>();
  final  _cnt = SingleValueDropDownController();

  @override
  Widget build(BuildContext context) {
    String lPId;
    bool condition = true;
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) => {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Padding(
            padding: const EdgeInsets.all(1),
            child: FloatingActionButton(
              backgroundColor: backGroundColor3,
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
                          child: ConditionalBuilder(
                            condition: condition,
                            builder:(context)=> Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Stack(
                                  children: [
                                    Column(
                                      children: [
                                        Container(
                                          height: 76,
                                          width:
                                          MediaQuery.of(context).size.width,
                                          color: backGroundColor3,
                                        ),
                                        Container(
                                          width: double.infinity,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              children: [
                                                Expanded(
                                                  child: MaterialButton(
                                                    elevation: 0,
                                                    hoverColor: Colors.blue,
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                        const BorderRadius
                                                            .only(
                                                            topLeft: Radius
                                                                .circular(20),
                                                            bottomLeft: Radius
                                                                .circular(
                                                                20)),
                                                        side: BorderSide(
                                                            color: HexColor(
                                                                '#0000FF'))),
                                                    onPressed: ()  {
                                                      if (formKey.currentState!
                                                          .validate()){
                                                        condition = false;
                                                        cubit.uploadPatientImage().then((value) {
                                                          cubit.createPatient(
                                                              name:
                                                              nameController.text,
                                                              age: int.parse(
                                                                  ageController.text),
                                                              gender: _cnt
                                                                  .dropDownValue!.value.toString(),
                                                              email: emailController
                                                                  .text,
                                                              phone: phoneController
                                                                  .text,
                                                              notes:
                                                              noteController.text,
                                                              imageUrl: cubit.patientImageUrl
                                                          )
                                                              .then((value) {
                                                            lPId = value.toString();
                                                            condition =true;
                                                            cubit.patientImageUrl='';
                                                            cubit.clearPatientImage();
                                                            Navigator.pop(context);
                                                            // If the form is valid, display a snackbar. In the real world,
                                                            // you'd often call a server or save the information in a database.
                                                            ScaffoldMessenger.of(
                                                                context)
                                                                .showSnackBar(
                                                              SnackBar(
                                                                content: const Text(
                                                                    'Patient Created'),
                                                                action:
                                                                SnackBarAction(
                                                                    label:
                                                                    "undo",
                                                                    onPressed:
                                                                        () {
                                                                      cubit.deletePatient(pId: lPId).then(
                                                                              (value) {
                                                                            showToast(
                                                                                text:
                                                                                'Patient Deleted',
                                                                                state:
                                                                                ToastStates.SUCESS);
                                                                          }).catchError(
                                                                              (error) {
                                                                            showToast(
                                                                                text:
                                                                                error.toString(),
                                                                                state: ToastStates.ERROR);
                                                                          });
                                                                    }),
                                                              ),
                                                            );
                                                          }).catchError((error) {
                                                            showToast(
                                                                text: error
                                                                    .toString(),
                                                                state: ToastStates
                                                                    .ERROR);
                                                          });
                                                        });

                                                      }
                                                    },
                                                    child: Padding(
                                                      padding:
                                                      const EdgeInsets.only(
                                                          right: 40.0),
                                                      child: Text(
                                                        "Add",
                                                        style: TextStyle(
                                                            color: HexColor(
                                                                '#0000FF')),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: MaterialButton(
                                                    elevation: 0,
                                                    hoverElevation: 0,
                                                    focusElevation: 0,
                                                    highlightElevation: 0,
                                                    color: backGroundColor3,
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                        const BorderRadius
                                                            .only(
                                                            topRight: Radius
                                                                .circular(20),
                                                            bottomRight:
                                                            Radius
                                                                .circular(
                                                                20)),
                                                        side: BorderSide(
                                                            color: HexColor(
                                                                '#0000FF'))),
                                                    onPressed: () {
                                                      nameController.clear();
                                                      phoneController.clear();
                                                      emailController.clear();
                                                      ageController.clear();
                                                      _cnt.clearDropDown();
                                                      noteController.clear();
                                                      cubit.clearPatientImage();
                                                      Navigator.pop(context);
                                                    },
                                                    child: Padding(
                                                      padding:
                                                      const EdgeInsets.only(
                                                          left: 40.0),
                                                      child: Text(
                                                        "Cancel",
                                                        style: TextStyle(
                                                            color: HexColor(
                                                                '#FFFFFF')),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        const Text(
                                          "New Patient",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Center(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                right: 8.0, left: 8, bottom: 8),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                  width: 1.0,
                                                  color: HexColor('#0000FF'),
                                                ),
                                              ),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                    width: 5.0,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                width: 110,
                                                height: 110,
                                                child: const ProfileImgPicker(),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
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
                                              Form(
                                                key: formKey,
                                                child: Column(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets.all(8.0),
                                                      child: defaultFormField(
                                                        textInputAction:
                                                        TextInputAction.next,
                                                        elevation: 0,
                                                        borderColor:
                                                        HexColor('#0000FF'),
                                                        iconColor:
                                                        HexColor('#0080ff'),
                                                        labelColor:
                                                        HexColor('#0080ff'),
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
                                                      padding:
                                                      const EdgeInsets.all(8.0),
                                                      child: defaultFormField(
                                                          textInputAction:
                                                          TextInputAction.next,
                                                          elevation: 0,
                                                          borderColor:
                                                          HexColor('#0000FF'),
                                                          iconColor:
                                                          HexColor('#0080ff'),
                                                          labelColor:
                                                          HexColor('#0080ff'),
                                                          controller: ageController,
                                                          type: TextInputType.number,
                                                          validate: (value) {
                                                            if (value!.isEmpty) {
                                                              return 'please enter Patient age';
                                                            } else if (double
                                                                .tryParse(
                                                                value) ==
                                                                null) {
                                                              return 'please enter a valid age';
                                                            }
                                                            return null;
                                                          },
                                                          label: 'Patient age',
                                                          prefix: Icons.date_range),
                                                    ),
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets.all(8.0),
                                                      child: defaultFormField(
                                                          textInputAction:
                                                          TextInputAction.next,
                                                          elevation: 0,
                                                          borderColor:
                                                          HexColor('#0000FF'),
                                                          iconColor:
                                                          HexColor('#0080ff'),
                                                          labelColor:
                                                          HexColor('#0080ff'),
                                                          controller: emailController,
                                                          type: TextInputType
                                                              .emailAddress,
                                                          validate: (value) {
                                                            // if (value!.isEmpty) {
                                                            //   return 'please enter Patient email address';
                                                            // }
                                                            return null;
                                                          },
                                                          label: 'Patient Email',
                                                          prefix:
                                                          Icons.email_outlined),
                                                    ),
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets.all(8.0),
                                                      child: defaultFormField(
                                                          textInputAction:
                                                          TextInputAction.next,
                                                          elevation: 0,
                                                          borderColor:
                                                          HexColor('#0000FF'),
                                                          iconColor:
                                                          HexColor('#0080ff'),
                                                          labelColor:
                                                          HexColor('#0080ff'),
                                                          controller: phoneController,
                                                          type: TextInputType.phone,
                                                          validate: (value) {
                                                            // if (value!.isEmpty) {
                                                            //   return 'please enter Patient mobile phone';
                                                            // }
                                                            return null;
                                                          },
                                                          label:
                                                          'Patient Mobile Phone',
                                                          prefix: Icons
                                                              .phone_android_outlined),
                                                    ),
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets.all(8.0),
                                                      child:  DropDownTextField(
                                                        textFieldDecoration: InputDecoration(
                                                          enabledBorder: OutlineInputBorder(
                                                            borderRadius: BorderRadius.circular(25.0),
                                                            borderSide: BorderSide(
                                                              color: HexColor('#0000FF'),
                                                              width: 2.0,
                                                            ),
                                                          ),
                                                          contentPadding: const EdgeInsets.symmetric(vertical: 5),
                                                          errorStyle: const TextStyle(
                                                            // fontSize: 9,
                                                              height: .5
                                                          ),
                                                          fillColor: Colors.white,
                                                          filled: true,
                                                          border: const OutlineInputBorder(
                                                            borderRadius: BorderRadius.all(Radius.circular(28.0)),
                                                            borderSide: BorderSide(color: Colors.white),
                                                          ),
                                                          // labelText: label,
                                                          hintText: "Patient Gender",

                                                          hintStyle:TextStyle(color: HexColor('#0080ff')),
                                                          prefixIcon: Icon(
                                                            Icons.supervised_user_circle_outlined,
                                                            color:HexColor('#0080ff'),
                                                          ),
                                                        ),
                                                        singleController: _cnt,
                                                        clearOption: false,
                                                        validator: (value) {
                                                          if (value == null) {
                                                            return "Select Gender Please";
                                                          } else {
                                                            return null;
                                                          }
                                                        },
                                                        dropDownItemCount: 2,
                                                        dropDownList: const [
                                                          DropDownValueModel(name: 'Male', value: "Male"),
                                                          DropDownValueModel(name: 'Female', value: "Female"),
                                                        ],
                                                        onChanged: (val) {
                                                          //print(_cnt.dropDownValue!.value);
                                                        },
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(
                                                        top: 8.0,
                                                        right: 8.0,
                                                        left: 8.0,
                                                      ),
                                                      child: SizedBox(
                                                        height: 100,
                                                        child: TextField(
                                                          style:
                                                          TextStyle(color: color),
                                                          decoration: InputDecoration(
                                                            hintText: 'Note',
                                                            hintStyle: TextStyle(
                                                                color: HexColor(
                                                                    '#0080ff')),
                                                            prefixIcon: Icon(
                                                                Icons.info_outline,
                                                                color: HexColor(
                                                                    '#0080ff')),
                                                            filled: true,
                                                            fillColor: Colors.white12,
                                                            enabledBorder:
                                                            OutlineInputBorder(
                                                              borderRadius:
                                                              const BorderRadius
                                                                  .only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                      15),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                      15)),
                                                              borderSide: BorderSide(
                                                                  color: HexColor(
                                                                      '#0000FF')),
                                                            ),
                                                            focusedBorder:
                                                            OutlineInputBorder(
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                              borderSide: BorderSide(
                                                                  color: HexColor(
                                                                      '#0000FF')),
                                                            ),
                                                          ),
                                                          controller: noteController,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ])))
                                  ],
                                ),
                              ],
                            ),
                            fallback: (context)=> const Center(heightFactor: 8, child: CircularProgressIndicator()),
                          ),
                        ),
                      );
                    });
              },
            ));
      },
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
      color: backGroundColor3,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const  <Widget>[
          Text("",style: TextStyle(fontSize: 20),)
          // IconButton(
          //     icon: const Icon(Icons.upload_rounded, color: Colors.white),
          //     onPressed: () {})
        ],
      ),
    );
  }
}
