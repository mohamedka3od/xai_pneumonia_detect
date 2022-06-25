import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:xai_pneumonia_detect/models/user_model.dart';
import 'package:xai_pneumonia_detect/modules/login/cubit/states.dart';

import '../../../models/login_model.dart';
import '../../../shared/components/constants.dart';



class LoginCubit extends Cubit<LoginStates>
{
  LoginCubit() : super(LoginInitialState());
  static LoginCubit get(context) => BlocProvider.of(context);

  late LoginModel loginModel ;

  void userLogin({
    required String email,
    required String password,
  }){
    emit(LoginLoadingState());
    FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password
    ).then((value) async{
     await FirebaseFirestore.instance.collection("users").doc(value.user!.uid).get().then((value) {
        model = UserModel.fromJson(value.data());
      });
      emit(LoginSuccessState(value.user!.uid));
    }).catchError((error){
      emit(LoginErrorState(error.toString()));
      print(error.toString());
    });
  }


  IconData suffix  = Icons.visibility_outlined;
  bool isPassword = true;
  void changePasswordVisibility (){
    isPassword = !isPassword;

    suffix =isPassword? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(LoginChangePasswordVisibilityState());

  }

  Future<UserCredential> signInWithGoogle() async {
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
          emit(GoogleLoginSuccessState(_user.uid));
        }).catchError((error){
          print(error);
          emit(GoogleLoginErrorState(error.toString()));
        });
      }
      else{
        FirebaseFirestore.instance.collection("users").doc(_user.uid).get().then((value) {
          model = UserModel.fromJson(value.data());
          emit(GoogleLoginSuccessState(_user.uid));
        }).catchError((error){
          print(error);
          emit(GoogleLoginErrorState(error.toString()));
        });
      }
    }
    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}