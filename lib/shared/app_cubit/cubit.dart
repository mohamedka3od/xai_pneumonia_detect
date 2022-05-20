import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xai_pneumonia_detect/models/user_model.dart';
import 'package:xai_pneumonia_detect/shared/app_cubit/states.dart';
import 'package:xai_pneumonia_detect/shared/components/constants.dart';

import '../../network/local/cache_helper.dart';


class AppCubit extends Cubit<AppStates>{
  AppCubit(this.isDark) : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);
  ///Dark Mode
  bool isDark;
  void changeAppMode(){
    isDark=!isDark;
    CacheHelper.setBoolean(key: 'isDark', value: isDark);
    emit(AppChangeStateMode());
  }
  ///Get User Data from Firestore
  late UserModel model;
  void getUserData(){
    emit(GetUSerLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId)
        .get()
        .then((value) {
      // print(value.data());
      model = UserModel.fromJson(value.data());
      emit(GetUSerSuccessState());
    })
        .catchError((error){
      print(error.toString());
      emit(GetUSerErrorState(error.toString()));

    });

  }
  ///patient's list
  List patientsInfo=[{
    'name':'mohamed ali',
    'condition':'not available yet',
    'date':'15/5/2022'
  },];
  void addPatient(){
    patientsInfo = [
      {
        'name':'mohamed ali',
        'condition':'not available yet',
        'date':'15/5/2022'
      },
      {
        'name':'Ahmed Mostafa',
        'condition':'not available yet',
        'date':'23/5/2022'
      }
      ,{
        'name':'khaled Abd El Rahman ',
        'condition':'not available yet',
        'date':'30/3/2022'
      }
      ,{
        'name':'Mohamed Yasser',
        'condition':'not available yet',
        'date':'15/6/2022'
      }
      ,{
        'name':'mohamed Mahmoud',
        'condition':'not available yet',
        'date':'25/7/2022'
      },
      {
        'name':'Alaa Atef',
        'condition':'not available yet',
        'date':'9/8/2022'
      },
      {
        'name':'mohamed ali',
        'condition':'not available yet',
        'date':'15/5/2022'
      },
      {
        'name':'Ahmed Mostafa',
        'condition':'not available yet',
        'date':'23/5/2022'
      }
      ,{
        'name':'khaled Abd El Rahman ',
        'condition':'not available yet',
        'date':'30/3/2022'
      }
      ,{
        'name':'Mohamed Yasser',
        'condition':'not available yet',
        'date':'15/6/2022'
      }
      ,{
        'name':'mohamed Mahmoud',
        'condition':'not available yet',
        'date':'25/7/2022'
      },
      {
        'name':'Alaa Atef',
        'condition':'not available yet',
        'date':'9/8/2022'
      },
      {
        'name':'Ayman Atef',
        'condition':'not available yet',
        'date':'9/8/2022'
      }
    ];
    emit(NewPatientAddedSuccessState());
  }


}