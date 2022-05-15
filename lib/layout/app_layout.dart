import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xai_pneumonia_detect/shared/app_cubit/cubit.dart';
import 'package:xai_pneumonia_detect/shared/app_cubit/states.dart';
import '../modules/login_or_register/login_register_screen.dart';
import '../network/local/cache_helper.dart';
import '../shared/components/components.dart';

class AppLayout extends StatelessWidget {
  const AppLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){},
        builder: (context,state){
          return Scaffold(
            appBar: AppBar(
              title: const Text('XAI'),
            ),
            body: TextButton(
              onPressed: () {
                CacheHelper.removeData(key: 'uId').then((value) {
                  if (value){
                    navigateAndFinish(context, const LRScreen());
                  }
                });
              },
              child: const Text('SIGN OUT'),
            ),
          );
        },

    );
  }
}