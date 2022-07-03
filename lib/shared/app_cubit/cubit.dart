import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:xai_pneumonia_detect/models/patient_model.dart';
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
  void getUserData() async{
    emit(GetUSerLoadingState());
    await FirebaseFirestore.instance.collection('users').doc(uId)
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
  ///signout
  Future <void> signOut() async{
    FirebaseAuth.instance.signOut().then(
        (value){ emit(USerSignOutSuccessState());}
    );
  }
  ///patients
  Future createPatient({
    required String name,
    required int age,
    String? email,
    String? phone,
    required String gender,
    String? notes,
  })async{
    final docPatient = FirebaseFirestore.instance.collection('users').doc(uId).collection('patients').doc();
    final patient = PatientModel(
      id: docPatient.id,
      name: name,
      date: DateFormat.yMMMd().format(DateTime.now()),
      age: 21,
      email: email,
      gender: gender,
      notes: notes,
      phone: phone
    );
    final json = patient.toMap();
    docPatient.set(json).then((value)
    {
      emit(NewPatientCreatedSuccessState());
    })
    .catchError((error){
      emit(NewPatientCreatedErrorState(error.toString()));
    });
    return patient.id;

  }
  Future addPatientData({
  required int week,
  required String pid,
})async{
    final docPatient = FirebaseFirestore.instance.collection('users').doc(uId).collection('patients').doc(pid).collection('data').doc();
    final data = PatientInfoModel(mid: docPatient.id, pid: pid, week: week, date: DateFormat.yMMMd().format(DateTime.now()));
    docPatient.set(data.toMap())
        .then((value){
          emit(NewXrayAddedSuccessState());
    }).catchError((error){
      emit(NewXrayAddedErrorState(error));
    });
    return data.mid;
  }

  Future deletePatient({required pId}){
    return FirebaseFirestore.instance.collection('users').doc(uId).collection('patients').doc(pId).delete();
  }
  Stream<List<PatientModel>> getPatients(){
    return FirebaseFirestore.instance.collection('users').doc(uId).collection('patients').orderBy('date',descending: true)
    .snapshots()
    .map((snapshot) => 
    snapshot.docs.map(
            (doc) => PatientModel.fromJson(doc.data())).toList()
    );
  }
  Stream<List<PatientInfoModel>> getPatientData(String pid){
    return FirebaseFirestore.instance.collection('users').doc(uId).collection('patients').doc(pid).collection('data').orderBy('date',descending: true)
        .snapshots()
        .map((snapshot) =>
        snapshot.docs.map(
                (doc) => PatientInfoModel.fromJson(doc.data())).toList()
    );
  }



}
