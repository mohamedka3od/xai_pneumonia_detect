import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
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
    String? imageUrl,
    required String gender,
    String? notes,
  })async{
    final docPatient = FirebaseFirestore.instance.collection('users').doc(uId).collection('patients').doc();
    final patient = PatientModel(
      id: docPatient.id,
      name: name,
      imageUrl: imageUrl,
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
    return patient;

  }
  Future addPatientData({
  required int week,
  required String pid,
  required String imageUrl,
  required String rate,
  required String predict,
})async{
      final docPatient = FirebaseFirestore.instance.collection('users').doc(uId).collection('patients').doc(pid).collection('data').doc();
      final data = PatientInfoModel(mid: docPatient.id, pid: pid, week: week, date: DateFormat.yMMMd().format(DateTime.now()),imageUrl: imageUrl,rate: rate,predict: predict);
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
  Future deleteResult({required pId,required xid}){
    return FirebaseFirestore.instance.collection('users').doc(uId).collection('patients').doc(pId).collection('data').doc(xid).delete();
  }
  Stream<List<PatientModel>> getPatients(){
    return FirebaseFirestore.instance.collection('users').doc(uId).collection('patients').orderBy('dateTime',descending: true)
    .snapshots()
    .map((snapshot) => 
    snapshot.docs.map(
            (doc) => PatientModel.fromJson(doc.data())).toList()
    );
  }
  String name = '';
  void changeName(String newName){
    name = newName;
    emit(SearchNameChangeState());
  }
  Stream<List<PatientModel>> searchPatients(){
    return FirebaseFirestore.instance.collection('users').doc(uId).collection('patients').where('name', isGreaterThanOrEqualTo:  name )
        .snapshots()
        .map((snapshot) =>
        snapshot.docs.map(
                (doc) => PatientModel.fromJson(doc.data())).toList()
    );
  }
  Stream<List<PatientModel>> getImportantPatients(){
    return FirebaseFirestore.instance.collection('users').doc(uId).collection('patients').orderBy('dateTime',descending: true).where('important', isEqualTo: true)
    .snapshots()
    .map((snapshot) => 
    snapshot.docs.map(
            (doc) => PatientModel.fromJson(doc.data())).toList()
    );
  }
  Stream<List<PatientInfoModel>> getPatientData(String pid){
    return FirebaseFirestore.instance.collection('users').doc(uId).collection('patients').doc(pid).collection('data').orderBy('dateTime',descending: true)
        .snapshots()
        .map((snapshot) =>
        snapshot.docs.map(
                (doc) => PatientInfoModel.fromJson(doc.data())).toList()
    );
  }

  File? patientImage;

  Future getPatientImage(ImageSource source) async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: source);
      if (pickedFile != null){
        patientImage = File(pickedFile.path);
        emit(PatientImagePickedSuccessState());
      }
      else{
        print('no image selected');
        emit(PatientImagePickedErrorState());
      }
    } on PlatformException catch (e) {
      print('failed:$e');
    }
  }
  void clearPatientImage(){
    patientImage=null;
    emit(PatientImageClearedState());
  }


  String patientImageUrl='';
  Future uploadPatientImage() async{
    if (patientImage == null) return;
    emit(StartPatientImageUploadState());
    return await FirebaseStorage.instance
        .ref()
        .child('users/$uId/patients/${Uri.file(patientImage!.path).pathSegments.last}')
        .putFile(patientImage!)
        .then((value)async{
         await value.ref.getDownloadURL().then((value){
            patientImageUrl = value;
            print("uri is :$patientImageUrl");
            patientImage!.delete();
            emit(PatientImageUploadSuccessState());
          }).catchError((error){
            emit(PatientImageUploadErrorState(error));
          });
    })
        .catchError((error){
      emit(PatientImageUploadErrorState(error));
    });
  }
  String xrayImageUrl='';
  Future uploadXrayImage(File image) async{
    return await FirebaseStorage.instance
        .ref()
        .child('users/$uId/patients/${Uri.file(image.path).pathSegments.last}')
        .putFile(image)
        .then((value)async{
         await value.ref.getDownloadURL().then((value){
            xrayImageUrl = value;
            print("xRay uri is :$xrayImageUrl");
            emit(XrayImageUploadSuccessState());
          }).catchError((error){
            emit(XrayImageUploadErrorState(error));
          });
    })
        .catchError((error){
      emit(PatientImageUploadErrorState(error));
    });
  }

  ///user image
  // String userProfileImageUrl='';
  // void uploadUserProfileImage(){
  //   FirebaseStorage.instance
  //       .ref()
  //       .child('users/$uId/profile/${Uri.file(const ProfileImgPicker().image!.path).pathSegments.last}')
  //       .putFile(const ProfileImgPicker().image!)
  //       .then((value){
  //         value.ref.getDownloadURL().then((value){
  //           userProfileImageUrl = value;
  //           emit(UserProfileImageUploadSuccessState());
  //         }).catchError((error){
  //           emit(UserProfileImageUploadErrorState(error));
  //         });
  //   })
  //       .catchError((error){
  //     emit(UserProfileImageUploadErrorState(error));
  //   });
  // }
 void changeImportantState(PatientModel model){
    FirebaseFirestore.instance.collection('users').doc(uId).collection('patients').doc(model.id)
        .update({'important':!model.important}).then((value) {
          emit(ChangeImportantSuccessState());
    }).catchError((error){
      emit(ChangeImportantErrorState(error));
    });

 }



}
