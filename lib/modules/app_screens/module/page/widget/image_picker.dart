import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:xai_pneumonia_detect/shared/app_cubit/cubit.dart';
import 'package:xai_pneumonia_detect/shared/app_cubit/states.dart';

import '../../../../../shared/style/colors.dart';

class ProfileImgPicker extends StatelessWidget {
  const ProfileImgPicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit = AppCubit.get(context);
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CircularProfileAvatar(
                '',
                radius: 50,
                backgroundColor: Colors.white,
                borderWidth: 5,
                borderColor: Colors.blue,
                elevation: 5.0,
                foregroundColor: Colors.blue,
                cacheImage: true,
                imageFit: BoxFit.cover,
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) => SimpleDialog(
                        title: const Text('Pick From'),
                        children: <Widget>[
                          SimpleDialogOption(
                            onPressed: () {
                              cubit.getPatientImage(ImageSource.gallery);
                              Navigator.pop(context);
                            },
                            child: const Text('Gallery'),
                          ),
                          SimpleDialogOption(
                            onPressed: () {
                              cubit.getPatientImage(ImageSource.camera);
                              Navigator.pop(context);
                            },
                            child: const Text('Camera'),
                          ),
                        ],
                      ));
                },
                // sets on tap
                showInitialTextAbovePicture: false,
                child:cubit.patientImage != null
                    ?Image.file(cubit.patientImage!, fit: BoxFit.cover,): const Icon(Icons.add_a_photo_outlined,color: defaultColor,size: 50,),
              ),
            ],
          ),
        );
      },
    );
  }
}


