import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  ///signout
  Future <void> signOut() async{
    FirebaseAuth.instance.signOut().then(
        (value){ emit(USerSignOutSuccessState());}
    );
  }
  ///patients
  Future createPatient()async{
    final docPatient = FirebaseFirestore.instance.collection('users').doc(uId).collection('patients').doc();
    final patient = PatientModel(
      id: docPatient.id,
      name: 'nada zaki',
      date: DateTime.now(),
      age: 21,
      email: 'andaana@gmail.com',
      gender: 'female',
      notes: '',
      phone: '0150866844'
    );
    final json = patient.toMap();
    docPatient.set(json).then((value)
    {
      emit(NewPatientCreatedSuccessState());
    })
    .catchError((error){
      emit(NewPatientCreatedErrorState(error.toString()));
    });

  }
  Stream<List<PatientModel>> getPatients(){
    return FirebaseFirestore.instance.collection('users').doc(uId).collection('patients')
    .snapshots()
    .map((snapshot) => 
    snapshot.docs.map(
            (doc) => PatientModel.fromJson(doc.data())).toList()
    );
