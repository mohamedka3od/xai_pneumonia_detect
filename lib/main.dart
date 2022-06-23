import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:xai_pneumonia_detect/shared/app_cubit/cubit.dart';
import 'package:xai_pneumonia_detect/shared/app_cubit/states.dart';
import 'package:xai_pneumonia_detect/shared/bloc_observer.dart';
import 'package:xai_pneumonia_detect/shared/components/constants.dart';
import 'package:xai_pneumonia_detect/shared/style/themes.dart';


import 'modules/app_screens/module/page/profile.dart';
import 'modules/login_or_register/login_register_screen.dart';
import 'network/local/cache_helper.dart';
import 'network/remote/dio_helper.dart';
import 'on_boarding/on_boarding_screen.dart';

void main() {
  BlocOverrides.runZoned(
        () async {
      WidgetsFlutterBinding.ensureInitialized();
      await CacheHelper.init();
      DioHelper.init();
      await Firebase.initializeApp(
        // options: DefaultFirebaseOptions.currentPlatform,
      );
      bool isDark = CacheHelper.getData(key: 'isDark') ?? false;
      Widget widget;
      bool onBoarding = CacheHelper.getData(key: 'onBoarding') ?? false;
      uId = CacheHelper.getData(key: 'uId');
      if(onBoarding){
        if(uId != null){
          widget =  MainScreen();
        }
        else{
          widget = const LRScreen();
        }
      }
      else{
        widget = const OnBoardingScreen();
      }
      runApp(MyApp(isDark:isDark,startWidget:widget));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  final bool isDark;
  final Widget startWidget;
  const MyApp({required this.isDark,required this.startWidget, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => AppCubit(isDark)..getUserData()),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: lightTheme,
              themeMode: AppCubit.get(context).isDark ? ThemeMode.dark:ThemeMode.light,
              darkTheme: darkTheme,

              home:  Directionality(
                textDirection: TextDirection.ltr,
                child: startWidget,
              ));

        },
      ),
    );
  }
}
