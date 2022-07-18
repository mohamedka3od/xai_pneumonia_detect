import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xai_pneumonia_detect/models/user_model.dart';
import 'package:xai_pneumonia_detect/modules/register/cubit/states.dart';

import '../../../models/login_model.dart';
import '../../../shared/components/constants.dart';



class RegisterCubit extends Cubit<RegisterStates>
{
  RegisterCubit() : super(RegisterInitialState());
  static RegisterCubit get(context) => BlocProvider.of(context);

  late LoginModel loginModel ;

  void userRegister({
    required String email,
    required String password,
    required String phone,
    required String name,
  }){
    emit(RegisterLoadingState());
    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password
    ).then((value) {
      // model = UserModel(email: email, name: name, phone: phone, uId: value.user!.uid);
      userCreate(
          email: email,
          phone: phone,
          name: name,
          uId: value.user!.uid,
      );
      emit(RegisterSuccessState());
    }).catchError((error){
      print("registerError :${error.toString()}");
      emit(RegisterErrorState(error.toString()));
    });

  }

  void userCreate({
    required String email,
    required String phone,
    required String name,
    required String uId,
  }){
     model = UserModel(
        email: email,
        name: name,
        phone: phone,
        uId: uId);
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap()).then((value) {
          emit(CreateUserSuccessState(uId));
    }).catchError((error){
      print(error.toString());
      emit(CreateUserErrorState(error));
    });

  }

  IconData suffix  = Icons.visibility_outlined;
  bool isPassword = true;
  void changePasswordVisibility (){
    isPassword = !isPassword;

    suffix =isPassword? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(RegisterChangePasswordVisibilityState());

  }

  ////google sign in
  Future<UserCredential> signInWithGoogle() async {
    emit(GoogleRegisterLoadingState());
    final GoogleSignIn googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    User? _user = (await FirebaseAuth.instance.signInWithCredential(credential)).user;
    //add to fireStore
    if(_user != null){
      final  QuerySnapshot resultQuery = await FirebaseFirestore.instance
          .collection("users")
          .where(
        'uId',
        isEqualTo: _user.uid,
      ).get();

      final List<DocumentSnapshot> _documentSnapshots = resultQuery.docs;
      if(_documentSnapshots.isEmpty){
        FirebaseFirestore.instance.collection("users").doc(_user.uid).set(
            {
              'uId': _user.uid,
              'email': _user.email,
              'phone': _user.phoneNumber,
              'name' : _user.displayName,
            }).then((value){
          model = UserModel(email: _user.email, name: _user.displayName, phone: _user.phoneNumber, uId: _user.uid);

          print('user data saved');
        }).catchError((error){
          print(error);
          emit(GoogleRegisterErrorState(error.toString()));
        });
      }
      else{
        FirebaseFirestore.instance.collection("users").doc(_user.uid).get().then((value) {
          model = UserModel.fromJson(value.data());
          emit(GoogleRegisterSuccessState(_user.uid));
        }).catchError((error){
          print(error);
          emit(GoogleRegisterSuccessState(_user.uid));
        });
      }
    }
    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }


}